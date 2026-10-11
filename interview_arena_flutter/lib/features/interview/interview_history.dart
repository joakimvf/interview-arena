import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/data_providers.dart';
import 'interview_feedback.dart';
import 'score_widgets.dart';

/// Past interviews, newest first. Unfinished ones can be resumed.
class InterviewHistory extends ConsumerWidget {
  const InterviewHistory({super.key});

  static String _status(InterviewStatus s) => switch (s) {
    InterviewStatus.pending => 'Not started',
    InterviewStatus.active => 'In progress',
    InterviewStatus.interrupted => 'Paused · tap to resume',
    InterviewStatus.completed => 'Completed',
    InterviewStatus.abandoned => 'Abandoned',
  };

  static String _date(DateTime d) {
    final l = d.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)} ${two(l.hour)}:${two(l.minute)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(interviewsProvider)) {
      AsyncData(:final value) when value.isEmpty => const Card(
        child: ListTile(
          leading: Icon(Icons.history),
          title: Text('Your interviews will show up here.'),
        ),
      ),
      AsyncData(:final value) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            for (final (i, s) in value.indexed) ...[
              if (i > 0) const Divider(height: 1),
              ListTile(
                leading: _ScoreBadge(session: s),
                title: Text(s.targetRole),
                subtitle: Text('${_date(s.startedAt)} · ${_status(s.status)}'),
                trailing: s.status == InterviewStatus.abandoned
                    ? null
                    : const Icon(Icons.chevron_right),
                onTap: switch (s.status) {
                  InterviewStatus.completed => () => _showResult(context, s),
                  InterviewStatus.abandoned => null,
                  _ => () => context.go('/interview/${s.id}'),
                },
              ),
            ],
          ],
        ),
      ),
      AsyncError() => Card(
        child: ListTile(
          title: const Text('Couldn\'t load your interviews.'),
          trailing: TextButton(
            onPressed: () => ref.invalidate(interviewsProvider),
            child: const Text('Retry'),
          ),
        ),
      ),
      _ => const LinearProgressIndicator(),
    };
  }

  void _showResult(BuildContext context, InterviewSession s) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(s.targetRole, style: theme.textTheme.titleLarge),
                  Text(_date(s.startedAt), style: theme.textTheme.bodySmall),
                  const SizedBox(height: 16),
                  if (s.overallScore case final overall?)
                    Center(child: ScoreGauge(score: overall, size: 140)),
                  if (s.scores case final scores?) ...[
                    const SizedBox(height: 16),
                    ScoreBars(scores: scores),
                  ],
                  const SizedBox(height: 16),
                  if (s.report case final report?)
                    ReportSections(report: report)
                  else if (s.summary case final summary?)
                    Text(summary),
                  QuestionBreakdown(interviewSessionId: s.id!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.session});
  final InterviewSession session;

  @override
  Widget build(BuildContext context) {
    final score = session.overallScore;
    if (score == null) {
      return const CircleAvatar(child: Icon(Icons.pending_outlined));
    }
    final color = scoreColor(context, score);
    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.15),
      foregroundColor: color,
      child: Text(
        score.round().toString(),
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
