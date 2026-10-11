import 'dart:async';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart'; // authUserId extension

import '../ai/interview_ai.dart';
import '../generated/future_calls.dart'; // ServerpodFutureCallsGetter
import '../generated/protocol.dart';
import '../skills/skill_graph.dart';
import 'voice_endpoint.dart';

class InterviewEndpoint extends Endpoint {
  /// Enforced at stream open (before the body runs) and enables the server's
  /// revoked-auth listener that closes the stream on sign-out.
  @override
  bool get requireLogin => true;

  /// Live partial scoring throttle (tests set Duration.zero).
  static Duration partialScoreInterval = const Duration(seconds: 8);
  static const minPartialChars = 80;
  static const fallbackQuestion =
      'Tell me about a project you are proud of and your role in it.';

  static InterviewSessionInclude _include() => InterviewSession.include(
    resume: Resume.include(),
    questions: Question.includeList(
      orderBy: (t) => t.orderIndex,
      include: Question.include(
        answers: Answer.includeList(orderBy: (t) => t.createdAt),
      ),
    ),
  );

  Future<InterviewSession> start(
    Session session,
    String targetRole,
    int? resumeId,
  ) async {
    final authUserId = session.authenticated!.authUserId;
    if (resumeId != null) {
      final resume = await Resume.db.findById(session, resumeId);
      if (resume == null || resume.authUserId != authUserId) {
        throw InterviewAccessException(reason: 'not_found');
      }
    }
    return InterviewSession.db.insertRow(
      session,
      InterviewSession(
        authUserId: authUserId,
        resumeId: resumeId,
        targetRole: targetRole,
      ),
    );
  }

  Future<InterviewSession?> getInterview(
    Session session,
    int interviewSessionId,
  ) async {
    final s = await InterviewSession.db.findById(
      session,
      interviewSessionId,
      include: _include(),
    );
    if (s == null || s.authUserId != session.authenticated!.authUserId) {
      return null;
    }
    return s;
  }

  Future<List<InterviewSession>> listInterviews(Session session) {
    final authUserId = session.authenticated!.authUserId;
    return InterviewSession.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderByList: (t) => [t.startedAt.desc()],
      limit: 50,
    );
  }

  /// The live interview. Persist-first: every answer is stored before the slow
  /// evaluation, so a disconnect loses nothing; reconnecting resumes from DB.
  Stream<InterviewEvent> conduct(
    Session session,
    int interviewSessionId,
    Stream<CandidateInput> inputs,
  ) async* {
    final authUserId = session.authenticated!.authUserId;
    final loaded = await InterviewSession.db.findById(
      session,
      interviewSessionId,
      include: _include(),
    );
    if (loaded == null || loaded.authUserId != authUserId) {
      throw InterviewAccessException(reason: 'not_found');
    }
    if (loaded.status == InterviewStatus.completed ||
        loaded.status == InterviewStatus.abandoned) {
      throw InterviewAccessException(reason: 'wrong_state');
    }
    final InterviewSession interview = loaded;
    final id = interview.id!;
    await InterviewSession.db.updateById(
      session,
      id,
      columnValues: (t) => [t.status(InterviewStatus.active)],
    );

    final ai = interviewAiFactory(session);
    final questions = <Question>[...?interview.questions];
    final answered = <int, Answer>{
      for (final q in questions)
        if (q.answers?.isNotEmpty ?? false) q.id!: q.answers!.last,
    };
    var aggregate = interview.scores;
    var sequence = 0;
    var finished = false;

    // Safety net; on a client cancel the after-loop code runs first (spike B).
    session.addWillCloseListener((s) async {
      if (!finished) await _markInterrupted(s, id);
    });

    InterviewContext ctx() => InterviewContext(
      targetRole: interview.targetRole,
      maxQuestions: interview.maxQuestions,
      resume: interview.resume?.parsedData,
      turns: [
        for (final q in questions)
          if (answered[q.id] case final a?)
            (
              orderIndex: q.orderIndex,
              category: q.category,
              question: q.prompt,
              answer: a.transcript,
            ),
      ],
    );

    Future<Question> newQuestion() async {
      GeneratedQuestion g;
      try {
        g = await ai.nextQuestion(ctx());
      } catch (e) {
        session.log('nextQuestion failed: $e', level: LogLevel.warning);
        g = (
          prompt: fallbackQuestion,
          category: QuestionCategory.behavioral,
          targetSkills: const <String>[],
          isFollowUp: false,
        );
      }
      final q = await Question.db.insertRow(
        session,
        Question(
          interviewSessionId: id,
          orderIndex: questions.length,
          category: g.category,
          prompt: g.prompt,
          targetSkills: g.targetSkills,
          isFollowUp: g.isFollowUp,
        ),
      );
      questions.add(q);
      // Start synthesizing the spoken question now; the client's
      // questionAudio request then usually finds it ready.
      unawaited(
        VoiceEndpoint.audioFor(session, q).then(
          (_) {},
          onError: (Object e) =>
              session.log('question audio failed: $e', level: LogLevel.warning),
        ),
      );
      return q;
    }

    QuestionAsked asked(Question q) => QuestionAsked(
      interviewSessionId: id,
      sequence: sequence++,
      questionId: q.id!,
      orderIndex: q.orderIndex,
      category: q.category,
      prompt: q.prompt,
      isFollowUp: q.isFollowUp,
    );

    Future<InterviewFinished> finish() async {
      finished = true;
      // Null when no answer was evaluated: don't record that as a real 0/100.
      final scores = aggregate;
      final overall = scores == null ? null : _overall(scores);
      InterviewReport? report;
      String summary;
      try {
        report = scores == null ? null : await ai.report(ctx(), scores);
        summary =
            report?.summary ?? 'No answers could be scored in this interview.';
      } catch (e) {
        session.log('report failed: $e', level: LogLevel.warning);
        summary = 'Interview finished with ${answered.length} answer(s).';
      }
      await InterviewSession.db.updateById(
        session,
        id,
        columnValues: (t) => [
          t.status(InterviewStatus.completed),
          t.overallScore(overall),
          t.summary(summary),
          t.report(report),
          t.endedAt(DateTime.now().toUtc()),
        ],
      );
      if (scores != null) {
        final profile = await SkillGraph.getOrCreate(session, authUserId);
        final n = profile.sessionsCompleted;
        final prev = profile.averageScores;
        double mean(double Function(InterviewScores) f) =>
            prev == null ? f(scores) : (f(prev) * n + f(scores)) / (n + 1);
        await SkillProfile.db.updateRow(
          session,
          profile.copyWith(
            sessionsCompleted: n + 1,
            // Running mean over all scored interviews, not just the latest.
            averageScores: InterviewScores(
              communication: mean((s) => s.communication),
              confidence: mean((s) => s.confidence),
              technicalDepth: mean((s) => s.technicalDepth),
              completeness: mean((s) => s.completeness),
              structure: mean((s) => s.structure),
            ),
          ),
        );
      }
      return InterviewFinished(
        interviewSessionId: id,
        sequence: sequence++,
        overallScore: overall,
        scores: scores,
        summary: summary,
        report: report,
      );
    }

    // (Re)connect: replay latest scores and the current unanswered question.
    if (aggregate != null) {
      yield ScoreUpdate(
        interviewSessionId: id,
        sequence: sequence++,
        scores: aggregate,
      );
    }
    Question? current =
        questions.isNotEmpty && !answered.containsKey(questions.last.id)
        ? questions.last
        : null;
    if (current == null) {
      if (answered.length >= interview.maxQuestions) {
        yield await finish();
        return;
      }
      current = await newQuestion();
    }
    yield asked(current);

    var lastPartialAt = DateTime.fromMillisecondsSinceEpoch(0);
    await for (final input in inputs) {
      switch (input) {
        case AnswerChunk(:final questionId, :final textSoFar):
          final now = DateTime.now();
          if (questionId != current!.id ||
              textSoFar.length < minPartialChars ||
              now.difference(lastPartialAt) < partialScoreInterval) {
            break;
          }
          lastPartialAt = now;
          try {
            final scores = await ai.scorePartial(
              ctx(),
              current.prompt,
              textSoFar,
            );
            yield ScoreUpdate(
              interviewSessionId: id,
              sequence: sequence++,
              questionId: current.id,
              isPartial: true,
              scores: scores,
            );
          } catch (e) {
            yield _notice(id, sequence++, 'partial_score_failed', e);
          }

        case AnswerSubmitted(
          :final questionId,
          :final transcript,
          :final answerDuration,
        ):
          final q = current!;
          if (questionId != q.id) {
            yield _notice(id, sequence++, 'stale_question', questionId);
            break;
          }
          final answer = await Answer.db.insertRow(
            session,
            Answer(
              authUserId: authUserId,
              questionId: q.id!,
              transcript: transcript,
              answerDuration: answerDuration,
            ),
          );
          answered[q.id!] = answer;
          yield AnswerReceived(
            interviewSessionId: id,
            sequence: sequence++,
            questionId: q.id!,
            answerId: answer.id!,
          );
          // Evaluation (~10 s at high effort) and the next question are
          // independent, so run them together: the candidate sees the next
          // question while the previous answer is still being scored.
          // Errors are captured here so the pending future never fails
          // unobserved while we await the next question.
          Object? evalError;
          final evaluation = () async {
            try {
              final eval = await ai.evaluateAnswer(
                ctx(),
                q.prompt,
                transcript,
              );
              answered[q.id!] = await Answer.db.updateRow(
                session,
                answer.copyWith(scores: eval.scores, feedback: eval.feedback),
                columns: (t) => [t.scores, t.feedback],
              );
              final agg = _aggregate(answered.values);
              aggregate = agg;
              await InterviewSession.db.updateById(
                session,
                id,
                columnValues: (t) => [
                  t.scores(agg),
                  t.questionCount(answered.length),
                ],
              );
              await SkillGraph.applyEvaluation(
                session,
                authUserId,
                eval.feedback,
                answer.id!,
              );
              await session.serverpod.futureCalls
                  .callWithDelay(
                    Duration.zero,
                    identifier: 'embed-${answer.id}',
                  )
                  .answerEmbedding
                  .embed(answer.id!);
              return (eval: eval, agg: agg);
            } catch (e) {
              evalError = e;
              return null;
            }
          }();
          final isLast = answered.length >= interview.maxQuestions;
          if (!isLast) {
            current = await newQuestion();
            yield asked(current);
          }
          final result = await evaluation;
          if (result == null) {
            yield _notice(id, sequence++, 'evaluation_failed', evalError!);
          } else {
            yield AnswerEvaluated(
              interviewSessionId: id,
              sequence: sequence++,
              questionId: q.id!,
              answerId: answer.id!,
              scores: result.eval.scores,
              feedback: result.eval.feedback,
            );
            yield ScoreUpdate(
              interviewSessionId: id,
              sequence: sequence++,
              questionId: q.id,
              scores: result.agg,
            );
          }
          if (isLast) {
            yield await finish();
            return; // completes the output: client gets onDone
          }

        case EndInterview():
          yield await finish();
          return;
      }
    }
    // Inputs ended without EndInterview: cancel, input close or socket drop.
    // The input stream never throws on disconnect; the session is still open.
    await _markInterrupted(session, id);
  }

  static InterviewNotice _notice(int id, int seq, String code, Object detail) =>
      InterviewNotice(
        interviewSessionId: id,
        sequence: seq,
        code: code,
        message: '$detail',
      );

  static Future<void> _markInterrupted(Session session, int id) =>
      InterviewSession.db.updateWhere(
        session,
        columnValues: (t) => [t.status(InterviewStatus.interrupted)],
        where: (t) => t.id.equals(id) & t.status.equals(InterviewStatus.active),
      );

  static double _overall(InterviewScores s) =>
      (s.communication +
          s.confidence +
          s.technicalDepth +
          s.completeness +
          s.structure) /
      5;

  static InterviewScores _aggregate(Iterable<Answer> answers) {
    final scored = [for (final a in answers) ?a.scores];
    if (scored.isEmpty) return InterviewScores();
    double avg(double Function(InterviewScores) f) =>
        scored.map(f).reduce((a, b) => a + b) / scored.length;
    return InterviewScores(
      communication: avg((s) => s.communication),
      confidence: avg((s) => s.confidence),
      technicalDepth: avg((s) => s.technicalDepth),
      completeness: avg((s) => s.completeness),
      structure: avg((s) => s.structure),
    );
  }
}
