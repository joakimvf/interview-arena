import 'dart:async';
import 'dart:convert';
import 'dart:io' show IOException;
import 'dart:math';

import 'package:http/http.dart' as http;

import 'sse.dart';

/// Thrown for non-2xx responses and for in-stream `event: error`.
class ClaudeApiException implements Exception {
  ClaudeApiException({
    required this.statusCode,
    required this.type,
    required this.message,
    this.requestId,
    this.retryAfter,
    this.errorCode,
    this.midStream = false,
  });

  /// HTTP status; for an in-stream error event we map the error type to the
  /// status it would have had (overloaded_error -> 529, etc.).
  final int statusCode;
  final String type; // e.g. rate_limit_error, overloaded_error
  final String message;
  final String? requestId;
  final Duration? retryAfter;
  final String? errorCode; // error.details.error_code (spend cap 429)
  final bool midStream;

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

/// Events surfaced to callers of [ClaudeHttpClient.stream].
sealed class ClaudeStreamEvent {}

final class ClaudeMessageStarted extends ClaudeStreamEvent {
  ClaudeMessageStarted(this.id, this.model, this.usage);
  final String id;
  final String model;
  final Map<String, dynamic> usage;
}

/// Visible answer text, incrementally.
final class ClaudeTextDelta extends ClaudeStreamEvent {
  ClaudeTextDelta(this.index, this.text);
  final int index;
  final String text;
}

/// Summarized thinking / progress-update text (empty under display:"omitted").
final class ClaudeThinkingDelta extends ClaudeStreamEvent {
  ClaudeThinkingDelta(this.index, this.text);
  final int index;
  final String text;
}

/// Final event: the fully reassembled message (content blocks are exactly what
/// must be stored and replayed in later turns - thinking blocks included).
final class ClaudeMessageFinished extends ClaudeStreamEvent {
  ClaudeMessageFinished(this.message);
  final Map<String, dynamic> message;
  String? get stopReason => message['stop_reason'] as String?;
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

  /// Non-streaming POST /v1/messages with retries. Returns the Message JSON.
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> body, {
    List<String> extraBetas = const [],
    Duration timeout = const Duration(minutes: 10),
  }) async {
    final res = await _sendWithRetry(
      () => http.Request('POST', _base.resolve('/v1/messages'))
        ..headers.addAll(_headers(extraBetas))
        ..body = jsonEncode({...body, 'stream': false}),
      timeout: timeout,
    );
    final text = await res.stream.bytesToString();
    return jsonDecode(text) as Map<String, dynamic>;
  }

  /// Streaming POST /v1/messages. Yields text deltas as they arrive, then a
  /// [ClaudeMessageFinished] with the reassembled message.
  ///
  /// Retries happen only for failures BEFORE the 200 response (HTTP errors,
  /// connection errors). An `event: error` after the 200 is thrown as a
  /// [ClaudeApiException] with midStream=true - the caller decides whether to
  /// discard partial text and restart the turn.
  Stream<ClaudeStreamEvent> stream(
    Map<String, dynamic> body, {
    List<String> extraBetas = const [],
    Future<void>? abortTrigger,
    Duration idleTimeout = const Duration(seconds: 90),
  }) async* {
    final res = await _sendWithRetry(
      () =>
          http.AbortableRequest(
              'POST',
              _base.resolve('/v1/messages'),
              abortTrigger: abortTrigger,
            )
            ..headers.addAll({
              ..._headers(extraBetas),
              'accept': 'text/event-stream',
            })
            ..body = jsonEncode({...body, 'stream': true}),
      timeout: const Duration(seconds: 60), // time to response headers
    );
    final requestId = res.headers['request-id'];

    Map<String, dynamic>? message;
    final blocks = <int, Map<String, dynamic>>{};
    final toolJson = <int, StringBuffer>{};

    // `ping` events arrive periodically, so an idle timeout catches dead sockets.
    await for (final ev in parseSse(res.stream).timeout(idleTimeout)) {
      final Map<String, dynamic> data;
      try {
        data = jsonDecode(ev.data) as Map<String, dynamic>;
      } on FormatException {
        continue; // tolerate garbage / unknown framing
      }
      switch (ev.event) {
        case 'message_start':
          message = Map<String, dynamic>.from(data['message'] as Map);
          yield ClaudeMessageStarted(
            message['id'] as String,
            message['model'] as String,
            Map<String, dynamic>.from((message['usage'] as Map?) ?? const {}),
          );
        case 'content_block_start':
          final i = data['index'] as int;
          blocks[i] = Map<String, dynamic>.from(data['content_block'] as Map);
          if (blocks[i]!['type'] == 'tool_use') toolJson[i] = StringBuffer();
        case 'content_block_delta':
          final i = data['index'] as int;
          final delta = data['delta'] as Map<String, dynamic>;
          final block = blocks[i];
          if (block == null) break;
          switch (delta['type']) {
            case 'text_delta':
              final t = delta['text'] as String;
              block['text'] = '${block['text'] ?? ''}$t';
              yield ClaudeTextDelta(i, t);
            case 'thinking_delta':
              final t = delta['thinking'] as String;
              block['thinking'] = '${block['thinking'] ?? ''}$t';
              if (t.isNotEmpty) yield ClaudeThinkingDelta(i, t);
            case 'signature_delta':
              block['signature'] = delta['signature'];
            case 'input_json_delta':
              toolJson[i]?.write(delta['partial_json'] as String);
            case 'citations_delta':
              ((block['citations'] ??= <dynamic>[]) as List).add(
                delta['citation'],
              );
            default:
              break; // unknown delta types: ignore (versioning policy)
          }
        case 'content_block_stop':
          final i = data['index'] as int;
          final buf = toolJson.remove(i);
          if (buf != null) {
            blocks[i]!['input'] = buf.isEmpty
                ? <String, dynamic>{}
                : jsonDecode(buf.toString());
          }
        case 'message_delta':
          final m = message ??= <String, dynamic>{};
          final delta = (data['delta'] as Map?) ?? const {};
          m.addAll(Map<String, dynamic>.from(delta));
          final usage = data['usage'];
          if (usage is Map) {
            // usage in message_delta is cumulative: overwrite per key.
            m['usage'] = {
              ...((m['usage'] as Map?) ?? const {}),
              ...usage,
            };
          }
        case 'message_stop':
          final m = message ?? <String, dynamic>{};
          final keys = blocks.keys.toList()..sort();
          m['content'] = [for (final k in keys) blocks[k]];
          yield ClaudeMessageFinished(m);
          return;
        case 'error':
          final err = (data['error'] as Map?) ?? const {};
          final type = err['type'] as String? ?? 'api_error';
          throw ClaudeApiException(
            statusCode: switch (type) {
              'overloaded_error' => 529,
              'rate_limit_error' => 429,
              'timeout_error' => 504,
              'api_error' => 500,
              _ => 400,
            },
            type: type,
            message: err['message'] as String? ?? '',
            requestId: requestId,
            midStream: true,
          );
        default:
          break; // 'ping' and any future event types
      }
    }
    throw ClaudeApiException(
      statusCode: 500,
      type: 'stream_truncated',
      message: 'SSE stream ended without message_stop',
      requestId: requestId,
      midStream: true,
    );
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
      } on http.RequestAbortedException {
        rethrow;
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

/// Content to store/replay for an assistant turn. Normally the content array is
/// replayed verbatim. After a mid-output server-side fallback, blocks of type
/// thinking / redacted_thinking / tool_use that precede the LAST `fallback`
/// block must be omitted (the fallback block itself may be kept or dropped).
List<Map<String, dynamic>> contentForReplay(Map<String, dynamic> message) {
  final content = [
    for (final b in (message['content'] as List? ?? const []))
      Map<String, dynamic>.from(b as Map),
  ];
  final lastFallback = content.lastIndexWhere((b) => b['type'] == 'fallback');
  if (lastFallback < 0) return content;
  return [
    for (var i = 0; i < content.length; i++)
      if (i > lastFallback ||
          !const {
            'thinking',
            'redacted_thinking',
            'tool_use',
            'fallback',
          }.contains(content[i]['type']))
        content[i],
  ];
}
