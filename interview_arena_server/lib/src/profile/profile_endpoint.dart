import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart'; // authUserId extension

import '../generated/protocol.dart';

class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Get-or-create (safety net if the onAfterAuthUserCreated hook is absent).
  Future<CandidateProfile> me(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    final existing = await CandidateProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) return existing;
    try {
      return await CandidateProfile.db.insertRow(
        session,
        CandidateProfile(authUserId: authUserId),
      );
    } on DatabaseUniqueViolationException {
      return (await CandidateProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      ))!;
    }
  }

  Future<CandidateProfile> updateMe(
    Session session,
    String? displayName,
    String? targetRole,
    double? yearsOfExperience,
  ) async {
    final current = await me(session);
    return CandidateProfile.db.updateRow(
      session,
      current.copyWith(
        displayName: displayName,
        targetRole: targetRole,
        yearsOfExperience: yearsOfExperience,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
