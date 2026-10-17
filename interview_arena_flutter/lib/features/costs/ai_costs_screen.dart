import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/client_providers.dart';

/// Whether the signed-in user may open the AI cost screen (admin scope on
/// deployed servers). Any failure just hides the entry.
final canViewAiCostsProvider = FutureProvider.autoDispose<bool>((ref) async {
  try {
    return await ref.watch(clientProvider).aiCost.canView();
  } catch (_) {
    return false;
  }
});

/// AI spend over the last N days (0 = all time).
final aiCostSummaryProvider = FutureProvider.autoDispose
    .family<AiCostSummary, int>(
      (ref, days) => ref.watch(clientProvider).aiCost.summary(days),
    );

String _usd(double v) => '\$${v.toStringAsFixed(v != 0 && v < 1 ? 4 : 2)}';

String _count(int n) => n >= 1000000
    ? '${(n / 1000000).toStringAsFixed(1)}M'
    : n >= 1000
    ? '${(n / 1000).toStringAsFixed(1)}k'
    : '$n';

/// For the team: what Claude and ElevenLabs cost, from the server's
/// `ai_usage` records at list prices.
class AiCostsScreen extends ConsumerStatefulWidget {
  const AiCostsScreen({super.key});

  @override
  ConsumerState<AiCostsScreen> createState() => _AiCostsScreenState();
}

class _AiCostsScreenState extends ConsumerState<AiCostsScreen> {
  var _days = 7;

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(aiCostSummaryProvider(_days));
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI costs'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(aiCostSummaryProvider(_days)),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 1, label: Text('24 h')),
                  ButtonSegment(value: 7, label: Text('7 days')),
                  ButtonSegment(value: 30, label: Text('30 days')),
                  ButtonSegment(value: 0, label: Text('All time')),
                ],
                selected: {_days},
                onSelectionChanged: (s) => setState(() => _days = s.single),
              ),
              const SizedBox(height: 16),
              ...switch (summary) {
                AsyncData(:final value) => _content(context, value),
                AsyncError(:final error) => [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.error_outline),
                      title: const Text('Could not load AI costs.'),
                      subtitle: Text('$error'),
                    ),
                  ),
                ],
                _ => [const Center(child: CircularProgressIndicator())],
              },
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context, AiCostSummary s) {
    final theme = Theme.of(context);
    final unpriced = s.total.unpricedCalls;
    return [
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _Stat(label: 'Total spend', value: _usd(s.total.costUsd)),
          _Stat(label: 'AI calls', value: _count(s.total.calls)),
          _Stat(label: 'Interviews', value: '${s.interviewCount}'),
          _Stat(
            label: 'Average per interview',
            value: _usd(s.averagePerInterviewUsd),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        'Estimated at list prices from each call\'s token usage.'
        '${unpriced > 0 ? ' $unpriced call(s) have no price and are not '
                  'included (voice needs the elevenLabsUsdPer1kChars '
                  'password; unknown models are skipped).' : ''}',
        style: theme.textTheme.bodySmall,
      ),
      _CostTable(title: 'By feature', lines: s.byFeature),
      _CostTable(title: 'By model', lines: s.byModel),
      _CostTable(title: 'By day (UTC)', lines: s.byDay),
      _Header('Recent interviews'),
      Card(
        clipBehavior: Clip.antiAlias,
        child: s.recentInterviews.isEmpty
            ? const ListTile(title: Text('No interviews in this period.'))
            : Column(
                children: [
                  for (final (i, it) in s.recentInterviews.indexed) ...[
                    if (i > 0) const Divider(height: 1),
                    ListTile(
                      title: Text(it.targetRole ?? 'Deleted interview'),
                      subtitle: Text(
                        '#${it.interviewSessionId} · ${it.calls} calls'
                        '${it.startedAt == null ? '' : ' · ${_date(it.startedAt!)}'}',
                      ),
                      trailing: Text(
                        _usd(it.costUsd),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    ];
  }

  static String _date(DateTime d) {
    final l = d.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)} ${two(l.hour)}:${two(l.minute)}';
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}

class _CostTable extends StatelessWidget {
  const _CostTable({required this.title, required this.lines});
  final String title;
  final List<AiCostLine> lines;

  /// Average over the calls that have a price.
  static String _perPricedCall(AiCostLine l) {
    final priced = l.calls - l.unpricedCalls;
    return priced == 0 ? '-' : _usd(l.costUsd / priced);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title),
        Card(
          clipBehavior: Clip.antiAlias,
          child: lines.isEmpty
              ? const ListTile(title: Text('No AI calls in this period.'))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Calls'), numeric: true),
                      DataColumn(label: Text('Input'), numeric: true),
                      DataColumn(label: Text('Output'), numeric: true),
                      DataColumn(label: Text('Cache read'), numeric: true),
                      DataColumn(label: Text('Cache write'), numeric: true),
                      DataColumn(label: Text('Voice chars'), numeric: true),
                      DataColumn(label: Text('Per call'), numeric: true),
                      DataColumn(label: Text('Cost'), numeric: true),
                    ],
                    rows: [
                      for (final l in lines)
                        DataRow(
                          cells: [
                            DataCell(Text(l.label)),
                            DataCell(Text(_count(l.calls))),
                            DataCell(Text(_count(l.inputTokens))),
                            DataCell(Text(_count(l.outputTokens))),
                            DataCell(Text(_count(l.cacheReadTokens))),
                            DataCell(Text(_count(l.cacheWriteTokens))),
                            DataCell(Text(_count(l.characters))),
                            DataCell(
                              Text(
                                _perPricedCall(l),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${_usd(l.costUsd)}'
                                '${l.unpricedCalls > 0 ? ' *' : ''}',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
