import 'dart:math';
import 'dart:typed_data';

import 'package:interview_arena_server/src/ai/embeddings.dart';
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';

/// Deterministic stand-in for Claude (no network, no key).
class FakeInterviewAi implements InterviewAi {
  int questions = 0, partials = 0, evaluations = 0, summaries = 0, parses = 0;

  @override
  Future<GeneratedQuestion> nextQuestion(InterviewContext ctx) async {
    questions++;
    return (
      prompt: 'Q${ctx.turns.length + 1} for ${ctx.targetRole}',
      category: QuestionCategory.technical,
      targetSkills: ['dart'],
      isFollowUp: ctx.turns.isNotEmpty,
    );
  }

  @override
  Future<InterviewScores> scorePartial(
    InterviewContext ctx,
    String question,
    String partialAnswer,
  ) async {
    partials++;
    return InterviewScores(communication: 40, confidence: 41);
  }

  @override
  Future<AnswerEvaluation> evaluateAnswer(
    InterviewContext ctx,
    String question,
    String answer,
  ) async {
    evaluations++;
    return (
      scores: InterviewScores(
        communication: 70,
        confidence: 60,
        technicalDepth: 50,
        completeness: 40,
        structure: 30,
      ),
      feedback: AnswerFeedback(
        summary: 'ok',
        strengths: ['clear'],
        improvements: ['depth'],
        skillDeltas: {'Dart': -15},
      ),
    );
  }

  @override
  Future<InterviewReport> report(
    InterviewContext ctx,
    InterviewScores scores,
  ) async {
    summaries++;
    return InterviewReport(
      summary: 'Fake summary of ${ctx.turns.length} turns',
      strengths: const ['Clear structure'],
      improvements: const ['Quantify impact'],
      focusAreas: const ['Caching'],
    );
  }

  @override
  Future<ParsedResume> parseResume(Uint8List pdfBytes) async {
    parses++;
    return ParsedResume(
      fullName: 'Ada Lovelace',
      headline: 'Engineer',
      yearsOfExperience: 7,
      skills: [ExtractedSkill(name: 'Dart', confidence: 0.9, evidence: 'x')],
      experience: [
        WorkExperience(title: 'Engineer', company: 'ACME', highlights: ['a']),
      ],
      education: ['BSc'],
    );
  }
}

/// Unit vector along a fixed direction plus a small seeded perturbation.
List<double> fakeVector(int seed) {
  final r = Random(seed);
  final v = [
    for (var i = 0; i < embeddingDimension; i++) 1 + r.nextDouble() * 0.01,
  ];
  final n = sqrt(v.fold<double>(0, (s, x) => s + x * x));
  return [for (final x in v) x / n];
}

class FakeEmbedder implements EmbeddingClient {
  int calls = 0;
  @override
  String get modelId => 'fake-embed';
  @override
  Future<List<List<double>>> embed(
    List<String> texts, {
    required bool isQuery,
  }) async {
    calls++;
    return [for (var i = 0; i < texts.length; i++) fakeVector(i)];
  }
}
