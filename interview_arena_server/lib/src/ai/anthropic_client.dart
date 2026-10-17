import 'dart:async';
import 'dart:convert';
import 'dart:io' show IOException;
import 'dart:math';

import 'package:http/http.dart' as http;

/// Thrown for non-2xx responses.
class ClaudeApiException implements Exception {
  ClaudeApiException({
    required this.statusCode,
    required this.type,
    required this.message,
    this.requestId,
    this.retryAfter,
    this.errorCode,
  });

  final int statusCode;
  final String type; // e.g. rate_limit_error, overloaded_error
  final String message;
  final String? requestId;
  final Duration? retryAfter;
  final String? errorCode; // error.details.error_code (spend cap 429)

  /// Mirrors the official SDKs: 408/409/429/5xx are retryable, except the
  /// monthly spend-cap 429 (no retry-after, error_code enforced_spend_limit_reached).
  bool get retryable {
    if (errorCode == 'enforced_spend_limit_reached') return false;
    return statusCode == 408 ||
        statusCode == 409 ||
        statusCode == 429 ||
        statusCode >= 500;
  }

  @override
  String toString() =>
      'ClaudeApiException($statusCode $type: $message, requestId=$requestId)';
}

class ClaudeHttpClient {
  ClaudeHttpClient({
    required this.apiKey,
    http.Client? httpClient,
    Uri? baseUrl,
    this.maxRetries = 3,
    this.betas = const [],
  }) : _http = httpClient ?? http.Client(),
       _base = baseUrl ?? Uri.parse('https://api.anthropic.com');

  final String apiKey;
  final http.Client _http;
  final Uri _base;
  final int maxRetries;
  final List<String> betas;
  final _rand = Random();

  Map<String, String> _headers(List<String> extraBetas) {
    final allBetas = {...betas, ...extraBetas};
    return {
      'content-type': 'application/json',
      'x-api-key': apiKey,
      'anthropic-version': '2023-06-01',
      if (allBetas.isNotEmpty) 'anthropic-beta': allBetas.join(','),
    };
  }

  /// POST /v1/messages with retries. Returns the Message JSON.
  ///
  /// Not streamed: every route asks for a short structured answer with a
  /// modest max_tokens, so the response arrives well within [timeout].
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> body, {
    List<String> extraBetas = const [],
    Duration timeout = const Duration(minutes: 3),
  }) async {
    final res = await _sendWithRetry(
      () => http.Request('POST', _base.resolve('/v1/messages'))
        ..headers.addAll(_headers(extraBetas))
        ..body = jsonEncode(body),
      timeout: timeout,
    );
    final text = await res.stream.bytesToString();
    return jsonDecode(text) as Map<String, dynamic>;
  }

  Future<http.StreamedResponse> _sendWithRetry(
    http.BaseRequest Function() build, {
    required Duration timeout,
  }) async {
    for (var attempt = 0; ; attempt++) {
      try {
        final res = await _http.send(build()).timeout(timeout);
        if (res.statusCode >= 200 && res.statusCode < 300) return res;
        final ex = await _toException(res);
        if (!ex.retryable || attempt >= maxRetries) throw ex;
        await Future<void>.delayed(ex.retryAfter ?? _backoff(attempt));
      } on ClaudeApiException {
        rethrow;
      } on Object catch (e) {
        final transient =
            e is http.ClientException ||
            e is IOException ||
            e is TimeoutException;
        if (!transient || attempt >= maxRetries) rethrow;
        await Future<void>.delayed(_backoff(attempt));
      }
    }
  }

  /// Exponential backoff with full jitter: 0.5s, 1s, 2s, 4s ... capped at 8s.
  Duration _backoff(int attempt) {
    final capMs = min(8000, 500 * pow(2, attempt).toInt());
    return Duration(milliseconds: _rand.nextInt(capMs) + 1);
  }

  Future<ClaudeApiException> _toException(http.StreamedResponse res) async {
    final raw = await res.stream.bytesToString();
    Map<String, dynamic>? err;
    try {
      err =
          (jsonDecode(raw) as Map<String, dynamic>)['error']
              as Map<String, dynamic>?;
    } on Object {
      err = null;
    }
    final ra = int.tryParse(res.headers['retry-after'] ?? '');
    return ClaudeApiException(
      statusCode: res.statusCode,
      type: err?['type'] as String? ?? 'http_${res.statusCode}',
      message: err?['message'] as String? ?? raw,
      requestId: res.headers['request-id'],
      retryAfter: ra == null ? null : Duration(seconds: ra),
      errorCode: (err?['details'] as Map?)?['error_code'] as String?,
    );
  }

  void close() => _http.close();
}

/// First visible text block (responses can begin with thinking blocks).
/// After a mid-output server-side fallback, text before the LAST `fallback`
/// block is the abandoned partial answer, so only text after it counts.
String? firstText(Map<String, dynamic> message) {
  final content = message['content'] as List? ?? const [];
  final start =
      content.lastIndexWhere((b) => b is Map && b['type'] == 'fallback') + 1;
  for (final b in content.skip(start)) {
    if (b is Map && b['type'] == 'text') return b['text'] as String?;
  }
  return null;
}
