import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../ai/interview_ai.dart';
import '../generated/protocol.dart';
import '../skills/skill_graph.dart';
import 'resume_endpoint.dart';

/// Accessor: futureCalls...resumeParse.parse(resumeId).
/// At-least-once: guarded by status == parsing, so re-runs are no-ops.
class ResumeParseFutureCall extends FutureCall {
  Future<void> parse(Session session, int resumeId) async {
    final resume = await Resume.db.findById(session, resumeId);
    if (resume == null || resume.status != ResumeParseStatus.parsing) return;
    try {
      final data = await session.storage.retrieveFile(
        storageId: ResumeEndpoint.storageId,
        path: resume.storagePath,
      );
      final parsed = await interviewAiFactory(
        session,
      ).parseResume(Uint8List.sublistView(data));
      await Resume.db.updateRow(
        session,
        resume.copyWith(
          status: ResumeParseStatus.parsed,
          parsedData: parsed,
          parsedAt: DateTime.now().toUtc(),
          parseModel: ClaudeInterviewAi.resumeParse.model,
        ),
      );
      await SkillGraph.seedFromResume(session, resume.authUserId, parsed);
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
}
