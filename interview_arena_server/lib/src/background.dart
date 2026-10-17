import 'dart:async';

import 'package:serverpod/serverpod.dart';

/// Runs [run] in-process in its own session, after the current request.
///
/// For work that outlives the request that starts it (a Claude PDF parse can
/// take longer than the client's call timeout). Not durable across a restart;
/// the caller's status field shows work that never finished.
void runInBackground(
  Session session,
  String name,
  Future<void> Function(Session session) run,
) => unawaited(_run(session.serverpod, name, run));

Future<void> _run(
  Serverpod pod,
  String name,
  Future<void> Function(Session session) run,
) async {
  final session = await pod.createSession();
  try {
    await run(session);
  } catch (e) {
    session.log('$name failed: $e', level: LogLevel.warning);
  } finally {
    await session.close();
  }
}
