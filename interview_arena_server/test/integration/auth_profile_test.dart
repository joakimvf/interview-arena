import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:interview_arena_server/src/profile/profile_hooks.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // RollbackDatabase.afterEach FAILS for the email IdP: its rate limiter opens
  // a concurrent transaction ("Concurrent calls to transaction are not
  // supported when database rollbacks are enabled").
  for (final rollback in [RollbackDatabase.disabled]) {
    withServerpod(
      'Given email registration with the profile hook (rollback ${rollback.name})',
      (sessionBuilder, endpoints) {
        String? code;

        setUp(() {
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
              EmailIdpConfig(
                secretHashPepper: 'test-email-pepper',
                sendRegistrationVerificationCode:
                    (
                      session, {
                      required email,
                      required accountRequestId,
                      required verificationCode,
                      required transaction,
                    }) {
                      code = verificationCode;
                    },
              ),
            ],
            authUsersConfig: const AuthUsersConfig(
              onAfterAuthUserCreated: createCandidateProfile,
            ),
          );
        });

        test(
          'when a user registers then the hook created exactly one '
          'CandidateProfile and profile.me returns it, and login works',
          () async {
            final email = 'alice-${rollback.name}@example.com';
            final requestId = await endpoints.emailIdp.startRegistration(
              sessionBuilder,
              email: email,
            );
            expect(code, isNotNull);
            expect(code, matches(RegExp(r'^[1-9]{8}$')));
            final token = await endpoints.emailIdp.verifyRegistrationCode(
              sessionBuilder,
              accountRequestId: requestId,
              verificationCode: code!,
            );
            final auth = await endpoints.emailIdp.finishRegistration(
              sessionBuilder,
              registrationToken: token,
              password: 'correct-horse-1',
            );

            final profiles = await CandidateProfile.db.find(
              sessionBuilder.build(),
              where: (t) => t.authUserId.equals(auth.authUserId),
            );
            expect(profiles, hasLength(1));
            expect(profiles.single.timeZone, 'UTC');

            final authed = sessionBuilder.copyWith(
              authentication: AuthenticationOverride.authenticationInfo(
                auth.authUserId.uuid,
                <Scope>{},
              ),
            );
            final me = await endpoints.profile.me(authed);
            expect(me.id, profiles.single.id);
            final updated = await endpoints.profile.updateMe(
              authed,
              'Alice',
              'Backend engineer',
              7,
            );
            expect(updated.displayName, 'Alice');

            final login = await endpoints.emailIdp.login(
              sessionBuilder,
              email: email,
              password: 'correct-horse-1',
            );
            expect(login.authUserId, auth.authUserId);
          },
        );

        test('when unauthenticated then profile.me is rejected', () async {
          await expectLater(
            endpoints.profile.me(sessionBuilder),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        });
      },
      rollbackDatabase: rollback,
    );
  }
}
