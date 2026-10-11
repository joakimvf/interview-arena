import 'dart:async';
import 'dart:convert';

/// One Server-Sent Event: the `event:` name (defaults to "message") and the
/// joined `data:` payload.
class SseEvent {
  const SseEvent(this.event, this.data);
  final String event;
  final String data;
  @override
  String toString() => 'SseEvent($event, $data)';
}

/// Minimal, spec-compliant SSE framing over a byte stream.
///
/// utf8.decoder is a chunked converter, so a multi-byte character split across
/// two TCP chunks is decoded correctly. LineSplitter handles \n, \r\n and \r.
Stream<SseEvent> parseSse(Stream<List<int>> bytes) async* {
  String? eventName;
  final data = StringBuffer();
  var hasData = false;

  await for (final line
      in bytes.transform(utf8.decoder).transform(const LineSplitter())) {
    if (line.isEmpty) {
      // Blank line = dispatch.
      if (hasData) yield SseEvent(eventName ?? 'message', data.toString());
      eventName = null;
      data.clear();
      hasData = false;
      continue;
    }
    if (line.startsWith(':')) continue; // SSE comment / keep-alive
    final colon = line.indexOf(':');
    final field = colon == -1 ? line : line.substring(0, colon);
    var value = colon == -1 ? '' : line.substring(colon + 1);
    if (value.startsWith(' ')) value = value.substring(1);
    switch (field) {
      case 'event':
        eventName = value;
      case 'data':
        if (hasData) data.write('\n');
        data.write(value);
        hasData = true;
      default:
        break; // `id:` / `retry:` are not used by the Messages API.
    }
  }
  // Stream closed without a trailing blank line: flush what we have.
  if (hasData) yield SseEvent(eventName ?? 'message', data.toString());
}
