import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Skill-graph maintenance (pure Dart over the jsonb SkillProfile row).
abstract final class SkillGraph {
  static Future<SkillProfile> getOrCreate(
    Session session,
    UuidValue authUserId,
  ) async {
    final existing = await SkillProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) return existing;
    try {
      return await SkillProfile.db.insertRow(
        session,
        SkillProfile(
          authUserId: authUserId,
          skillGraph: {},
          weaknesses: [],
          strengths: [],
        ),
      );
    } on DatabaseUniqueViolationException {
      return (await SkillProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      ))!;
    }
  }

  static String key(String skill) => skill.trim().toLowerCase();

  static Future<void> seedFromResume(
    Session session,
    UuidValue authUserId,
    ParsedResume resume,
  ) async {
    final profile = await getOrCreate(session, authUserId);
    final graph = Map<String, SkillNode>.of(profile.skillGraph);
    for (final s in resume.skills) {
      graph.putIfAbsent(
        key(s.name),
        () =>
            SkillNode(level: (s.confidence * 60).roundToDouble(), related: []),
      );
    }
    await SkillProfile.db.updateRow(
      session,
      profile.copyWith(skillGraph: graph, updatedAt: DateTime.now().toUtc()),
    );
  }

  static Future<void> applyEvaluation(
    Session session,
    UuidValue authUserId,
    AnswerFeedback feedback,
    int answerId,
  ) async {
    final profile = await getOrCreate(session, authUserId);
    final now = DateTime.now().toUtc();
    final graph = Map<String, SkillNode>.of(profile.skillGraph);
    final weaknesses = {for (final w in profile.weaknesses) w.skill: w};
    feedback.skillDeltas.forEach((skill, delta) {
      final k = key(skill);
      final node = graph[k] ?? SkillNode(level: 50, related: []);
      final level = (node.level + delta).clamp(0, 100).toDouble();
      graph[k] = node.copyWith(
        level: level,
        evidenceCount: node.evidenceCount + 1,
        lastAssessedAt: now,
      );
      if (level < 40) {
        final w = weaknesses[k];
        weaknesses[k] = Weakness(
          skill: k,
          description: w?.description ?? 'Low score on $k',
          severity: (100 - level) / 100,
          exampleAnswerIds: {...?w?.exampleAnswerIds, answerId}.toList(),
        );
      } else {
        weaknesses.remove(k);
      }
    });
    await SkillProfile.db.updateRow(
      session,
      profile.copyWith(
        skillGraph: graph,
        weaknesses: weaknesses.values.toList(),
        strengths: [
          for (final e in graph.entries)
            if (e.value.level >= 75) e.key,
        ],
        updatedAt: now,
      ),
    );
  }
}
