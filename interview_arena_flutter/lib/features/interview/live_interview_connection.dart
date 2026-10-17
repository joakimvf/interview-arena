import 'dart:async';

import 'package:interview_arena_client/interview_arena_client.dart';

/// Owns one `conduct` stream. Use from a Riverpod Notifier (NOT a
/// StreamProvider: Riverpod 3 pauses/retries those, which re-opens streams).
class LiveInterviewConnection {
  LiveInterviewConnection(this.client, this.interviewSessionId);

  final Client client;
  final int interviewSessionId;
  StreamController<CandidateInput>? _inputs;
  StreamSubscription<InterviewEvent>? _sub;
  var _clientSeq = 0;

  void connect({
    required void Function(InterviewEvent event) onEvent,
    required void Function(Object error, {required bool resumable}) onError,
    required void Function() onDone,
  }) {
    final inputs = _inputs = StreamController<CandidateInput>();
    // Opens NOW (not on listen); single-subscription.
    _sub = client.interview
        .conduct(interviewSessionId, inputs.stream)
        .listen(
          onEvent,
          onError: (Object e) => switch (e) {
            InterviewAccessException() => onError(e, resumable: false),
            ServerpodClientUnauthorized() => onError(e, resumable: false),
            MethodStreamException() => onError(e, resumable: true),
            _ => onError(e, resumable: false),
          },
          onDone: onDone, // also fires on sign-out / user switch
        );
  }

  void partial(int questionId, String textSoFar) => _inputs?.add(
    AnswerChunk(
      clientSeq: _clientSeq++,
      questionId: questionId,
      textSoFar: textSoFar,
    ),
  );

  void submit(int questionId, String transcript, Duration duration) =>
      _inputs?.add(
        AnswerSubmitted(
          clientSeq: _clientSeq++,
          questionId: questionId,
          transcript: transcript,
          answerDuration: duration,
        ),
      );

  /// Speaking or typing; the server only makes question audio in voice mode.
  void voiceMode({required bool enabled}) => _inputs?.add(
    VoiceModeChanged(clientSeq: _clientSeq++, enabled: enabled),
  );

  void end() => _inputs?.add(EndInterview(clientSeq: _clientSeq++));

  Future<void> dispose() async {
    await _sub?.cancel();
    // Never await close(): a never-listened controller's close never completes.
    unawaited(_inputs?.close());
  }
}
