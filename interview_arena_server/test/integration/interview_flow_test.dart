import 'dart:async';

import 'package:interview_arena_server/src/ai/embeddings.dart';
import 'package:interview_arena_server/src/ai/interview_ai.dart';
import 'package:interview_arena_server/src/generated/protocol.dart';
import 'package:interview_arena_server/src/interview/career_memory.dart';
import 'package:interview_arena_server/src/interview/interview_endpoint.dart';
import 'package:serverpod/protocol.dart' show FutureCallEntry;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' show AuthUsers;
import 'package:test/test.dart';

import 'fakes.dart';
import 'test_tools/serverpod_test_tools.dart';

Future<void> waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (!condition() && DateTime.now().isBefore(deadline)) {
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
  if (!condition()) fail('condition not met in 10 s');
}

void main() {
  withServerpod('Given a live interview with a fake AI', (sb, endpoints) {
    late UuidValue userId;
    late TestSessionBuilder authed;
    late FakeInterviewAi fake;

    setUp(() async {
      fake = FakeInterviewAi();
      interviewAiFactory = (_) => fake;
      InterviewEndpoint.partialScoreInterval = Duration.zero;
      userId = (await const AuthUsers().create(sb.build())).id;
      authed = sb.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.uuid,
          <Scope>{},
        ),
      );
    });

    test(
      'when two answers are submitted (maxQuestions 2) then the full event '
      'sequence arrives, the stream completes and the DB is updated',
      () async {
        final interview = await endpoints.interview.start(
          authed,
          'Backend',
          null,
        );
        final id = interview.id!;
        await InterviewSession.db.updateById(
          sb.build(),
          id,
          columnValues: (t) => [t.maxQuestions(2)],
        );

        final inputs = StreamController<CandidateInput>();
        final received = <InterviewEvent>[];
        final done = Completer<void>();
        endpoints.interview
            .conduct(authed, id, inputs.stream)
            .listen(
              received.add,
              onError: (Object e) => done.completeError(e),
              onDone: done.complete,
            );

        await waitFor(() => received.whereType<QuestionAsked>().length == 1);
        final q1 = received.whereType<QuestionAsked>().first;
        inputs.add(
          AnswerChunk(
            clientSeq: 1,
            questionId: q1.questionId,
            textSoFar: 'x' * 100,
          ),
        );
        inputs.add(
          AnswerSubmitted(
            clientSeq: 2,
            questionId: q1.questionId,
            transcript: 'I used Dart isolates',
            answerDuration: const Duration(seconds: 42),
          ),
        );
        await waitFor(() => received.whereType<QuestionAsked>().length == 2);
        final q2 = received.whereType<QuestionAsked>().last;
        expect(q2.isFollowUp, isTrue);
        inputs.add(
          AnswerSubmitted(
            clientSeq: 3,
            questionId: q2.questionId,
            transcript: 'b',
          ),
        );
        await done.future.timeout(const Duration(seconds: 10));

        final labels = [
          for (final e in received)
            switch (e) {
              QuestionAsked() => 'Q',
              AnswerReceived() => 'R',
              ScoreUpdate(:final isPartial) => isPartial ? 'P' : 'S',
              AnswerEvaluated() => 'E',
              InterviewNotice(:final code) => 'N:$code',
              InterviewFinished() => 'F',
            },
        ];
        expect(labels, ['Q', 'P', 'R', 'Q', 'E', 'S', 'R', 'E', 'S', 'F']);
        expect(received.map((e) => e.sequence), List.generate(10, (i) => i));
        final finishedEvent = received.last as InterviewFinished;
        expect(finishedEvent.overallScore, 50); // mean of 70,60,50,40,30
        expect(fake.partials, 1);
        expect(fake.evaluations, 2);

        final s = await endpoints.interview.getInterview(authed, id);
        expect(s!.status, InterviewStatus.completed);
        expect(s.questionCount, 2);
        expect(s.overallScore, 50);
        expect(s.questions, hasLength(2));
        final a1 = s.questions!.first.answers!.single;
        expect(a1.feedback!.skillDeltas, {'Dart': -15.0});
        expect(a1.scores!.communication, 70);
        expect(a1.answerDuration, const Duration(seconds: 42));

        final profile = await SkillProfile.db.findFirstRow(
          sb.build(),
          where: (t) => t.authUserId.equals(userId),
        );
        expect(profile!.sessionsCompleted, 1);
        expect(profile.skillGraph['dart']!.level, 20); // 50 - 15 - 15
        expect(profile.weaknesses.single.skill, 'dart');
        expect(profile.weaknesses.single.exampleAnswerIds, hasLength(2));

        final embedRows = await FutureCallEntry.db.count(
          sb.build(),
          where: (t) => t.identifier.like('embed-%'),
        );
        expect(embedRows, 2);
        await inputs.close();
      },
    );

    test('when the client cancels then the interview is marked interrupted, '
        'and reconnecting re-asks the same question', () async {
      final interview = await endpoints.interview.start(
        authed,
        'Backend',
        null,
      );
      final id = interview.id!;
      final inputs1 = StreamController<CandidateInput>();
      final first = <InterviewEvent>[];
      final sub = endpoints.interview
          .conduct(authed, id, inputs1.stream)
          .listen(first.add);
      await waitFor(() => first.whereType<QuestionAsked>().isNotEmpty);
      await sub.cancel();
      await waitFor(() => true);
      final deadline = DateTime.now().add(const Duration(seconds: 10));
      InterviewSession? row;
      while (DateTime.now().isBefore(deadline)) {
        row = await InterviewSession.db.findById(sb.build(), id);
        if (row!.status == InterviewStatus.interrupted) break;
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
      expect(row!.status, InterviewStatus.interrupted);
      unawaited(inputs1.close());

      final inputs2 = StreamController<CandidateInput>();
      final second = <InterviewEvent>[];
      final sub2 = endpoints.interview
          .conduct(authed, id, inputs2.stream)
          .listen(second.add);
      await waitFor(() => second.whereType<QuestionAsked>().isNotEmpty);
      expect(
        second.whereType<QuestionAsked>().single.questionId,
        first.whereType<QuestionAsked>().single.questionId,
      );
      expect(
        await Question.db.count(
          sb.build(),
          where: (t) => t.interviewSessionId.equals(id),
        ),
        1,
      );
      expect(fake.questions, 1);
      await sub2.cancel();
      unawaited(inputs2.close());
    });

    test('when another user opens the stream then InterviewAccessException '
        'is emitted', () async {
      final interview = await endpoints.interview.start(
        authed,
        'Backend',
        null,
      );
      final otherId = (await const AuthUsers().create(sb.build())).id;
      final other = sb.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherId.uuid,
          <Scope>{},
        ),
      );
      final inputs = StreamController<CandidateInput>();
      await expectLater(
        endpoints.interview.conduct(other, interview.id!, inputs.stream),
        emitsThrough(
          emitsError(
            isA<InterviewAccessException>().having(
              (e) => e.reason,
              'reason',
              'not_found',
            ),
          ),
        ),
      );
      expect(
        await endpoints.interview.getInterview(other, interview.id!),
        isNull,
      );
      unawaited(inputs.close());
    });

    test('when the embedding future call runs then career memory finds the '
        'answer for its owner only', () async {
      final embedder = FakeEmbedder();
      embeddingClientFactory = (_) => embedder;
      final session = sb.build();
      final s = await InterviewSession.db.insertRow(
        session,
        InterviewSession(authUserId: userId, targetRole: 'Backend'),
      );
      final q = await Question.db.insertRow(
        session,
        Question(
          interviewSessionId: s.id!,
          orderIndex: 0,
          category: QuestionCategory.technical,
          prompt: 'p',
          targetSkills: [],
        ),
      );
      final a = await Answer.db.insertRow(
        session,
        Answer(authUserId: userId, questionId: q.id!, transcript: 't'),
      );
      await endpoints.futureCalls.answerEmbedding.embed(sb, a.id!);
      await endpoints.futureCalls.answerEmbedding.embed(
        sb,
        a.id!,
      ); // idempotent
      expect(embedder.calls, 1);
      final read = await Answer.db.findById(session, a.id!);
      expect(read!.embedding!.length, embeddingDimension);
      expect(read.embeddingModel, 'fake-embed');

      final hits = await CareerMemory.nearestAnswers(
        session,
        Vector(fakeVector(0)),
        authUserId: userId,
        maxDistance: 0.1,
      );
      expect(hits.map((h) => h.id), [a.id]);
      final none = await CareerMemory.nearestAnswers(
        session,
        Vector(fakeVector(0)),
        authUserId: (await const AuthUsers().create(session)).id,
      );
      expect(none, isEmpty);
    });

    test('when an auth user is deleted then all owned rows cascade and a '
        'deleted resume nulls interview_session.resumeId', () async {
      final session = sb.build();
      final r = await Resume.db.insertRow(
        session,
        Resume(
          authUserId: userId,
          fileName: 'cv.pdf',
          storagePath: 'resumes/x/${userId.uuid}.pdf',
          sizeBytes: 10,
          parsedData: ParsedResume(
            skills: [ExtractedSkill(name: 'Dart')],
            experience: [],
            education: [],
          ),
        ),
      );
      expect(r.status, ResumeParseStatus.awaitingUpload);
      final s = await InterviewSession.db.insertRow(
        session,
        InterviewSession(authUserId: userId, targetRole: 'X', resumeId: r.id),
      );
      final readBack = await Resume.db.findById(session, r.id!);
      expect(readBack!.parsedData!.skills.single.confidence, 0.5);
      await Resume.db.deleteRow(session, r);
      expect(
        (await InterviewSession.db.findById(session, s.id!))!.resumeId,
        isNull,
      );

      await session.db.unsafeExecute(
        r'DELETE FROM "serverpod_auth_core_user" WHERE "id" = @id::uuid',
        parameters: QueryParameters.named({'id': userId.uuid}),
      );
      expect(
        await InterviewSession.db.count(
          session,
          where: (t) => t.authUserId.equals(userId),
        ),
        0,
      );
    });
  });
}
