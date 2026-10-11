import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:interview_arena_client/interview_arena_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late final Client client;

Future<void> initializeClient() async {
  client = Client(await getServerUrl())
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  // Local-only restore BEFORE the first frame so the router's first redirect
  // sees a stored session (no sign-in flicker); validate in the background.
  try {
    await client.auth.restore();
  } catch (e) {
    // e.g. keychain unavailable on a sandboxed macOS build: start signed out
    // instead of failing before runApp and showing a blank window.
    debugPrint('Restoring the auth session failed: $e');
  }
  unawaited(client.auth.initialize());
}
