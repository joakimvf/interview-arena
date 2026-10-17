import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// The team's view of what the app spends on AI, from `ai_usage`.
/// Open to the admin scope on deployed servers, and to anyone signed in
/// during development and tests.
class AiCostEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static bool _allowed(Session session) =>
      const {'development', 'test'}.contains(session.serverpod.runMode) ||
      session.authenticated!.scopes.contains(Scope.admin);

  /// Whether the signed-in user may see AI costs (shows the menu entry).
  Future<bool> canView(Session session) async => _allowed(session);

  /// Spend over the last [days] days, or all time when [days] is 0 or less.
  Future<AiCostSummary> summary(Session session, int days) async {
    if (!_allowed(session)) {
      throw AiCostAccessException(reason: 'admin_only');
    }
    final since = days > 0
        ? DateTime.now().toUtc().subtract(Duration(days: days))
        : null;
    final params = QueryParameters.named({
      'since': since ?? DateTime.utc(1970),
    });

    // Sums are cast so Postgres returns plain integers and doubles.
    const sums = '''
      count(*)::int AS calls,
      coalesce(sum("inputTokens"), 0)::int AS input,
      coalesce(sum("outputTokens"), 0)::int AS output,
      coalesce(sum("cacheReadTokens"), 0)::int AS cache_read,
      coalesce(sum("cacheWriteTokens"), 0)::int AS cache_write,
      coalesce(sum("characters"), 0)::int AS chars,
      coalesce(sum("costUsd"), 0)::float8 AS cost,
      (count(*) FILTER (WHERE "costUsd" IS NULL))::int AS unpriced''';

    final groups = await session.db.unsafeQuery(
      '''
      SELECT feature, model, $sums FROM ai_usage
      WHERE "createdAt" >= @since GROUP BY feature, model''',
      parameters: params,
    );
    final dayRows = await session.db.unsafeQuery('''
      SELECT to_char("createdAt" AT TIME ZONE 'UTC', 'YYYY-MM-DD') AS day, $sums
      FROM ai_usage WHERE "createdAt" >= @since
      GROUP BY day ORDER BY day DESC LIMIT 60''', parameters: params);
    final interviews = await session.db.unsafeQuery('''
      SELECT u."interviewSessionId" AS id, s."targetRole" AS role,
        s."startedAt" AS started, count(*)::int AS calls,
        coalesce(sum(u."costUsd"), 0)::float8 AS cost
      FROM ai_usage u
      LEFT JOIN interview_session s ON s.id = u."interviewSessionId"
      WHERE u."interviewSessionId" IS NOT NULL AND u."createdAt" >= @since
      GROUP BY u."interviewSessionId", s."targetRole", s."startedAt"
      ORDER BY max(u."createdAt") DESC''', parameters: params);

    AiCostLine line(String label, Map<String, dynamic> r) => AiCostLine(
      label: label,
      calls: r['calls'] as int,
      inputTokens: r['input'] as int,
      outputTokens: r['output'] as int,
      cacheReadTokens: r['cache_read'] as int,
      cacheWriteTokens: r['cache_write'] as int,
      characters: r['chars'] as int,
      costUsd: (r['cost'] as num).toDouble(),
      unpricedCalls: r['unpriced'] as int,
    );

    final rows = [for (final r in groups) r.toColumnMap()];
    final perInterview = [
      for (final r in interviews.map((r) => r.toColumnMap()))
        AiInterviewCost(
          interviewSessionId: r['id'] as int,
          targetRole: r['role'] as String?,
          startedAt: r['started'] as DateTime?,
          calls: r['calls'] as int,
          costUsd: (r['cost'] as num).toDouble(),
        ),
    ];
    final interviewTotal = perInterview.fold<double>(
      0,
      (sum, i) => sum + i.costUsd,
    );

    return AiCostSummary(
      since: since,
      total: _sum('Total', [for (final r in rows) line('', r)]),
      byFeature: _grouped(rows, 'feature', line),
      byModel: _grouped(rows, 'model', line),
      byDay: [
        for (final r in dayRows.map((r) => r.toColumnMap()))
          line(r['day'] as String, r),
      ],
      interviewCount: perInterview.length,
      averagePerInterviewUsd: perInterview.isEmpty
          ? 0
          : interviewTotal / perInterview.length,
      recentInterviews: perInterview.take(20).toList(),
    );
  }

  /// Lines per distinct value of [key], most expensive first.
  static List<AiCostLine> _grouped(
    List<Map<String, dynamic>> rows,
    String key,
    AiCostLine Function(String label, Map<String, dynamic> row) line,
  ) {
    final byKey = <String, List<AiCostLine>>{};
    for (final r in rows) {
      final label = r[key] as String;
      (byKey[label] ??= []).add(line(label, r));
    }
    return [for (final e in byKey.entries) _sum(e.key, e.value)]
      ..sort((a, b) => b.costUsd.compareTo(a.costUsd));
  }

  static AiCostLine _sum(String label, List<AiCostLine> lines) => AiCostLine(
    label: label,
    calls: lines.fold(0, (s, l) => s + l.calls),
    inputTokens: lines.fold(0, (s, l) => s + l.inputTokens),
    outputTokens: lines.fold(0, (s, l) => s + l.outputTokens),
    cacheReadTokens: lines.fold(0, (s, l) => s + l.cacheReadTokens),
    cacheWriteTokens: lines.fold(0, (s, l) => s + l.cacheWriteTokens),
    characters: lines.fold(0, (s, l) => s + l.characters),
    costUsd: lines.fold(0, (s, l) => s + l.costUsd),
    unpricedCalls: lines.fold(0, (s, l) => s + l.unpricedCalls),
  );
}
