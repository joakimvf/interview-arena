import 'package:interview_arena_server/src/costs/pricing.dart';
import 'package:test/test.dart';

void main() {
  test('Sonnet 5.5 cost adds input, output and cache tokens at list price', () {
    // The smoke test's question call: 4 in, 114 out, 538 written to cache.
    final cost = claudeCostUsd(
      'claude-sonnet-5-5',
      inputTokens: 4,
      outputTokens: 114,
      cacheWriteTokens: 538,
    );
    expect(cost, closeTo((4 * 2 + 114 * 10 + 538 * 2.5) / 1e6, 1e-12));
  });

  test('Haiku 5.5 switches to its long-prompt rate card over 100K tokens', () {
    final short = claudeCostUsd(
      'claude-haiku-5-5',
      inputTokens: 100000,
      outputTokens: 0,
    );
    final long = claudeCostUsd(
      'claude-haiku-5-5',
      inputTokens: 100001,
      outputTokens: 0,
    );
    expect(short, closeTo(0.01, 1e-12));
    expect(long, closeTo(100001 * 0.5 / 1e6, 1e-12));
  });

  test('an unknown model has no cost', () {
    expect(
      claudeCostUsd('some-other-model', inputTokens: 1, outputTokens: 1),
      isNull,
    );
  });
}
