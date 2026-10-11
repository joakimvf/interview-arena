import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

const metricLabels = [
  'Communication',
  'Confidence',
  'Technical depth',
  'Completeness',
  'Structure',
];

List<double> metricValues(InterviewScores s) => [
  s.communication,
  s.confidence,
  s.technicalDepth,
  s.completeness,
  s.structure,
];

double overallOf(InterviewScores s) =>
    metricValues(s).reduce((a, b) => a + b) / metricLabels.length;

String categoryLabel(QuestionCategory c) => switch (c) {
  QuestionCategory.behavioral => 'Behavioral',
  QuestionCategory.technical => 'Technical',
  QuestionCategory.systemDesign => 'System design',
  QuestionCategory.situational => 'Situational',
  QuestionCategory.resumeDeepDive => 'Resume deep dive',
};

String verdictFor(double score) => switch (score) {
  >= 80 => 'Excellent',
  >= 65 => 'Good',
  >= 50 => 'Fair',
  _ => 'Keep practicing',
};

/// Color for a 0-100 score: red below 50, amber below 65, green above.
Color scoreColor(BuildContext context, double score) {
  final scheme = Theme.of(context).colorScheme;
  if (score < 50) return scheme.error;
  if (score < 65) return Colors.amber.shade700;
  return Colors.green.shade600;
}

/// Radar of the five metrics on a fixed 0-100 scale.
class ScoreRadar extends StatelessWidget {
  const ScoreRadar({super.key, required this.scores});
  final InterviewScores scores;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    // Invisible 0 and 100 rings pin the scale; otherwise fl_chart scales to
    // the data and a 40 can fill the chart.
    RadarDataSet anchor(double v) => RadarDataSet(
      dataEntries: List.filled(metricLabels.length, RadarEntry(value: v)),
      fillColor: Colors.transparent,
      borderColor: Colors.transparent,
      borderWidth: 0,
      entryRadius: 0,
    );
    final values = metricValues(scores);
    return RadarChart(
      RadarChartData(
        dataSets: [
          anchor(0),
          anchor(100),
          RadarDataSet(
            dataEntries: [for (final v in values) RadarEntry(value: v)],
            fillColor: color.withValues(alpha: 0.25),
            borderColor: color,
            borderWidth: 2,
            entryRadius: 3,
          ),
        ],
        radarShape: RadarShape.polygon,
        radarBorderData: BorderSide(color: theme.colorScheme.outlineVariant),
        gridBorderData: BorderSide(color: theme.colorScheme.outlineVariant),
        tickBorderData: BorderSide(color: theme.colorScheme.outlineVariant),
        tickCount: 4,
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 1),
        titleTextStyle: theme.textTheme.labelSmall,
        titlePositionPercentageOffset: 0.15,
        getTitle: (i, angle) => RadarChartTitle(
          text: '${metricLabels[i]}\n${values[i].round()}',
        ),
      ),
    );
  }
}

/// Label and value on one line, full-width bar below (Headway-style).
class ScoreBars extends StatelessWidget {
  const ScoreBars({super.key, required this.scores});
  final InterviewScores scores;

  @override
  Widget build(BuildContext context) {
    final values = metricValues(scores);
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < metricLabels.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(metricLabels[i], style: text.bodyMedium),
                    ),
                    Text(
                      values[i].round().toString(),
                      style: text.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: (values[i] / 100).clamp(0, 1),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                  color: scoreColor(context, values[i]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Five compact tiles for narrow layouts where a radar would crowd the screen.
class ScoreStrip extends StatelessWidget {
  const ScoreStrip({super.key, required this.scores});
  final InterviewScores scores;

  static const _short = ['Comm.', 'Conf.', 'Tech.', 'Compl.', 'Struct.'];

  @override
  Widget build(BuildContext context) {
    final values = metricValues(scores);
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        for (var i = 0; i < values.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  Text(values[i].round().toString(), style: text.titleMedium),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: (values[i] / 100).clamp(0, 1),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                    color: scoreColor(context, values[i]),
                  ),
                  const SizedBox(height: 4),
                  Text(_short[i], style: text.labelSmall),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Big circular score with a label underneath (Acorns-style).
class ScoreGauge extends StatelessWidget {
  const ScoreGauge({
    super.key,
    required this.score,
    this.label = 'Overall score',
    this.size = 180,
  });
  final double score;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.square(
      dimension: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: (score / 100).clamp(0, 1),
            strokeWidth: size / 14,
            strokeCap: StrokeCap.round,
            color: scoreColor(context, score),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  score.round().toString(),
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(label, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
