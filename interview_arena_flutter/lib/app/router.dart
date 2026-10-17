import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/client_providers.dart';
import '../features/auth/sign_in_page.dart';
import '../features/costs/ai_costs_screen.dart';
import '../features/home/home_screen.dart';
import '../features/interview/live_interview_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // read, not watch: build once; auth changes arrive via refreshListenable.
  final auth = ref.read(authSessionProvider);
  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: auth.authInfoListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final signedIn = auth.isAuthenticated;
      final atSignIn = state.matchedLocation == '/sign-in';
      if (!signedIn) {
        if (atSignIn) return null;
        final from = state.uri.toString();
        return from == '/'
            ? '/sign-in'
            : '/sign-in?from=${Uri.encodeComponent(from)}';
      }
      if (atSignIn) return state.uri.queryParameters['from'] ?? '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SignInPage()),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const HomeScreen()),
        routes: [
          GoRoute(
            path: 'costs',
            pageBuilder: (context, state) =>
                MaterialPage(key: state.pageKey, child: const AiCostsScreen()),
          ),
          GoRoute(
            path: 'interview/:id',
            // A hand-typed non-numeric id would otherwise throw in build.
            redirect: (context, state) =>
                int.tryParse(state.pathParameters['id'] ?? '') == null
                ? '/'
                : null,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: LiveInterviewScreen(
                interviewSessionId: int.parse(state.pathParameters['id']!),
              ),
            ),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
