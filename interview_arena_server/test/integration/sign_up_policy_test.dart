import 'package:interview_arena_server/src/auth/sign_up_policy.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:interview_arena_server/src/profile/profile_hooks.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // The email IdP's rate limiter needs rollbacks disabled (see
  // auth_profile_test.dart).
  withServerpod(
    'Given a deployed server where sign-up is closed',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      final defaultPolicy = signUpOpen;

      setUp(() {
        signUpOpen = (_) => false;
        // withServerpod never runs lib/server.dart: AuthServices is unset.
        AuthServices.set(
          tokenManagerBuilders: [
            JwtConfig(
              algorithm: JwtAlgorithm.hmacSha512(
                SecretKey('test-only-hmac-secret-key-0123456789'),
              ),
              refreshTokenHashPepper: 'test-refresh-pepper',
            ),
          ],
          identityProviderBuilders: [
            EmailIdpConfig(secretHashPepper: 'test-email-pepper'),
          ],
          authUsersConfig: const AuthUsersConfig(
            onAfterAuthUserCreated: createCandidateProfile,
          ),
        );
      });

      tearDown(() => signUpOpen = defaultPolicy);

      test('when someone starts a registration then it is refused', () async {
        await expectLater(
          endpoints.emailIdp.startRegistration(
            sessionBuilder,
            email: 'stranger@example.com',
          ),
          throwsA(isA<SignUpClosedException>()),
        );
      });

      test(
        'when the jury account is ensured then the jury can log in, has a '
        'profile, and a later run with a new password replaces the old one',
        () async {
          final session = sessionBuilder.build();
          expect(
            await ensureEmailAccount(
              session,
              email: '  Jury@Example.com ',
              password: 'jury-password-123',
            ),
            isTrue,
          );
          expect(
            await ensureEmailAccount(
              session,
              email: 'jury@example.com',
              password: 'new-jury-password-456',
            ),
            isFalse,
          );

          final auth = await endpoints.emailIdp.login(
            sessionBuilder,
            email: 'jury@example.com',
            password: 'new-jury-password-456',
          );
          final profiles = await CandidateProfile.db.find(
            session,
            where: (t) => t.authUserId.equals(auth.authUserId),
          );
          expect(profiles, hasLength(1));

          // The old password no longer works.
          await expectLater(
            endpoints.emailIdp.login(
              sessionBuilder,
              email: 'jury@example.com',
              password: 'jury-password-123',
            ),
            throwsA(anything),
          );
        },
      );
    },
  );
}
