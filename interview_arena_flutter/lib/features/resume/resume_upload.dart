import 'dart:typed_data';

import 'package:interview_arena_client/interview_arena_client.dart';

/// createUpload -> FileUploader -> completeUpload -> poll getResume.
Future<Resume> uploadAndParseResume(
  Client client,
  String fileName,
  Uint8List pdfBytes, {
  Duration pollEvery = const Duration(seconds: 2),
  Duration giveUpAfter = const Duration(minutes: 3),
}) async {
  final ticket = await client.resume.createUpload(fileName, pdfBytes.length);
  final ok = await FileUploader(
    ticket.uploadDescription,
  ).uploadByteData(ByteData.sublistView(pdfBytes)); // false hides the reason
  if (!ok) throw StateError('upload_failed');
  var resume = await client.resume.completeUpload(ticket.resumeId);
  final deadline = DateTime.now().add(giveUpAfter);
  while (resume.status == ResumeParseStatus.parsing &&
      DateTime.now().isBefore(deadline)) {
    await Future<void>.delayed(pollEvery);
    try {
      resume = (await client.resume.getResume(ticket.resumeId)) ?? resume;
    } on ServerpodClientException {
      // Transient network error: the parse continues server-side, keep polling.
    }
  }
  return resume;
}
