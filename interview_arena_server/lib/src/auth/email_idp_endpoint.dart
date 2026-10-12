import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'sign_up_policy.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  /// Sign-up is closed on deployed servers (see [signUpOpen]). Every
  /// registration starts here, so blocking this blocks the whole flow.
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    if (!signUpOpen(session)) {
      throw SignUpClosedException(
        message:
            'Sign-up is closed. Use the account from the testing '
            'instructions.',
      );
    }
    return super.startRegistration(session, email: email);
  }
}
