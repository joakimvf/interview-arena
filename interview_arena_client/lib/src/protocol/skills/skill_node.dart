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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// One node in the skill graph.
abstract class SkillNode
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SkillNode._({
    required this.level,
    int? evidenceCount,
    this.lastAssessedAt,
    required this.related,
  }) : evidenceCount = evidenceCount ?? 0;

  factory SkillNode({
    required double level,
    int? evidenceCount,
    DateTime? lastAssessedAt,
    required List<String> related,
  }) = _SkillNodeImpl;

  factory SkillNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SkillNode(
      level: (jsonSerialization['level'] as num).toDouble(),
      evidenceCount: jsonSerialization['evidenceCount'] as int?,
      lastAssessedAt: jsonSerialization['lastAssessedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAssessedAt'],
            ),
      related: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['related'],
      ),
    );
  }

  /// 0-100 proficiency estimate.
  double level;

  int evidenceCount;

  DateTime? lastAssessedAt;

  /// Names of related skills (graph edges).
  List<String> related;

  /// Returns a shallow copy of this [SkillNode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SkillNode copyWith({
    double? level,
    int? evidenceCount,
    DateTime? lastAssessedAt,
    List<String>? related,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SkillNode',
      'level': level,
      'evidenceCount': evidenceCount,
      if (lastAssessedAt != null) 'lastAssessedAt': lastAssessedAt?.toJson(),
      'related': related.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SkillNode',
      'level': level,
      'evidenceCount': evidenceCount,
      if (lastAssessedAt != null) 'lastAssessedAt': lastAssessedAt?.toJson(),
      'related': related.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillNodeImpl extends SkillNode {
  _SkillNodeImpl({
    required double level,
    int? evidenceCount,
    DateTime? lastAssessedAt,
    required List<String> related,
  }) : super._(
         level: level,
         evidenceCount: evidenceCount,
         lastAssessedAt: lastAssessedAt,
         related: related,
       );

  /// Returns a shallow copy of this [SkillNode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SkillNode copyWith({
    double? level,
    int? evidenceCount,
    Object? lastAssessedAt = _Undefined,
    List<String>? related,
  }) {
    return SkillNode(
      level: level ?? this.level,
      evidenceCount: evidenceCount ?? this.evidenceCount,
      lastAssessedAt: lastAssessedAt is DateTime?
          ? lastAssessedAt
          : this.lastAssessedAt,
      related: related ?? this.related.map((e0) => e0).toList(),
    );
  }
}
