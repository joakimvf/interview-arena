import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Whether people can create their own accounts. Open in development and
/// tests; closed on deployed servers, where only the jury account exists, so
/// strangers can't spend the AI credits. Overridable in tests.
bool Function(Session session) signUpOpen = (session) =>
    const {'development', 'test'}.contains(session.serverpod.runMode);

/// Makes sure an email login for [email] exists with [password] and
/// [scopes] (no verification email): creates it, or resets the password and
/// scopes of an existing one so the configuration always wins. Returns
/// whether it created the account.
Future<bool> ensureEmailAccount(
  Session session, {
  required String email,
  required String password,
  Set<Scope> scopes = const {},
}) async {
  final normalized = email.trim().toLowerCase();
  final admin = AuthServices.instance.emailIdp.admin;
  final existing = await admin.findAccount(session, email: normalized);
  if (existing != null) {
    await admin.setPassword(session, email: normalized, password: password);
    await AuthServices.instance.authUsers.update(
      session,
      authUserId: existing.authUserId,
      scopes: scopes,
    );
    return false;
  }
  await session.db.transaction((transaction) async {
    final user = await AuthServices.instance.authUsers.create(
      session,
      scopes: scopes,
      transaction: transaction,
    );
    await admin.createEmailAuthentication(
      session,
      authUserId: user.id,
      email: normalized,
      password: password,
      transaction: transaction,
    );
  });
  return true;
}

/// The pre-made accounts, since sign-up is closed on deployed servers. Each
/// one is configured by the `<name>Email` and `<name>Password` passwords in
/// Serverpod Cloud (never committed): `admin` for the team's own testing
/// (it gets the admin scope, which opens the AI cost screen), `jury` for the
/// judges.
const configuredAccounts = ['admin', 'jury'];

/// At server start, creates each configured account or resets its password
/// to the configured one. Accounts without both passwords set are skipped.
Future<void> createConfiguredAccounts(Serverpod pod) async {
  final session = await pod.createSession();
  try {
    for (final name in configuredAccounts) {
      final email = pod.getPassword('${name}Email');
      final password = pod.getPassword('${name}Password');
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        continue;
      }
      try {
        final created = await ensureEmailAccount(
          session,
          email: email,
          password: password,
          scopes: name == 'admin' ? {Scope.admin} : const {},
        );
        session.log(
          created
              ? 'Created the $name account.'
              : 'Updated the $name password.',
        );
      } catch (e) {
        session.log(
          'Setting up the $name account failed: $e',
          level: LogLevel.error,
        );
      }
    }
  } finally {
    await session.close();
  }
}
