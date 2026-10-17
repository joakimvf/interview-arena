import 'package:interview_arena_server/src/costs/ai_usage_tracker.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' show AuthUsers;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given recorded AI usage', (sb, endpoints) {
    late TestSessionBuilder authed;
    late int interviewId;

    setUp(() async {
      final session = sb.build();
      final userId = (await const AuthUsers().create(session)).id;
      authed = sb.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.uuid,
          <Scope>{},
        ),
      );
      interviewId = (await InterviewSession.db.insertRow(
        session,
        InterviewSession(authUserId: userId, targetRole: 'Backend'),
      )).id!;
      final ctx = (
        authUserId: userId,
        interviewSessionId: interviewId,
        resumeId: null,
      );
      await AiUsageTracker.recordClaude(
        session,
        feature: 'evaluation',
        model: 'claude-sonnet-5-5',
        usage: {'input_tokens': 1000000, 'output_tokens': 0},
        context: ctx,
      );
      await AiUsageTracker.recordClaude(
        session,
        feature: 'partial',
        model: 'claude-haiku-5-5',
        usage: {'input_tokens': 100000, 'output_tokens': 100000},
        context: ctx,
      );
      await AiUsageTracker.recordClaude(
        session,
        feature: 'resumeParse',
        model: 'unpriced-model',
        usage: {'input_tokens': 10, 'output_tokens': 10},
      );
      // No elevenLabsUsdPer1kChars in the test passwords: no voice price.
      await AiUsageTracker.recordVoice(
        session,
        model: 'eleven_v4_turbo',
        characters: 150,
        context: ctx,
      );
    });

    test('when the summary is asked for then costs add up per feature, '
        'model, day and interview', () async {
      final s = await endpoints.aiCost.summary(authed, 30);
      expect(s.since, isNotNull);
      expect(s.total.calls, 4);
      expect(s.total.costUsd, closeTo(2 + 0.01 + 0.05, 1e-9));
      expect(s.total.unpricedCalls, 2); // unknown model + unpriced voice
      expect(s.total.characters, 150);

      expect(s.byFeature.first.label, 'evaluation'); // most expensive first
      expect(s.byFeature.first.costUsd, closeTo(2, 1e-9));
      expect(
        s.byModel.map((l) => l.label),
        containsAll(['claude-sonnet-5-5', 'claude-haiku-5-5']),
      );
      expect(s.byDay.single.calls, 4);

      expect(s.interviewCount, 1);
      expect(s.recentInterviews.single.interviewSessionId, interviewId);
      expect(s.recentInterviews.single.targetRole, 'Backend');
      expect(s.recentInterviews.single.calls, 3);
      expect(s.averagePerInterviewUsd, closeTo(2.06, 1e-9));
      expect(await endpoints.aiCost.canView(authed), isTrue); // test run mode
    });

    test('when signed out then the costs are not served', () async {
      await expectLater(
        endpoints.aiCost.summary(sb, 0),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });
}
