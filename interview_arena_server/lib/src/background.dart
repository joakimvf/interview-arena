import 'dart:async';

import 'package:serverpod/serverpod.dart';

/// Schedules background work as a future call, or runs it in-process when
/// this server has future calls turned off.
///
/// Serverpod Cloud's managed config sets `futureCall.enabled: false`, and
/// scheduling a future call there throws "FutureCalls is not initialized"
/// (a [StateError]). Future calls are preferred where available because they
/// survive a restart; the fallback runs [run] after the current request in
/// its own session, so it also outlives the request that started it.
Future<void> scheduleOrRun(
  Session session, {
  required String name,
  required Future<void> Function() schedule,
  required Future<void> Function(Session session) run,
}) async {
  try {
    await schedule();
  } on StateError {
    unawaited(_runDetached(session.serverpod, name, run));
  }
}

Future<void> _runDetached(
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
