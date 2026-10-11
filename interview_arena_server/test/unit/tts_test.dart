import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:interview_arena_server/src/ai/tts.dart';
import 'package:test/test.dart';

void main() {
  test(
    'resolves a premade voice once, then posts the text to ElevenLabs',
    () async {
      final requests = <http.Request>[];
      final client = MockClient((req) async {
        requests.add(req);
        if (req.url.path == '/v1/voices') {
          return http.Response(
            jsonEncode({
              'voices': [
                {'voice_id': 'cloned-1', 'category': 'cloned'},
                {'voice_id': 'premade-1', 'category': 'premade'},
              ],
            }),
            200,
          );
        }
        return http.Response.bytes([1, 2, 3], 200);
      });
      final tts = ElevenLabsSynthesizer(apiKey: 'test-key', httpClient: client);

      expect(await tts.synthesize('Tell me about yourself.'), [1, 2, 3]);
      expect(await tts.synthesize('Next question.'), [1, 2, 3]);

      // Voices are listed once per process, not per question.
      expect(requests.map((r) => r.url.path), [
        '/v1/voices',
        '/v1/text-to-speech/premade-1',
        '/v1/text-to-speech/premade-1',
      ]);
      final speak = requests[1];
      expect(speak.method, 'POST');
      expect(speak.headers['xi-api-key'], 'test-key');
      expect(speak.url.queryParameters['output_format'], 'mp3_44100_64');
      expect(jsonDecode(speak.body), {
        'text': 'Tell me about yourself.',
        'model_id': 'eleven_v4_turbo',
      });
    },
  );

  test('a configured voice is used directly; errors carry no key', () async {
    final client = MockClient((req) async {
      expect(req.url.path, '/v1/text-to-speech/my-voice');
      return http.Response('{"detail":"quota_exceeded"}', 401);
    });
    final tts = ElevenLabsSynthesizer(
      apiKey: 'secret-key',
      voiceId: 'my-voice',
      httpClient: client,
    );
    await expectLater(
      tts.synthesize('Hi'),
      throwsA(
        isA<http.ClientException>().having(
          (e) => e.message,
          'message',
          allOf(contains('401'), isNot(contains('secret-key'))),
        ),
      ),
    );
  });
}
