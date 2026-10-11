import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Turns interviewer text into speech (MP3).
abstract interface class SpeechSynthesizer {
  Future<Uint8List> synthesize(String text);
}

/// Null when no key is configured: the app then shows questions as text only.
/// Optional `elevenLabsVoiceId` picks a voice; otherwise the account's first
/// premade voice is used.
SpeechSynthesizer? Function(Session session) speechSynthesizerFactory =
    (session) {
      final key = session.passwords['elevenLabsApiKey'];
      if (key == null || key.isEmpty) return null;
      return ElevenLabsSynthesizer(
        apiKey: key,
        voiceId: session.passwords['elevenLabsVoiceId'],
      );
    };

class ElevenLabsSynthesizer implements SpeechSynthesizer {
  ElevenLabsSynthesizer({
    required this.apiKey,
    this.voiceId,
    http.Client? httpClient,
    this.modelId = 'eleven_v4_turbo', // ElevenLabs' real-time model
  }) : _http = httpClient ?? http.Client();

  static final _base = Uri.parse('https://api.elevenlabs.io');
  static const _timeout = Duration(seconds: 20);

  /// Resolved once per server process when no voice id is configured.
  static String? _defaultVoiceId;

  final String apiKey;
  final String modelId;
  final String? voiceId;
  final http.Client _http;

  Map<String, String> get _headers => {'xi-api-key': apiKey};

  Future<String> _voice() async {
    final configured = voiceId;
    if (configured != null && configured.isNotEmpty) return configured;
    final cached = _defaultVoiceId;
    if (cached != null) return cached;
    final res = await _http
        .get(_base.resolve('/v1/voices'), headers: _headers)
        .timeout(_timeout);
    if (res.statusCode != 200) {
      throw http.ClientException('ElevenLabs voices ${res.statusCode}');
    }
    final voices = ((jsonDecode(res.body) as Map)['voices'] as List)
        .cast<Map<String, dynamic>>();
    if (voices.isEmpty) throw http.ClientException('No ElevenLabs voices');
    final premade = voices.where((v) => v['category'] == 'premade');
    final v = premade.isNotEmpty ? premade.first : voices.first;
    return _defaultVoiceId = v['voice_id'] as String;
  }

  @override
  Future<Uint8List> synthesize(String text) async {
    final voice = await _voice();
    final res = await _http
        .post(
          _base.resolve(
            '/v1/text-to-speech/$voice?output_format=mp3_44100_64',
          ),
          headers: {
            ..._headers,
            'content-type': 'application/json',
            'accept': 'audio/mpeg',
          },
          body: jsonEncode({'text': text, 'model_id': modelId}),
        )
        .timeout(_timeout);
    if (res.statusCode != 200) {
      throw http.ClientException('ElevenLabs TTS ${res.statusCode}');
    }
    return res.bodyBytes;
  }
}
