import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/data_providers.dart';
import 'score_widgets.dart';

/// Whole-interview feedback: summary, what went well, what to improve, and
/// topics to study next.
class ReportSections extends StatelessWidget {
  const ReportSections({super.key, required this.report});
  final InterviewReport report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget card(String title, List<Widget> children) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        card('Overall feedback', [
          Text(report.summary, style: theme.textTheme.bodyMedium),
        ]),
        if (report.strengths.isNotEmpty)
          card('What went well', [
            for (final s in report.strengths)
              Bullet(
                icon: Icons.check_circle,
                color: Colors.green.shade600,
                text: s,
              ),
          ]),
        if (report.improvements.isNotEmpty)
          card('What to improve', [
            for (final s in report.improvements)
              Bullet(
                icon: Icons.trending_up,
                color: Colors.amber.shade800,
                text: s,
              ),
          ]),
        if (report.focusAreas.isNotEmpty)
          card('Study next', [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final a in report.focusAreas)
                  Chip(
                    avatar: const Icon(Icons.menu_book_outlined, size: 18),
                    label: Text(a),
                  ),
              ],
            ),
          ]),
      ],
    );
  }
}

/// Every question with the candidate's answer, scores and feedback. Each
/// one is collapsed until tapped.
class QuestionBreakdown extends ConsumerWidget {
  const QuestionBreakdown({super.key, required this.interviewSessionId});
  final int interviewSessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return switch (ref.watch(interviewDetailsProvider(interviewSessionId))) {
      AsyncData(:final value?) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: Text(
              'Question by question',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final (i, q)
                    in (value.questions ?? const <Question>[])
                        .where((q) => q.answers?.isNotEmpty ?? false)
                        .indexed) ...[
                  if (i > 0) const Divider(height: 1),
                  _QuestionTile(question: q),
                ],
              ],
            ),
          ),
        ],
      ),
      AsyncError() => const SizedBox.shrink(),
      AsyncData() => const SizedBox.shrink(),
      _ => const Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(),
      ),
    };
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final answer = question.answers!.last;
    final scores = answer.scores;
    final feedback = answer.feedback;
    return ExpansionTile(
      // Collapsed by default: the overall feedback comes first.
      initiallyExpanded: false,
      title: Text(
        question.prompt,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Q${question.orderIndex + 1} · ${categoryLabel(question.category)}',
      ),
      trailing: scores == null
          ? const Icon(Icons.expand_more)
          : ScoreBadge(score: overallOf(scores)),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.prompt, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 12),
        Text('Your answer', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          answer.transcript,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (scores != null) ...[
          const SizedBox(height: 12),
          ScoreBars(scores: scores),
        ],
        if (feedback != null) ...[
          const SizedBox(height: 12),
          Text(feedback.summary),
          for (final s in feedback.strengths)
            Bullet(
              icon: Icons.check_circle,
              color: Colors.green.shade600,
              text: s,
            ),
          for (final s in feedback.improvements)
            Bullet(
              icon: Icons.trending_up,
              color: Colors.amber.shade800,
              text: s,
            ),
        ] else
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'This answer could not be scored.',
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class Bullet extends StatelessWidget {
  const Bullet({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
  });
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/// Small colored score chip, e.g. in list rows.
class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.score});
  final double score;

  @override
  Widget build(BuildContext context) {
    final color = scoreColor(context, score);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        score.round().toString(),
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
