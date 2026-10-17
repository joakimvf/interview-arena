import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart'; // authUserId extension

import '../ai/interview_ai.dart';
import '../background.dart';
import '../generated/protocol.dart';

/// Resume PDF: createUpload -> (client FileUploader) -> completeUpload ->
/// parse in the background -> client polls getResume.
class ResumeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const storageId = 'private';
  static const maxResumeBytes = 5 * 1024 * 1024;

  static bool _isPdf(Uint8List b) => // %PDF-
      b.length >= 5 &&
      b[0] == 0x25 &&
      b[1] == 0x50 &&
      b[2] == 0x44 &&
      b[3] == 0x46 &&
      b[4] == 0x2D;

  Future<Resume> _own(Session session, int resumeId) async {
    final resume = await Resume.db.findById(session, resumeId);
    if (resume == null ||
        resume.authUserId != session.authenticated!.authUserId) {
      throw ResumeException(reason: 'not_found');
    }
    return resume;
  }

  Future<ResumeUploadTicket> createUpload(
    Session session,
    String fileName,
    int sizeBytes,
  ) async {
    if (sizeBytes <= 0 || sizeBytes > maxResumeBytes) {
      throw ResumeException(reason: 'invalid_size');
    }
    final authUserId = session.authenticated!.authUserId;
    final path = 'resumes/${authUserId.uuid}/${const Uuid().v4()}.pdf';
    final resume = await Resume.db.insertRow(
      session,
      Resume(
        authUserId: authUserId,
        fileName: fileName,
        storagePath: path,
        sizeBytes: sizeBytes,
      ),
    );
    final description = await session.storage.createUploadDescription(
      storageId: storageId,
      path: path,
      options: UploadOptions(
        maxFileSize: maxResumeBytes,
        contentLength: sizeBytes,
        preventOverwrite: true,
        metadata: const FileMetadata(contentType: 'application/pdf'),
      ),
    );
    return ResumeUploadTicket(
      resumeId: resume.id!,
      uploadDescription: description,
    );
  }

  Future<Resume> completeUpload(Session session, int resumeId) async {
    final resume = await _own(session, resumeId);
    if (resume.status != ResumeParseStatus.awaitingUpload &&
        resume.status != ResumeParseStatus.failed) {
      throw ResumeException(reason: 'wrong_state');
    }
    final verified = await session.storage.verifyUpload(
      storageId: storageId,
      path: resume.storagePath,
    );
    if (!verified &&
        !await session.storage.fileExists(
          storageId: storageId,
          path: resume.storagePath,
        )) {
      throw ResumeException(reason: 'not_uploaded');
    }
    final bytes = Uint8List.sublistView(
      await session.storage.retrieveFile(
        storageId: storageId,
        path: resume.storagePath,
      ),
    );
    if (!_isPdf(bytes)) {
      await Resume.db.updateRow(
        session,
        resume.copyWith(
          status: ResumeParseStatus.failed,
          parseError: 'not_pdf',
        ),
      );
      throw ResumeException(reason: 'not_pdf');
    }
    final parsing = await Resume.db.updateRow(
      session,
      resume.copyWith(status: ResumeParseStatus.parsing, parseError: null),
    );
    // Async: a Claude PDF parse can exceed the client's 20 s call timeout.
    // The bytes are already in memory, so the parse doesn't fetch them again.
    runInBackground(
      session,
      'Resume $resumeId parse',
      (s) => parse(s, resumeId, bytes),
    );
    return parsing;
  }

  /// Parses [pdf] with Claude and stores the result on the resume. Guarded by
  /// status == parsing, so a second run is a no-op.
  static Future<void> parse(
    Session session,
    int resumeId,
    Uint8List pdf,
  ) async {
    final resume = await Resume.db.findById(session, resumeId);
    if (resume == null || resume.status != ResumeParseStatus.parsing) return;
    try {
      final parsed = await interviewAiFactory(session).parseResume(pdf);
      await Resume.db.updateRow(
        session,
        resume.copyWith(
          status: ResumeParseStatus.parsed,
          parsedData: parsed,
          parsedAt: DateTime.now().toUtc(),
          parseModel: ClaudeInterviewAi.resumeParse.model,
        ),
      );
    } catch (e) {
      session.log('Resume $resumeId parse failed: $e', level: LogLevel.warning);
      await Resume.db.updateRow(
        session,
        resume.copyWith(
          status: ResumeParseStatus.failed,
          parseError: e is AiUnavailableException ? e.code : 'parse_failed',
        ),
      );
    }
  }

  Future<Resume?> getResume(Session session, int resumeId) async {
    final resume = await Resume.db.findById(session, resumeId);
    if (resume == null ||
        resume.authUserId != session.authenticated!.authUserId) {
      return null;
    }
    return resume;
  }

  Future<List<Resume>> listResumes(Session session) {
    final authUserId = session.authenticated!.authUserId;
    return Resume.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderByList: (t) => [t.createdAt.desc()],
      limit: 20,
    );
  }

  Future<void> deleteResume(Session session, int resumeId) async {
    final resume = await _own(session, resumeId);
    if (await session.storage.fileExists(
      storageId: storageId,
      path: resume.storagePath,
    )) {
      await session.storage.deleteFile(
        storageId: storageId,
        path: resume.storagePath,
      );
    }
    await Resume.db.deleteRow(
      session,
      resume,
    ); // interview_session.resumeId -> NULL
  }
}
