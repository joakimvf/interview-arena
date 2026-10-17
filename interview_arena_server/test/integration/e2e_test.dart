// Drives the REAL generated client over the real WebSocket and HTTP against
// the server withServerpod boots (needs interview_arena_client as a server
// dev_dependency + an internal auth-handler override).
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:interview_arena_client/interview_arena_client.dart' as c;
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:interview_arena_server/src/interview/interview_endpoint.dart';
import 'package:serverpod/serverpod.dart';
// ignore: implementation_imports
import 'package:serverpod/src/server/server.dart' show ServerInternalMethods;
import 'package:serverpod_auth_idp_server/core.dart' show AuthUsers;
import 'package:test/test.dart';

import 'fakes.dart';
import 'test_tools/serverpod_test_tools.dart';

const _token = 'e2e-token';

class _FixedKey implements c.ClientAuthKeyProvider {
  @override
  Future<String?> get authHeaderValue async =>
      c.wrapAsBearerAuthHeaderValue(_token);
}

Future<void> waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 15));
  while (!condition() && DateTime.now().isBefore(deadline)) {
    await Future<void>.delayed(const Duration(milliseconds: 25));
  }
  if (!condition()) fail('condition not met');
}

/// test.yaml has publicPort 0: point the upload URL at the bound port.
String _fixPort(String description) {
  final json = jsonDecode(description) as Map;
  json['url'] = Uri.parse(
    json['url'] as String,
  ).replace(port: Serverpod.instance.server.port).toString();
  return jsonEncode(json);
}

void main() {
  withServerpod(
    'Given the real client over the network',
    (sb, endpoints) {
      late UuidValue userId;
      late c.Client client;
      late FakeInterviewAi fake;

      setUpAll(() async {
        userId = (await const AuthUsers().create(sb.build())).id; // FK target
        Serverpod.instance.server.setAuthenticationHandlerForTesting(
          (session, key) async => key == _token
              ? AuthenticationInfo(userId.uuid, <Scope>{}, authId: 'e2e')
              : null,
        );
      });

      setUp(() {
        fake = FakeInterviewAi();
        interviewAiFactory = (_) => fake;
        InterviewEndpoint.partialScoreInterval = Duration.zero;
        client = c.Client('http://localhost:${Serverpod.instance.server.port}/')
          ..authKeyProvider = _FixedKey();
      });

      tearDown(() => client.close());

      test('when sealed CandidateInput subtypes are sent then the server '
          'handles each subtype and nested models arrive typed', () async {
        final interview = await client.interview.start('Backend', null);
        final inputs = StreamController<c.CandidateInput>();
        final received = <c.InterviewEvent>[];
        final done = Completer<void>();
        client.interview
            .conduct(interview.id!, inputs.stream)
            .listen(
              received.add,
              onError: done.completeError,
              onDone: done.complete,
            );
        await waitFor(() => received.whereType<c.QuestionAsked>().isNotEmpty);
        final q1 = received.whereType<c.QuestionAsked>().first;
        inputs.add(
          c.AnswerChunk(
            clientSeq: 1,
            questionId: q1.questionId,
            textSoFar: 'y' * 90,
          ),
        );
        inputs.add(
          c.AnswerSubmitted(
            clientSeq: 2,
            questionId: q1.questionId,
            transcript: 'answer',
          ),
        );
        await waitFor(() => received.whereType<c.QuestionAsked>().length == 2);
        inputs.add(c.EndInterview(clientSeq: 3, reason: 'done'));
        await done.future.timeout(const Duration(seconds: 15));

        final labels = [
          for (final e in received)
            switch (e) {
              c.QuestionAsked(:final category) => 'Q:${category.name}',
              c.AnswerReceived() => 'R',
              c.ScoreUpdate(:final isPartial, :final scores) =>
                '${isPartial ? 'P' : 'S'}:${scores.communication}',
              c.AnswerEvaluated(:final feedback) =>
                'E:${feedback.improvements.single}',
              c.InterviewNotice(:final code) => 'N:$code',
              c.InterviewFinished(:final summary) => 'F:$summary',
            },
        ];
        expect(labels, [
          'Q:technical',
          'P:40.0',
          'R',
          'Q:technical', // next question no longer waits for evaluation
          'E:depth',
          'S:70.0',
          'F:Fake summary of 1 turns',
        ]);
        expect(fake.partials, 1);
        expect(fake.evaluations, 1);
        final row = await client.interview.getInterview(interview.id!);
        expect(row!.status, c.InterviewStatus.completed);
        expect(row.questions!.first.answers!.single.feedback!.summary, 'ok');
        unawaited(inputs.close());
      });

      test('when another user\'s interview is opened then the typed '
          'InterviewAccessException arrives, then done', () async {
        final otherId = (await const AuthUsers().create(sb.build())).id;
        final other = await InterviewSession.db.insertRow(
          sb.build(),
          InterviewSession(authUserId: otherId, targetRole: 'X'),
        );
        final inputs = StreamController<c.CandidateInput>();
        await expectLater(
          client.interview.conduct(other.id!, inputs.stream),
          emitsInOrder([
            emitsError(isA<c.InterviewAccessException>()),
            emitsDone,
          ]),
        );
        unawaited(inputs.close());
      });

      test('when a resume PDF is uploaded and completed then the background '
          'parse runs and getResume returns parsedData', () async {
        final pdf = Uint8List(300 * 1024)
          ..setAll(0, ascii.encode('%PDF-1.7\n'));
        final ticket = await client.resume.createUpload('cv.pdf', pdf.length);
        final ok = await c.FileUploader(
          _fixPort(ticket.uploadDescription),
        ).uploadByteData(ByteData.sublistView(pdf));
        expect(ok, isTrue);
        final parsing = await client.resume.completeUpload(ticket.resumeId);
        expect(parsing.status, c.ResumeParseStatus.parsing);

        c.Resume? r;
        final deadline = DateTime.now().add(const Duration(seconds: 15));
        while (DateTime.now().isBefore(deadline)) {
          r = await client.resume.getResume(ticket.resumeId);
          if (r!.status != c.ResumeParseStatus.parsing) break;
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
        expect(r!.status, c.ResumeParseStatus.parsed);
        expect(r.parsedData!.skills.single.name, 'Dart');
        expect(r.parsedData!.experience.single.company, 'ACME');
        expect(fake.parses, 1);
        expect(
          (await client.resume.listResumes()).map((x) => x.id),
          contains(ticket.resumeId),
        );
      });

      test('when the uploaded file is not a PDF then completeUpload throws the '
          'typed ResumeException', () async {
        final bytes = Uint8List.fromList(utf8.encode('hello, not a pdf'));
        final ticket = await client.resume.createUpload('x.pdf', bytes.length);
        expect(
          await c.FileUploader(
            _fixPort(ticket.uploadDescription),
          ).uploadByteData(ByteData.sublistView(bytes)),
          isTrue,
        );
        await expectLater(
          client.resume.completeUpload(ticket.resumeId),
          throwsA(
            isA<c.ResumeException>().having(
              (e) => e.reason,
              'reason',
              'not_pdf',
            ),
          ),
        );
        expect(
          (await client.resume.getResume(ticket.resumeId))!.status,
          c.ResumeParseStatus.failed,
        );
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
