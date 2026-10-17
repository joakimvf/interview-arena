import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pricing.dart';

/// Who and what an AI call was for, stored with its cost.
typedef AiUsageContext = ({
  UuidValue? authUserId,
  int? interviewSessionId,
  int? resumeId,
});

/// Records every paid AI call in `ai_usage` and logs it with its cost.
/// Never throws: cost tracking must not break an interview.
abstract final class AiUsageTracker {
  static Future<void> recordClaude(
    Session session, {
    required String feature,
    required String model,
    required Map<String, dynamic> usage,
    AiUsageContext? context,
  }) {
    int tokens(String key) => (usage[key] as num?)?.toInt() ?? 0;
    final input = tokens('input_tokens');
    final output = tokens('output_tokens');
    final cacheRead = tokens('cache_read_input_tokens');
    final cacheWrite = tokens('cache_creation_input_tokens');
    return _record(
      session,
      AiUsage(
        feature: feature,
        model: model,
        authUserId: context?.authUserId,
        interviewSessionId: context?.interviewSessionId,
        resumeId: context?.resumeId,
        inputTokens: input,
        outputTokens: output,
        cacheReadTokens: cacheRead,
        cacheWriteTokens: cacheWrite,
        costUsd: claudeCostUsd(
          model,
          inputTokens: input,
          outputTokens: output,
          cacheReadTokens: cacheRead,
          cacheWriteTokens: cacheWrite,
        ),
      ),
    );
  }

  static Future<void> recordVoice(
    Session session, {
    required String model,
    required int characters,
    AiUsageContext? context,
  }) => _record(
    session,
    AiUsage(
      feature: 'voice',
      model: model,
      authUserId: context?.authUserId,
      interviewSessionId: context?.interviewSessionId,
      characters: characters,
      costUsd: voiceCostUsd(session, characters),
    ),
  );

  static Future<void> _record(Session session, AiUsage row) async {
    final cost = row.costUsd == null
        ? 'unknown'
        : '\$${row.costUsd!.toStringAsFixed(6)}';
    try {
      session.log(
        'ai ${row.feature} model=${row.model} '
        'in=${row.inputTokens} out=${row.outputTokens} '
        'cacheRead=${row.cacheReadTokens} cacheWrite=${row.cacheWriteTokens} '
        'chars=${row.characters} cost=$cost',
      );
      await AiUsage.db.insertRow(session, row);
    } catch (e) {
      try {
        session.log('Recording AI usage failed: $e', level: LogLevel.warning);
      } catch (_) {
        // The session already closed (e.g. the client left mid-prefetch).
      }
    }
  }
}
