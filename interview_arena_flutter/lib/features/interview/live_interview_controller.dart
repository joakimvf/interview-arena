import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/client_providers.dart';
import '../../core/data_providers.dart';
import 'live_interview_connection.dart';

enum LiveStatus { connecting, live, finished, failed }

class LiveInterviewState {
  const LiveInterviewState({
    this.status = LiveStatus.connecting,
    this.targetRole,
    this.maxQuestions,
    this.language,
    this.question,
    this.awaitingNext = false,
    this.partialScores,
    this.scores,
    this.lastFeedback,
    this.lastFeedbackQuestion,
    this.finished,
    this.notice,
    this.error,
    this.resumable = false,
  });

  final LiveStatus status;
  final String? targetRole;
  final int? maxQuestions;

  /// BCP 47 tag of the interview language (from the CV), e.g. sv-SE.
  final String? language;

  /// The question currently on screen.
  final QuestionAsked? question;

  /// True after submitting, until the next question (or the result) arrives.
  final bool awaitingNext;

  /// Live estimate for the answer being typed or spoken.
  final InterviewScores? partialScores;

  /// Average over all evaluated answers so far.
  final InterviewScores? scores;
  final AnswerFeedback? lastFeedback;
  final String? lastFeedbackQuestion;
  final InterviewFinished? finished;

  /// Latest non-fatal problem; the screen shows each new one once.
  final InterviewNotice? notice;
  final Object? error;
  final bool resumable;
}

/// Owns the subscription itself: no Riverpod pause-when-hidden, no auto-retry
/// that would silently re-open a server stream.
final liveInterviewProvider = NotifierProvider.autoDispose
    .family<LiveInterviewController, LiveInterviewState, int>(
      LiveInterviewController.new,
    );

class LiveInterviewController extends Notifier<LiveInterviewState> {
  LiveInterviewController(this.interviewSessionId);
  final int interviewSessionId;
  late LiveInterviewConnection _conn;

  var _status = LiveStatus.connecting;
  String? _targetRole;
  int? _maxQuestions;
  String? _language;
  QuestionAsked? _question;
  var _awaitingNext = false;
  InterviewScores? _partial;
  InterviewScores? _scores;
  AnswerFeedback? _feedback;
  String? _feedbackQuestion;
  InterviewFinished? _finished;
  InterviewNotice? _notice;
  Object? _error;
  var _resumable = false;
  final _prompts = <int, String>{};

  /// Last mode sent to the server; re-sent after a reconnect, since the
  /// server starts every stream in typing mode.
  bool? _voiceMode;

  @override
  LiveInterviewState build() {
    // build() reruns on reconnect; the server replays question and scores.
    _status = LiveStatus.connecting;
    _question = null;
    _awaitingNext = false;
    _partial = null;
    _finished = null;
    _notice = null;
    _error = null;
    _resumable = false;
    final client = ref.watch(clientProvider);
    _conn = LiveInterviewConnection(client, interviewSessionId);
    _conn.connect(onEvent: _onEvent, onError: _onError, onDone: _onDone);
    if (_voiceMode case final enabled?) _conn.voiceMode(enabled: enabled);
    ref.onDispose(() => unawaited(_conn.dispose()));
    unawaited(_loadDetails(client));
    return const LiveInterviewState();
  }

  /// Role, question count and language (for speech recognition); the stream
  /// doesn't carry them.
  Future<void> _loadDetails(Client client) async {
    try {
      final s = await client.interview.getInterview(interviewSessionId);
      if (!ref.mounted || s == null) return;
      _targetRole = s.targetRole;
      _maxQuestions = s.maxQuestions;
      _language = s.resume?.parsedData?.language;
      _emit();
    } catch (_) {
      // Header details are cosmetic; the stream reports real failures.
    }
  }

  void _onEvent(InterviewEvent event) {
    if (!ref.mounted) return;
    if (_status == LiveStatus.connecting) _status = LiveStatus.live;
    switch (event) {
      case QuestionAsked():
        _question = event;
        _prompts[event.questionId] = event.prompt;
        _awaitingNext = false;
        _partial = null;
      case AnswerReceived():
        break;
      case ScoreUpdate(:final isPartial, :final scores, :final questionId):
        if (!isPartial) {
          _scores = scores;
        } else if (questionId == _question?.questionId && !_awaitingNext) {
          _partial = scores;
        }
      case AnswerEvaluated(:final feedback, :final questionId):
        _feedback = feedback;
        _feedbackQuestion = _prompts[questionId];
      case InterviewNotice():
        _notice = event;
      case InterviewFinished():
        _finished = event;
        _status = LiveStatus.finished;
        _awaitingNext = false;
        ref.invalidate(interviewsProvider);
    }
    _emit();
  }

  void _onError(Object error, {required bool resumable}) {
    if (!ref.mounted) return;
    _status = LiveStatus.failed;
    _error = error;
    _resumable = resumable;
    _emit();
  }

  void _onDone() {
    if (!ref.mounted) return;
    if (_status == LiveStatus.finished || _status == LiveStatus.failed) return;
    // Closed without a result: the server keeps the interview, so reconnect.
    _onError('The connection closed.', resumable: true);
  }

  void _emit() => state = LiveInterviewState(
    status: _status,
    targetRole: _targetRole,
    maxQuestions: _maxQuestions,
    language: _language,
    question: _question,
    awaitingNext: _awaitingNext,
    partialScores: _partial,
    scores: _scores,
    lastFeedback: _feedback,
    lastFeedbackQuestion: _feedbackQuestion,
    finished: _finished,
    notice: _notice,
    error: _error,
    resumable: _resumable,
  );

  bool get canAnswer =>
      _status == LiveStatus.live && _question != null && !_awaitingNext;

  void partial(String text) {
    if (canAnswer) _conn.partial(_question!.questionId, text);
  }

  /// Returns false if there is nothing to submit right now.
  bool submit(String transcript, Duration duration) {
    if (!canAnswer || transcript.trim().isEmpty) return false;
    _conn.submit(_question!.questionId, transcript.trim(), duration);
    _awaitingNext = true;
    _partial = null;
    _emit();
    return true;
  }

  /// Tells the server whether to prepare spoken questions.
  void setVoiceMode({required bool enabled}) {
    if (_voiceMode == enabled) return;
    _voiceMode = enabled;
    _conn.voiceMode(enabled: enabled);
  }

  void end() {
    if (_status != LiveStatus.live) return;
    _conn.end();
    _awaitingNext = true;
    _emit();
  }

  /// Explicit reconnect after a resumable error: the server resumes from DB.
  void reconnect() => ref.invalidateSelf();
}
