import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'client.dart';
import 'core/client_providers.dart';

// lib/driver.dart (the `serverpod start` launch target) calls this main().
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(
    ProviderScope(
      overrides: [clientProvider.overrideWithValue(client)],
      child: const InterviewArenaApp(),
    ),
  );
}

class InterviewArenaApp extends ConsumerWidget {
  const InterviewArenaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Interview Arena',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
