import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:interview_arena_server/src/ai/anthropic_client.dart';
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:test/test.dart';

/// A Message response whose answer follows a thinking block.
String _jsonReply(
  Map<String, dynamic> json, {
  String stop = 'end_turn',
  String model = 'claude-sonnet-5-5',
}) => jsonEncode({
  'id': 'msg_1',
  'type': 'message',
  'model': model,
  'content': [
    {'type': 'thinking', 'thinking': '', 'signature': 'sig'},
    {'type': 'text', 'text': jsonEncode(json)},
  ],
  'stop_reason': stop,
  'usage': {
    'input_tokens': 10,
    'output_tokens': 20,
    'cache_read_input_tokens': 5,
  },
});

void main() {
  late http.BaseRequest lastRequest;
  late Map<String, dynamic> lastBody;
  late List<(String, String, Map<String, dynamic>)> usages;

  ClaudeInterviewAi aiReplying(String reply) {
    usages = [];
    return ClaudeInterviewAi(
      ClaudeHttpClient(
        apiKey: 'dummy',
        maxRetries: 0,
        httpClient: MockClient((request) async {
          lastRequest = request;
          lastBody = jsonDecode(request.body) as Map<String, dynamic>;
          return http.Response(
            reply,
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      ),
      onUsage: (route, model, usage) => usages.add((route.name, model, usage)),
    );
  }

  final ctx = InterviewContext(
    targetRole: 'Backend',
    maxQuestions: 6,
    resume: null,
    turns: [],
  );

  test('evaluateAnswer sends the documented request shape and parses the '
      'structured JSON that follows a thinking block', () async {
    final ai = aiReplying(
      _jsonReply({
        'communication': 72,
        'confidence': 140,
        'technicalDepth': 55,
        'completeness': 40,
        'structure': -3,
        'summary': 's',
        'strengths': ['a'],
        'improvements': ['b'],
      }),
    );
    final r = await ai.evaluateAnswer(ctx, 'Q', 'A');
    expect(lastRequest.headers['x-api-key'], 'dummy');
    expect(lastRequest.headers['anthropic-version'], '2023-06-01');
    expect(
      lastRequest.headers['anthropic-beta'],
      'server-side-fallback-2026-07-01',
    );
    expect(lastBody['model'], 'claude-sonnet-5-5');
    expect(lastBody.containsKey('stream'), isFalse);
    expect(lastBody['fallbacks'], 'default');
    expect(lastBody.containsKey('thinking'), isFalse); // adaptive by default
    expect(lastBody['output_config']['effort'], 'medium');
    expect(lastBody['output_config']['format']['type'], 'json_schema');
    expect(
      lastBody['output_config']['format']['schema']['additionalProperties'],
      isFalse,
    );
    expect(lastBody['system'], ClaudeInterviewAi.scoringSystem);
    expect(r.scores.communication, 72);
    expect(
      r.scores.confidence,
      100,
    ); // clamped in code (no schema minimum/maximum)
    expect(r.scores.structure, 0);
    expect(r.feedback.improvements, ['b']);
    expect(usages.single.$1, 'evaluation');
    expect(usages.single.$2, 'claude-sonnet-5-5');
    expect(usages.single.$3['cache_read_input_tokens'], 5);
  });

  test('scorePartial runs on Haiku without a server-side fallback', () async {
    final ai = aiReplying(
      _jsonReply({
        'communication': 50,
        'confidence': 50,
        'technicalDepth': 50,
        'completeness': 50,
        'structure': 50,
      }, model: 'claude-haiku-5-5'),
    );
    await ai.scorePartial(ctx, 'Q', 'A');
    expect(lastBody['model'], 'claude-haiku-5-5');
    expect(lastBody['output_config']['effort'], 'low');
    expect(lastBody.containsKey('fallbacks'), isFalse);
    expect(lastRequest.headers.containsKey('anthropic-beta'), isFalse);
    expect(usages.single.$1, 'partial');
  });

  test('a refusal surfaces as AiUnavailableException(refusal)', () async {
    final ai = aiReplying(_jsonReply({'communication': 1}, stop: 'refusal'));
    await expectLater(
      ai.scorePartial(ctx, 'Q', 'A'),
      throwsA(
        isA<AiUnavailableException>().having((e) => e.code, 'code', 'refusal'),
      ),
    );
  });

  test('parseResume sends a base64 document block before the text block and '
      'maps nullable fields', () async {
    final ai = aiReplying(
      _jsonReply({
        'fullName': 'Ada',
        'headline': null,
        'yearsOfExperience': null,
        'skills': [
          {'name': 'Dart', 'category': null, 'confidence': 2, 'evidence': null},
        ],
        'experience': [
          {
            'title': 'Eng',
            'company': null,
            'startDate': '2019-05',
            'endDate': null,
            'highlights': [],
          },
        ],
        'education': [],
      }),
    );
    final pdf = Uint8List.fromList(utf8.encode('%PDF-1.7 fake'));
    final p = await ai.parseResume(pdf);
    expect(lastBody['model'], 'claude-haiku-5-5');
    expect(lastBody.containsKey('fallbacks'), isFalse);
    final content = lastBody['messages'][0]['content'] as List;
    expect(content[0]['type'], 'document');
    expect(content[0]['source']['media_type'], 'application/pdf');
    expect(content[0]['source']['data'], base64Encode(pdf));
    expect((content[0]['source']['data'] as String).contains('\n'), isFalse);
    expect(content[1]['type'], 'text');
    expect(p.fullName, 'Ada');
    expect(p.headline, isNull);
    expect(p.skills.single.confidence, 1.0);
    expect(p.experience.single.startDate, '2019-05');
  });

  test(
    'nextQuestion puts the cache breakpoint on the last transcript block',
    () async {
      final ai = aiReplying(
        _jsonReply({
          'prompt': 'Why Dart?',
          'category': 'SystemDesign',
          'targetSkills': ['dart'],
          'isFollowUp': true,
        }),
      );
      final q = await ai.nextQuestion(
        InterviewContext(
          targetRole: 'Backend',
          maxQuestions: 6,
          resume: null,
          turns: [
            (
              orderIndex: 0,
              category: QuestionCategory.behavioral,
              question: 'q1',
              answer: 'a1',
            ),
          ],
        ),
      );
      final content = lastBody['messages'][0]['content'] as List;
      expect(content, hasLength(2));
      expect(content.last['cache_control'], {'type': 'ephemeral'});
      expect(content.first.containsKey('cache_control'), isFalse);
      expect(lastBody['output_config']['effort'], 'low');
      expect(
        q.category,
        QuestionCategory.systemDesign,
      ); // case-insensitive enum
    },
  );
}
