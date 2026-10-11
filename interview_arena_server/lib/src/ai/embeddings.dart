import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Must equal `Vector(1024)` in answer.spy.yaml.
const embeddingDimension = 1024;

abstract interface class EmbeddingClient {
  String get modelId;
  Future<List<List<double>>> embed(List<String> texts, {required bool isQuery});
}

/// Null when no key is configured: embeddings are optional in pass 1.
EmbeddingClient? Function(Session session) embeddingClientFactory = (session) {
  final key = session.passwords['voyageApiKey'];
  if (key == null || key.isEmpty) return null;
  // Optional: set voyageEndpoint to https://ai.mongodb.com/v1/embeddings for
  // MongoDB Atlas model API keys.
  final endpoint = session.passwords['voyageEndpoint'];
  return VoyageEmbeddingClient(
    apiKey: key,
    endpoint: endpoint == null ? null : Uri.parse(endpoint),
  );
};

class VoyageEmbeddingClient implements EmbeddingClient {
  VoyageEmbeddingClient({
    required this.apiKey,
    http.Client? httpClient,
    Uri? endpoint,
    this.modelId = 'voyage-4',
  }) : _http = httpClient ?? http.Client(),
       _endpoint =
           endpoint ?? Uri.parse('https://api.voyageai.com/v1/embeddings');

  final String apiKey;
  final http.Client _http;
  final Uri _endpoint;
  @override
  final String modelId;

  @override
  Future<List<List<double>>> embed(
    List<String> texts, {
    required bool isQuery,
  }) async {
    // Future calls run one at a time by default, so a hung request would
    // stall resume parsing too.
    final res = await _http
        .post(
          _endpoint,
          headers: {
            'content-type': 'application/json',
            'authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            'input': texts,
            'model': modelId,
            'input_type': isQuery ? 'query' : 'document',
            'output_dimension': embeddingDimension,
            'output_dtype': 'float',
          }),
        )
        .timeout(const Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw http.ClientException('Voyage ${res.statusCode}', _endpoint);
    }
    final data = (jsonDecode(res.body) as Map<String, dynamic>)['data'] as List;
    final out = List<List<double>>.filled(texts.length, const []);
    for (final d in data.cast<Map<String, dynamic>>()) {
      out[d['index'] as int] = [
        for (final v in d['embedding'] as List) (v as num).toDouble(),
      ];
    }
    return out;
  }
}
