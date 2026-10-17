// Live smoke test of every Claude route, using the same client construction
// as the server's interviewAiFactory. Costs a few cents per run.
//
// Usage (from interview_arena_server/):
//   ANTHROPIC_API_KEY=... dart run tool/smoke_claude.dart [--parse-only] [resume.pdf]
import 'dart:convert';
import 'dart:io';

import 'package:interview_arena_server/src/ai/anthropic_client.dart';
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/costs/pricing.dart';

Future<void> main(List<String> args) async {
  final key = Platform.environment['ANTHROPIC_API_KEY'];
  if (key == null || key.isEmpty) {
    stderr.writeln('Set ANTHROPIC_API_KEY.');
    exit(64);
  }
  final ai = ClaudeInterviewAi(
    ClaudeHttpClient(apiKey: key),
    // Like the line the server logs per response.
    onUsage: (route, model, usage) {
      int tokens(String key) => (usage[key] as num?)?.toInt() ?? 0;
      final cost = claudeCostUsd(
        model,
        inputTokens: tokens('input_tokens'),
        outputTokens: tokens('output_tokens'),
        cacheReadTokens: tokens('cache_read_input_tokens'),
        cacheWriteTokens: tokens('cache_creation_input_tokens'),
      );
      stdout.writeln(
        'ai ${route.name} model=$model '
        'in=${tokens('input_tokens')} out=${tokens('output_tokens')} '
        'cacheRead=${tokens('cache_read_input_tokens')} '
        'cacheWrite=${tokens('cache_creation_input_tokens')} '
        'cost=${cost == null ? 'unknown' : '\$${cost.toStringAsFixed(6)}'}',
      );
    },
  );
  final parseOnly = args.contains('--parse-only');
  final files = args.where((a) => a != '--parse-only').toList();

  Future<T> timed<T>(String label, Future<T> Function() run) async {
    final sw = Stopwatch()..start();
    final result = await run();
    stdout.writeln('--- $label (${sw.elapsedMilliseconds} ms)');
    return result;
  }

  String json(Object? o) => const JsonEncoder.withIndent('  ').convert(o);

  if (!parseOnly) await _interviewRoutes(ai, timed, json);

  if (files.isNotEmpty) {
    final pdf = await File(files.first).readAsBytes();
    final parsed = await timed('parseResume', () => ai.parseResume(pdf));
    stdout.writeln(json(parsed.toJson()));
  }
  exit(0);
}

Future<void> _interviewRoutes(
  ClaudeInterviewAi ai,
  Future<T> Function<T>(String, Future<T> Function()) timed,
  String Function(Object?) json,
) async {
  final ctx = InterviewContext(
    targetRole: 'Senior Backend Engineer',
    maxQuestions: 5,
    resume: null,
    turns: const [],
  );

  final q = await timed('nextQuestion', () => ai.nextQuestion(ctx));
  stdout.writeln('[${q.category.name}] ${q.prompt}');
  stdout.writeln('targetSkills: ${q.targetSkills}');

  const answer =
      'I would wrap the debit and credit in one database transaction with '
      'row-level locks taken in a consistent account-id order to avoid '
      'deadlocks, and require an idempotency key from the client so a retry '
      'after a timeout returns the original result instead of transferring '
      'twice.';

  final partial = await timed(
    'scorePartial',
    () => ai.scorePartial(ctx, q.prompt, answer.substring(0, 80)),
  );
  stdout.writeln(json(partial.toJson()));

  final eval = await timed(
    'evaluateAnswer',
    () => ai.evaluateAnswer(ctx, q.prompt, answer),
  );
  stdout.writeln(json(eval.scores.toJson()));
  stdout.writeln(json(eval.feedback.toJson()));

  final done = InterviewContext(
    targetRole: ctx.targetRole,
    maxQuestions: ctx.maxQuestions,
    resume: null,
    turns: [
      (
        orderIndex: 0,
        category: q.category,
        question: q.prompt,
        answer: answer,
      ),
    ],
  );
  final report = await timed('report', () => ai.report(done, eval.scores));
  stdout.writeln(json(report.toJson()));
}
