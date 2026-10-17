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
      'Given email registration (rollback ${rollback.name})',
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
          );
        });

        test(
          'when a user registers with the emailed code then login works',
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

            final login = await endpoints.emailIdp.login(
              sessionBuilder,
              email: email,
              password: 'correct-horse-1',
            );
            expect(login.authUserId, auth.authUserId);
          },
        );

        test('when unauthenticated then app endpoints are rejected', () async {
          await expectLater(
            endpoints.resume.listResumes(sessionBuilder),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        });
      },
      rollbackDatabase: rollback,
    );
  }
}
