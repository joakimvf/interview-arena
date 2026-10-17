import 'package:serverpod/serverpod.dart';

/// List prices in US dollars per million tokens. Update when Anthropic's
/// pricing changes; models missing here are recorded without a cost.
typedef TokenPrice = ({
  double input,
  double output,
  double cacheRead,
  double cacheWrite, // 5-minute cache write
});

const claudePrices = <String, TokenPrice>{
  'claude-opus-5-5': (input: 4, output: 20, cacheRead: 0.20, cacheWrite: 5),
  'claude-sonnet-5-5': (input: 2, output: 10, cacheRead: 0.20, cacheWrite: 2.5),
  // For prompts up to 100K tokens; see [claudeCostUsd] for longer ones.
  'claude-haiku-5-5': (
    input: 0.10,
    output: 0.50,
    cacheRead: 0.01,
    cacheWrite: 0.125,
  ),
};

/// Claude Haiku 5.5's rate card for prompts over 100K tokens.
const _haikuLongPrompt = (
  input: 0.50,
  output: 2.50,
  cacheRead: 0.05,
  cacheWrite: 0.625,
);

/// Estimated cost of one Claude response, or null for an unknown model.
double? claudeCostUsd(
  String model, {
  required int inputTokens,
  required int outputTokens,
  int cacheReadTokens = 0,
  int cacheWriteTokens = 0,
}) {
  var price = claudePrices[model];
  if (price == null) return null;
  final promptTokens = inputTokens + cacheReadTokens + cacheWriteTokens;
  if (model == 'claude-haiku-5-5' && promptTokens > 100000) {
    price = _haikuLongPrompt;
  }
  return (inputTokens * price.input +
          outputTokens * price.output +
          cacheReadTokens * price.cacheRead +
          cacheWriteTokens * price.cacheWrite) /
      1e6;
}

/// Estimated cost of synthesizing [characters] with ElevenLabs, from the
/// optional `elevenLabsUsdPer1kChars` password (it depends on the plan).
/// Null when that isn't set.
double? voiceCostUsd(Session session, int characters) {
  final rate = double.tryParse(
    session.passwords['elevenLabsUsdPer1kChars'] ?? '',
  );
  return rate == null ? null : characters / 1000 * rate;
}
