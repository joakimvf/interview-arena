import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart'; // authUserId extension

import '../ai/tts.dart';
import '../costs/ai_usage_tracker.dart';
import '../generated/protocol.dart';

/// The interviewer's voice: questions read aloud via ElevenLabs.
class VoiceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// MP3 of the question read aloud, or null when no voice is configured.
  Future<ByteData?> questionAudio(Session session, int questionId) async {
    final q = await Question.db.findById(
      session,
      questionId,
      include: Question.include(interviewSession: InterviewSession.include()),
    );
    if (q == null ||
        q.interviewSession?.authUserId != session.authenticated!.authUserId) {
      throw InterviewAccessException(reason: 'not_found');
    }
    final bytes = await audioFor(session, q);
    return bytes == null ? null : ByteData.sublistView(bytes);
  }

  /// Shared by the interview stream (which prefetches the next question in
  /// voice mode) and [questionAudio], so each question is synthesized once.
  static Future<Uint8List?> audioFor(Session session, Question q) {
    final tts = speechSynthesizerFactory(session);
    if (tts == null) return Future.value(null);
    final id = q.id!;
    // Remove and re-insert to keep the most recently used entries.
    final audio = _cache.remove(id) ?? _synthesize(session, tts, q);
    _cache[id] = audio;
    if (_cache.length > _maxCached) _cache.remove(_cache.keys.first);
    // Don't cache failures, so the next request retries.
    audio.then(
      (_) {},
      onError: (Object _) {
        if (identical(_cache[id], audio)) _cache.remove(id);
      },
    );
    return audio;
  }

  /// Synthesizes [q] and records the characters it cost.
  static Future<Uint8List> _synthesize(
    Session session,
    SpeechSynthesizer tts,
    Question q,
  ) async {
    final bytes = await tts.synthesize(q.prompt);
    await AiUsageTracker.recordVoice(
      session,
      model: tts.modelId,
      characters: q.prompt.length,
      context: (
        authUserId: session.authenticated?.authUserId,
        interviewSessionId: q.interviewSessionId,
        resumeId: null,
      ),
    );
    return bytes;
  }

  static const _maxCached = 64;
  static final _cache = <int, Future<Uint8List>>{};
}
