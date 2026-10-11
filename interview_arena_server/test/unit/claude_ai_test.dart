import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:interview_arena_server/src/ai/anthropic_client.dart';
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:test/test.dart';

String _sse(List<(String, Map<String, dynamic>)> events) => [
  for (final (name, data) in events)
    'event: $name\ndata: ${jsonEncode(data)}\n\n',
].join();

String _jsonReply(
  Map<String, dynamic> json, {
  String stop = 'end_turn',
}) => _sse([
  (
    'message_start',
    {
      'type': 'message_start',
      'message': {
        'id': 'msg_1',
        'model': 'claude-opus-5-5',
        'usage': {'input_tokens': 10},
      },
    },
  ),
  (
    'content_block_start',
    {
      'type': 'content_block_start',
      'index': 0,
      'content_block': {'type': 'thinking', 'thinking': ''},
    },
  ),
  (
    'content_block_delta',
    {
      'type': 'content_block_delta',
      'index': 0,
      'delta': {'type': 'signature_delta', 'signature': 'sig'},
    },
  ),
  ('content_block_stop', {'type': 'content_block_stop', 'index': 0}),
  ('ping', {'type': 'ping'}),
  (
    'content_block_start',
    {
      'type': 'content_block_start',
      'index': 1,
      'content_block': {'type': 'text', 'text': ''},
    },
  ),
  (
    'content_block_delta',
    {
      'type': 'content_block_delta',
      'index': 1,
      'delta': {'type': 'text_delta', 'text': jsonEncode(json).substring(0, 5)},
    },
  ),
  (
    'content_block_delta',
    {
      'type': 'content_block_delta',
      'index': 1,
      'delta': {'type': 'text_delta', 'text': jsonEncode(json).substring(5)},
    },
  ),
  ('content_block_stop', {'type': 'content_block_stop', 'index': 1}),
  (
    'message_delta',
    {
      'type': 'message_delta',
      'delta': {'stop_reason': stop},
      'usage': {'output_tokens': 20},
    },
  ),
  ('message_stop', {'type': 'message_stop'}),
]);

void main() {
  late http.BaseRequest lastRequest;
  late Map<String, dynamic> lastBody;

  ClaudeInterviewAi aiReplying(String sse) => ClaudeInterviewAi(
    ClaudeHttpClient(
      apiKey: 'dummy',
      maxRetries: 0,
      httpClient: MockClient.streaming((request, body) async {
        lastRequest = request;
        lastBody =
            jsonDecode(await body.bytesToString()) as Map<String, dynamic>;
        return http.StreamedResponse(
          Stream.value(utf8.encode(sse)),
          200,
          headers: {'content-type': 'text/event-stream', 'request-id': 'req_1'},
        );
      }),
    ),
  );

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
        'skillDeltas': [
          {'skill': 'sql', 'delta': -2.5},
        ],
      }),
    );
    final r = await ai.evaluateAnswer(ctx, 'Q', 'A');
    expect(lastRequest.headers['x-api-key'], 'dummy');
    expect(lastRequest.headers['anthropic-version'], '2023-06-01');
    expect(
      lastRequest.headers['anthropic-beta'],
      'server-side-fallback-2026-07-01',
    );
    expect(lastBody['model'], 'claude-opus-5-5');
    expect(lastBody['stream'], isTrue);
    expect(lastBody['fallbacks'], 'default');
    expect(lastBody.containsKey('thinking'), isFalse); // always on for Opus 5.5
    expect(lastBody['output_config']['effort'], 'high');
    expect(lastBody['output_config']['format']['type'], 'json_schema');
    expect(
      lastBody['output_config']['format']['schema']['additionalProperties'],
      isFalse,
    );
    expect(lastBody['system'][0]['cache_control'], {'type': 'ephemeral'});
    expect(r.scores.communication, 72);
    expect(
      r.scores.confidence,
      100,
    ); // clamped in code (no schema minimum/maximum)
    expect(r.scores.structure, 0);
    expect(r.feedback.skillDeltas, {'sql': -2.5});
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
