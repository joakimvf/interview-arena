import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// AuthUsersConfig.onAfterAuthUserCreated: runs INSIDE the registration
/// transaction, so every write must pass `transaction:` (the new auth user
/// row is not committed yet).
Future<void> createCandidateProfile(
  Session session,
  AuthUserModel authUser, {
  required Transaction transaction,
}) async {
  await CandidateProfile.db.insertRow(
    session,
    CandidateProfile(authUserId: authUser.id),
    transaction: transaction,
  );
}
