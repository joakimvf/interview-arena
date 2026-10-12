import 'dart:async';

import 'package:interview_arena_server/src/background.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given background work', (sessionBuilder, endpoints) {
    test('when future calls are off (as on Serverpod Cloud) then the work '
        'runs in-process in its own session', () async {
      final ran = Completer<int>();
      await scheduleOrRun(
        sessionBuilder.build(),
        name: 'test work',
        schedule: () async =>
            throw StateError('FutureCalls is not initialized.'),
        // A real query proves the detached session works.
        run: (s) async => ran.complete(await Resume.db.count(s)),
      );
      expect(await ran.future.timeout(const Duration(seconds: 10)), 0);
    });

    test('when scheduling works then the work is not also run here', () async {
      var scheduled = false, ran = false;
      await scheduleOrRun(
        sessionBuilder.build(),
        name: 'test work',
        schedule: () async => scheduled = true,
        run: (_) async => ran = true,
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(scheduled, isTrue);
      expect(ran, isFalse);
    });
  });
}
