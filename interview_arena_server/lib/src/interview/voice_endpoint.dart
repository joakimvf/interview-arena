import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart'; // authUserId extension

import '../ai/tts.dart';
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
    _requested.add(questionId);
    if (_requested.length > _maxRequested) _requested.remove(_requested.first);
    final bytes = await audioFor(session, q);
    return bytes == null ? null : ByteData.sublistView(bytes);
  }

  /// Whether the client asked to hear [questionId], i.e. it is in voice mode.
  /// The interview stream only prefetches the next question's audio then.
  static bool audioWasRequested(int questionId) =>
      _requested.contains(questionId);

  /// Shared by the interview stream (which prefetches the next question in
  /// voice mode) and [questionAudio], so each question is synthesized once.
  static Future<Uint8List?> audioFor(Session session, Question q) {
    final tts = speechSynthesizerFactory(session);
    if (tts == null) return Future.value(null);
    final id = q.id!;
    // Remove and re-insert to keep the most recently used entries.
    final audio = _cache.remove(id) ?? tts.synthesize(q.prompt);
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

  static const _maxCached = 64;
  static final _cache = <int, Future<Uint8List>>{};

  static const _maxRequested = 1024;
  static final _requested = <int>{}; // insertion-ordered
}
