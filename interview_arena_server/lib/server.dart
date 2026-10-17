import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/auth/sign_up_policy.dart';
import 'src/generated/serverpod.dart';
import 'src/web/routes/app_config_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      // The default setup works with Serverpod Cloud without configuration. In
      // development the verification codes are logged to the console, and in
      // staging and production they are sent through the Serverpod Cloud email
      // service. If you want to use a custom provider for sending emails, use
      // `EmailIdpConfigFromPasswords`.
      ServerpodCloudEmailIdpConfig(
        appDisplayName: 'Interview Arena',
      ),
    ],
  );

  // Private cloud storage for uploaded CV PDFs. This setup works with
  // Serverpod Cloud without extra configuration. Nothing is public, so no
  // public storage is registered.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );

  // The Flutter web app reads its API address from assets/config.json; serve
  // one built from this server's public API config so a deployed app talks
  // to its own API (the bundled file points at localhost).
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Serve the Flutter web app if it has been built (the flutter_build script,
  // run before every Cloud deploy, writes it to web/app).
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(FlutterRoute(appDir, enableWasmHeaders: false), '/');
  }

  // Start the server.
  await pod.start();

  // Sign-up is closed on deployed servers; create the pre-made accounts.
  await createConfiguredAccounts(pod);
}
