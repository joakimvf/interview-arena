import 'dart:convert';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'anthropic_client.dart';

/// One answered turn of the interview, fed back to the interviewer model.
typedef InterviewTurn = ({
  int orderIndex,
  QuestionCategory category,
  String question,
  String answer,
});

/// Everything the AI needs about one interview. Built from DB rows each call.
class InterviewContext {
  InterviewContext({
    required this.targetRole,
    required this.maxQuestions,
    required this.resume,
    required this.turns,
  });
  final String targetRole;
  final int maxQuestions;
  final ParsedResume? resume;
  final List<InterviewTurn> turns;
}

typedef GeneratedQuestion = ({
  String prompt,
  QuestionCategory category,
  List<String> targetSkills,
  bool isFollowUp,
});

typedef AnswerEvaluation = ({InterviewScores scores, AnswerFeedback feedback});

/// The model declined (`stop_reason: refusal`) or ran out of tokens.
class AiUnavailableException implements Exception {
  AiUnavailableException(this.code, [this.detail]);

  /// refusal | max_tokens | no_text | api_error
  final String code;
  final String? detail;
  @override
  String toString() => 'AiUnavailableException($code, $detail)';
}

/// Test seam: everything AI-related goes through this interface.
abstract interface class InterviewAi {
  Future<GeneratedQuestion> nextQuestion(InterviewContext ctx);
  Future<InterviewScores> scorePartial(
    InterviewContext ctx,
    String question,
    String partialAnswer,
  );
  Future<AnswerEvaluation> evaluateAnswer(
    InterviewContext ctx,
    String question,
    String answer,
  );

  /// Whole-interview feedback once the interview ends.
  Future<InterviewReport> report(InterviewContext ctx, InterviewScores scores);
  Future<ParsedResume> parseResume(Uint8List pdfBytes);
}

/// Overridable in tests (same isolate as withServerpod's in-process server).
/// Endpoints are constructed by generated code, so there is no constructor
/// injection.
InterviewAi Function(Session session) interviewAiFactory = (session) {
  final key = session.passwords['anthropicApiKey'];
  if (key == null || key.isEmpty) {
    throw AiUnavailableException('not_configured', 'anthropicApiKey missing');
  }
  return ClaudeInterviewAi(
    ClaudeHttpClient(apiKey: key),
    onUsage: (route, model, usage) => session.log(
      'claude ${route.name} model=$model '
      'in=${usage['input_tokens']} out=${usage['output_tokens']} '
      'cacheRead=${usage['cache_read_input_tokens'] ?? 0} '
      'cacheWrite=${usage['cache_creation_input_tokens'] ?? 0}',
    ),
  );
};

/// Per-route model + effort, sized to the job: Haiku for the high-volume or
/// extraction routes, Sonnet where the interviewer's judgment shows.
class ClaudeRoute {
  const ClaudeRoute(
    this.name,
    this.model,
    this.effort,
    this.maxTokens, {
    this.serverFallback = true,
  });
  final String name;
  final String model;
  final String effort;

  /// Includes thinking tokens, which can't be turned off on these models.
  final int maxTokens;

  /// Whether to ask for a server-side fallback model on a refusal. Haiku 5.5
  /// has none, so its routes leave it out.
  final bool serverFallback;
}

/// Called after every Claude response with its `usage` block.
typedef ClaudeUsageListener =
    void Function(ClaudeRoute route, String model, Map<String, dynamic> usage);

class ClaudeInterviewAi implements InterviewAi {
  ClaudeInterviewAi(this._api, {this.onUsage});
  final ClaudeHttpClient _api;
  final ClaudeUsageListener? onUsage;

  static const question = ClaudeRoute(
    'question',
    'claude-sonnet-5-5',
    'low',
    4000,
  );

  /// Runs every few seconds while the candidate speaks: cheap and fast.
  static const partial = ClaudeRoute(
    'partial',
    'claude-haiku-5-5',
    'low',
    2000,
    serverFallback: false,
  );
  static const evaluation = ClaudeRoute(
    'evaluation',
    'claude-sonnet-5-5',
    'medium',
    8000,
  );
  static const summary = ClaudeRoute(
    'summary',
    'claude-sonnet-5-5',
    'medium',
    8000,
  );
  static const resumeParse = ClaudeRoute(
    'resumeParse',
    'claude-haiku-5-5',
    'low',
    16000,
    serverFallback: false,
  );

  static const fallbackBeta = 'server-side-fallback-2026-07-01';

  // Frozen system prompts: never interpolate per-request data here. They are
  // below the 512-token cache minimum on their own; the interview transcript
  // routes cache through the breakpoint on the last transcript block instead.
  static const interviewerSystem =
      'You are a senior interviewer running a live mock job interview. '
      'You receive the target role, the candidate resume as JSON, and the '
      'transcript so far (each block: question number, question, answer). '
      'Ask exactly one next question. Adapt: follow up on vague or shallow '
      'answers, probe claimed skills from the resume, and vary categories. '
      'If the transcript is empty, ask a warm opening question about the '
      'candidate background relevant to the role. Hold the whole interview '
      'in the language given by the language field of the resume (English if '
      'there is none).';
  static const scoringSystem =
      'You are an interview coach scoring one answer. Score each dimension '
      'from 0 to 100: communication, confidence, technicalDepth, completeness, '
      'structure. Be calibrated: 50 is an average hireable answer. Give short, '
      'actionable feedback addressed to the candidate. Write the feedback '
      'in the language the candidate answered in.';
  static const partialSystem =
      'You estimate live interview scores (0-100 per dimension) for an answer '
      'that is still being spoken. Judge only what is there so far.';
  static const summarySystem =
      'You debrief a candidate after a completed mock interview, addressing '
      'them directly. Write: summary (3-5 sentences: overall impression and '
      'how they would come across to a real interviewer); strengths (2-4 '
      'specific things they did well, citing their answers); improvements '
      '(2-4 concrete, actionable changes for next time); focusAreas (2-5 '
      'short topic names to study next, e.g. "Database sharding"). Write '
      'everything in the language the candidate answered in.';
  static const resumeSystem =
      'Extract the candidate profile from the resume. Use only facts present '
      'in the document. Use null when a field is unknown. Also return '
      'language: the BCP 47 tag, with region, of the language the resume is '
      'written in (e.g. sv-SE, en-US); and suggestedRoles: 3-5 job titles '
      'this candidate could realistically interview for next given their '
      'actual experience, written in the language of the resume.';

  static final _scoreProps = {
    for (final k in [
      'communication',
      'confidence',
      'technicalDepth',
      'completeness',
      'structure',
    ])
      k: {'type': 'number'},
  };

  static Map<String, dynamic> _obj(
    Map<String, dynamic> props, {
    List<String>? required,
  }) => {
    'type': 'object',
    'properties': props,
    'required': required ?? props.keys.toList(),
    'additionalProperties': false,
  };

  static const _str = {'type': 'string'};
  static const _strList = {
    'type': 'array',
    'items': {'type': 'string'},
  };
  static const _nullableStr = {
    'anyOf': [
      {'type': 'string'},
      {'type': 'null'},
    ],
  };

  static final questionSchema = _obj({
    'prompt': _str,
    'category': {
      'type': 'string',
      'enum': [for (final c in QuestionCategory.values) c.name],
    },
    'targetSkills': _strList,
    'isFollowUp': {'type': 'boolean'},
  });

  static final scoresSchema = _obj(_scoreProps);

  static final evaluationSchema = _obj({
    ..._scoreProps,
    'summary': _str,
    'strengths': _strList,
    'improvements': _strList,
  });

  static final reportSchema = _obj({
    'summary': _str,
    'strengths': _strList,
    'improvements': _strList,
    'focusAreas': _strList,
  });

  static final resumeSchema = _obj({
    'fullName': _nullableStr,
    'headline': _nullableStr,
    'yearsOfExperience': {
      'anyOf': [
        {'type': 'number'},
        {'type': 'null'},
      ],
    },
    'skills': {
      'type': 'array',
      'items': _obj({
        'name': _str,
        'category': _nullableStr,
        'confidence': {'type': 'number'},
        'evidence': _nullableStr,
      }),
    },
    'experience': {
      'type': 'array',
      'items': _obj({
        'title': _str,
        'company': _nullableStr,
        'startDate': _nullableStr,
        'endDate': _nullableStr,
        'highlights': _strList,
      }),
    },
    'education': _strList,
    'language': _str,
    'suggestedRoles': _strList,
  });

  /// Append-only content blocks: [context] + one block per answered turn.
  /// Each request is a single user turn, so no thinking blocks are ever
  /// replayed. The cache breakpoint on the last block lets the next request
  /// (same blocks + one more) read it.
  List<Map<String, dynamic>> _transcriptBlocks(InterviewContext ctx) {
    final blocks = <Map<String, dynamic>>[
      {
        'type': 'text',
        'text':
            'Target role: ${ctx.targetRole}\n'
            'Planned questions: ${ctx.maxQuestions}\n'
            'Resume JSON: ${jsonEncode(ctx.resume?.toJson())}',
      },
      for (final t in ctx.turns)
        {
          'type': 'text',
          'text':
              'Question ${t.orderIndex + 1} (${t.category.name}): '
              '${t.question}\nAnswer: ${t.answer}',
        },
    ];
    blocks.last['cache_control'] = {'type': 'ephemeral'};
    return blocks;
  }

  Map<String, dynamic> _body(
    ClaudeRoute r,
    String system,
    List<Map<String, dynamic>> content,
    Map<String, dynamic> schema,
  ) => {
    'model': r.model,
    'max_tokens': r.maxTokens,
    if (r.serverFallback) 'fallbacks': 'default',
    'output_config': {
      'effort': r.effort,
      'format': {'type': 'json_schema', 'schema': schema},
    },
    'system': system,
    'messages': [
      {'role': 'user', 'content': content},
    ],
  };

  /// Sends the request for [r] and returns the decoded JSON object from the
  /// first text block.
  Future<Map<String, dynamic>> _json(
    ClaudeRoute r,
    String system,
    List<Map<String, dynamic>> content,
    Map<String, dynamic> schema,
  ) async {
    final m = await _api.create(
      _body(r, system, content, schema),
      extraBetas: r.serverFallback ? const [fallbackBeta] : const [],
    );
    if (m['usage'] case final Map usage) {
      onUsage?.call(
        r,
        m['model'] as String? ?? r.model,
        Map<String, dynamic>.from(usage),
      );
    }
    switch (m['stop_reason']) {
      case 'refusal':
        throw AiUnavailableException(
          'refusal',
          (m['stop_details'] as Map?)?['category'] as String?,
        );
      case 'max_tokens':
        throw AiUnavailableException('max_tokens');
    }
    final text = firstText(m);
    if (text == null) throw AiUnavailableException('no_text');
    return jsonDecode(text) as Map<String, dynamic>;
  }

  static double _clamp(Object? v) =>
      ((v as num?)?.toDouble() ?? 0).clamp(0, 100).toDouble();

  static InterviewScores _scores(Map<String, dynamic> j) => InterviewScores(
    communication: _clamp(j['communication']),
    confidence: _clamp(j['confidence']),
    technicalDepth: _clamp(j['technicalDepth']),
    completeness: _clamp(j['completeness']),
    structure: _clamp(j['structure']),
  );

  @override
  Future<GeneratedQuestion> nextQuestion(InterviewContext ctx) async {
    final j = await _json(
      question,
      interviewerSystem,
      _transcriptBlocks(ctx),
      questionSchema,
    );
    final cat = (j['category'] as String).toLowerCase();
    return (
      prompt: j['prompt'] as String,
      category: QuestionCategory.values.firstWhere(
        (c) => c.name.toLowerCase() == cat, // enum casing is not guaranteed
        orElse: () => QuestionCategory.behavioral,
      ),
      targetSkills: [for (final s in j['targetSkills'] as List) s as String],
      isFollowUp: j['isFollowUp'] as bool,
    );
  }

  @override
  Future<InterviewScores> scorePartial(
    InterviewContext ctx,
    String question,
    String partialAnswer,
  ) async {
    final j = await _json(partial, partialSystem, [
      {'type': 'text', 'text': 'Role: ${ctx.targetRole}'},
      {
        'type': 'text',
        'text': 'Question: $question\nAnswer so far: $partialAnswer',
      },
    ], scoresSchema);
    return _scores(j);
  }

  @override
  Future<AnswerEvaluation> evaluateAnswer(
    InterviewContext ctx,
    String question,
    String answer,
  ) async {
    final j = await _json(evaluation, scoringSystem, [
      {'type': 'text', 'text': 'Role: ${ctx.targetRole}'},
      {'type': 'text', 'text': 'Question: $question\nAnswer: $answer'},
    ], evaluationSchema);
    return (
      scores: _scores(j),
      feedback: AnswerFeedback(
        summary: j['summary'] as String,
        strengths: [for (final s in j['strengths'] as List) s as String],
        improvements: [for (final s in j['improvements'] as List) s as String],
      ),
    );
  }

  @override
  Future<InterviewReport> report(
    InterviewContext ctx,
    InterviewScores scores,
  ) async {
    final blocks = _transcriptBlocks(ctx)
      ..add({'type': 'text', 'text': 'Final scores: ${jsonEncode(scores)}'});
    final j = await _json(summary, summarySystem, blocks, reportSchema);
    List<String> strings(String key) => [
      for (final s in j[key] as List) s as String,
    ];
    return InterviewReport(
      summary: j['summary'] as String,
      strengths: strings('strengths'),
      improvements: strings('improvements'),
      focusAreas: strings('focusAreas'),
    );
  }

  @override
  Future<ParsedResume> parseResume(Uint8List pdfBytes) async {
    final j = await _json(resumeParse, resumeSystem, [
      {
        'type': 'document',
        'source': {
          'type': 'base64',
          'media_type': 'application/pdf',
          'data': base64Encode(pdfBytes), // no newlines
        },
      },
      {'type': 'text', 'text': 'Extract the profile.'},
    ], resumeSchema);
    return ParsedResume(
      fullName: j['fullName'] as String?,
      headline: j['headline'] as String?,
      yearsOfExperience: (j['yearsOfExperience'] as num?)?.toDouble(),
      skills: [
        for (final s in (j['skills'] as List).cast<Map>())
          ExtractedSkill(
            name: s['name'] as String,
            category: s['category'] as String?,
            confidence: ((s['confidence'] as num?)?.toDouble() ?? 0.5)
                .clamp(0, 1)
                .toDouble(),
            evidence: s['evidence'] as String?,
          ),
      ],
      experience: [
        for (final e in (j['experience'] as List).cast<Map>())
          WorkExperience(
            title: e['title'] as String,
            company: e['company'] as String?,
            startDate: e['startDate'] as String?,
            endDate: e['endDate'] as String?,
            highlights: [for (final h in e['highlights'] as List) h as String],
          ),
      ],
      education: [for (final s in j['education'] as List) s as String],
      language: j['language'] as String?,
      suggestedRoles: [
        for (final s in (j['suggestedRoles'] as List?) ?? const []) s as String,
      ],
    );
  }
}
