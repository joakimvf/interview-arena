import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_arena_client/interview_arena_client.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum VoicePhase {
  /// Voice mode is off (typing) or not started yet.
  off,

  /// Fetching the spoken question.
  preparing,

  /// The interviewer is talking; the mic is off so it doesn't hear itself.
  speaking,

  /// Recognizing the candidate's answer.
  listening,

  /// Answer sent; waiting for the next question or the results.
  waiting,
}

/// Turn-taking for a spoken interview: play the question (ElevenLabs audio
/// from the server), then listen until the candidate says they're done.
class InterviewVoice extends ChangeNotifier {
  InterviewVoice(this._client, {required this.onTranscript}) {
    _completeSub = _player.onPlayerComplete.listen((_) {
      if (phase == VoicePhase.speaking) unawaited(startListening());
    });
  }

  final Client _client;

  /// The full answer so far, on every recognition update.
  final void Function(String transcript) onTranscript;

  final _player = AudioPlayer();
  final _speech = SpeechToText();
  late final StreamSubscription<void> _completeSub;

  VoicePhase phase = VoicePhase.off;

  /// False once the server reports no voice configured (no ElevenLabs key).
  bool interviewerVoiceAvailable = true;

  /// False if speech recognition is unsupported or the mic was denied.
  bool micAvailable = true;

  String transcript = '';

  int? _questionId;
  Uint8List? _audio;
  var _speechReady = false;
  var _wantListening = false;

  /// Text from earlier recognition sessions within this answer. Browsers end
  /// a session after a pause; we restart and keep appending.
  var _committed = '';
  var _disposed = false;

  void _set(VoicePhase p) {
    if (_disposed) return;
    phase = p;
    notifyListeners();
  }

  /// A new question arrived: speak it, then listen.
  Future<void> ask(int questionId) async {
    await _stopListening();
    _questionId = questionId;
    _audio = null;
    transcript = '';
    _committed = '';
    onTranscript('');
    if (!interviewerVoiceAvailable) return startListening();
    _set(VoicePhase.preparing);
    try {
      final data = await _client.voice.questionAudio(questionId);
      if (_disposed || _questionId != questionId) return;
      if (data == null) {
        interviewerVoiceAvailable = false;
        await startListening();
        return;
      }
      _audio = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await _play();
    } catch (e) {
      debugPrint('Question audio failed: $e');
      if (!_disposed && _questionId == questionId) await startListening();
    }
  }

  Future<void> _play() async {
    final audio = _audio;
    if (audio == null) return startListening();
    _set(VoicePhase.speaking);
    try {
      await _player.play(BytesSource(audio, mimeType: 'audio/mpeg'));
    } catch (e) {
      // E.g. the browser blocked autoplay: the candidate can tap replay.
      debugPrint('Playing question audio failed: $e');
      await startListening();
    }
  }

  /// Hear the question again; the answer so far is kept.
  Future<void> replay() async {
    if (_audio == null) return;
    await _stopListening();
    _committed = transcript;
    await _play();
  }

  Future<void> startListening() async {
    if (_disposed) return;
    if (!_speechReady) {
      try {
        _speechReady = await _speech.initialize(
          onStatus: _onStatus,
          onError: (e) {
            debugPrint('Speech error: ${e.errorMsg}');
            if (e.permanent && e.errorMsg.contains('permission')) {
              _micUnavailable();
            }
          },
        );
      } catch (e) {
        debugPrint('Speech init failed: $e');
      }
      if (!_speechReady) return _micUnavailable();
    }
    _wantListening = true;
    _set(VoicePhase.listening);
    await _listenOnce();
  }

  Future<void> _listenOnce() async {
    if (!_wantListening || _disposed) return;
    await _speech.listen(
      onResult: (r) {
        final words = r.recognizedWords.trim();
        transcript = [_committed, words].where((s) => s.isNotEmpty).join(' ');
        onTranscript(transcript);
        if (!_disposed) notifyListeners();
      },
      listenOptions: SpeechListenOptions(
        partialResults: true,
        listenMode: ListenMode.dictation,
        autoPunctuation: true,
        pauseFor: const Duration(seconds: 20),
        listenFor: const Duration(minutes: 5),
      ),
    );
  }

  void _onStatus(String status) {
    final ended = status == 'done' || status == 'notListening';
    if (!ended || !_wantListening || _disposed) return;
    // The recognizer stopped on its own (pause or timeout): keep listening.
    _committed = transcript;
    Future<void>.delayed(const Duration(milliseconds: 300), _listenOnce);
  }

  void _micUnavailable() {
    micAvailable = false;
    _wantListening = false;
    _set(VoicePhase.off);
  }

  Future<void> _stopListening() async {
    _wantListening = false;
    if (_speech.isListening) await _speech.stop();
  }

  /// The candidate is done: stop listening and return what was said.
  Future<String> finishAnswer() async {
    await _stopListening();
    final answer = transcript.trim();
    if (answer.isNotEmpty) _set(VoicePhase.waiting);
    return answer;
  }

  /// Resume listening after an empty "done" (nothing was caught).
  Future<void> keepListening() => startListening();

  /// Continue an answer by voice after typing part of it.
  Future<void> listenFrom(String text) {
    transcript = text.trim();
    _committed = transcript;
    return startListening();
  }

  /// Silence everything (typing mode, interview over, or leaving).
  Future<void> stop() async {
    await _stopListening();
    await _player.stop();
    _set(VoicePhase.off);
  }

  @override
  void dispose() {
    _disposed = true;
    _wantListening = false;
    unawaited(_completeSub.cancel());
    unawaited(_speech.cancel());
    unawaited(_player.dispose());
    super.dispose();
  }
}
