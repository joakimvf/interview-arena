/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:interview_arena_client/src/protocol/protocol.dart' as _i8wnw200;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../skills/skill_node.dart' as _isj6cble;
import '../skills/weakness.dart' as _iqykx933;

/// Per-user skill graph with strengths/weaknesses (jsonb).
abstract class SkillProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SkillProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.skillGraph,
    required this.weaknesses,
    required this.strengths,
    this.averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) : sessionsCompleted = sessionsCompleted ?? 0,
       updatedAt = updatedAt ?? DateTime.now();

  factory SkillProfile({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required Map<String, _isj6cble.SkillNode> skillGraph,
    required List<_iqykx933.Weakness> weaknesses,
    required List<String> strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) = _SkillProfileImpl;

  factory SkillProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return SkillProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      skillGraph: _i8wnw200.Protocol()
          .deserialize<Map<String, _isj6cble.SkillNode>>(
            jsonSerialization['skillGraph'],
          ),
      weaknesses: _i8wnw200.Protocol().deserialize<List<_iqykx933.Weakness>>(
        jsonSerialization['weaknesses'],
      ),
      strengths: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['strengths'],
      ),
      averageScores: jsonSerialization['averageScores'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['averageScores'],
            ),
      sessionsCompleted: jsonSerialization['sessionsCompleted'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  Map<String, _isj6cble.SkillNode> skillGraph;

  List<_iqykx933.Weakness> weaknesses;

  List<String> strengths;

  _i5tfukg1.InterviewScores? averageScores;

  int sessionsCompleted;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SkillProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SkillProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    Map<String, _isj6cble.SkillNode>? skillGraph,
    List<_iqykx933.Weakness>? weaknesses,
    List<String>? strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SkillProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'skillGraph': skillGraph.toJson(valueToJson: (v) => v.toJson()),
      'weaknesses': weaknesses.toJson(valueToJson: (v) => v.toJson()),
      'strengths': strengths.toJson(),
      if (averageScores != null) 'averageScores': averageScores?.toJson(),
      'sessionsCompleted': sessionsCompleted,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SkillProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'skillGraph': skillGraph.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'weaknesses': weaknesses.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'strengths': strengths.toJson(),
      if (averageScores != null)
        'averageScores': averageScores?.toJsonForProtocol(),
      'sessionsCompleted': sessionsCompleted,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillProfileImpl extends SkillProfile {
  _SkillProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required Map<String, _isj6cble.SkillNode> skillGraph,
    required List<_iqykx933.Weakness> weaknesses,
    required List<String> strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         skillGraph: skillGraph,
         weaknesses: weaknesses,
         strengths: strengths,
         averageScores: averageScores,
         sessionsCompleted: sessionsCompleted,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SkillProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SkillProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Map<String, _isj6cble.SkillNode>? skillGraph,
    List<_iqykx933.Weakness>? weaknesses,
    List<String>? strengths,
    Object? averageScores = _Undefined,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) {
    return SkillProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      skillGraph:
          skillGraph ??
          this.skillGraph.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0.copyWith(),
            ),
          ),
      weaknesses:
          weaknesses ?? this.weaknesses.map((e0) => e0.copyWith()).toList(),
      strengths: strengths ?? this.strengths.map((e0) => e0).toList(),
      averageScores: averageScores is _i5tfukg1.InterviewScores?
          ? averageScores
          : this.averageScores?.copyWith(),
      sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
