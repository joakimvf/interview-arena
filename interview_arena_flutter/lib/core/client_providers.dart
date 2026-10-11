import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// Overridden in main() with the initialized client.
final clientProvider = Provider<Client>(
  (ref) => throw UnimplementedError('Override clientProvider in main()'),
);

final authSessionProvider = Provider<FlutterAuthSessionManager>(
  (ref) => ref.watch(clientProvider).auth,
);

final authInfoProvider = NotifierProvider<AuthInfoNotifier, AuthSuccess?>(
  AuthInfoNotifier.new,
);

class AuthInfoNotifier extends Notifier<AuthSuccess?> {
  @override
  AuthSuccess? build() {
    final ValueListenable<AuthSuccess?> listenable = ref
        .watch(authSessionProvider)
        .authInfoListenable;
    void onChange() => state = listenable.value;
    listenable.addListener(onChange);
    ref.onDispose(() => listenable.removeListener(onChange));
    return listenable.value;
  }

  Future<bool> signOut() => ref.read(authSessionProvider).signOutDevice();
}
