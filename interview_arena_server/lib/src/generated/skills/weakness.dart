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
import 'package:interview_arena_server/src/generated/protocol.dart'
    as _iq9nucou;
import 'package:serverpod/serverpod.dart' as _is;

abstract class Weakness
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Weakness._({
    required this.skill,
    required this.description,
    required this.severity,
    required this.exampleAnswerIds,
  });

  factory Weakness({
    required String skill,
    required String description,
    required double severity,
    required List<int> exampleAnswerIds,
  }) = _WeaknessImpl;

  factory Weakness.fromJson(Map<String, dynamic> jsonSerialization) {
    return Weakness(
      skill: jsonSerialization['skill'] as String,
      description: jsonSerialization['description'] as String,
      severity: (jsonSerialization['severity'] as num).toDouble(),
      exampleAnswerIds: _iq9nucou.Protocol().deserialize<List<int>>(
        jsonSerialization['exampleAnswerIds'],
      ),
    );
  }

  String skill;

  String description;

  double severity;

  /// Answer ids that demonstrate the weakness (career-memory hits).
  List<int> exampleAnswerIds;

  /// Returns a shallow copy of this [Weakness]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Weakness copyWith({
    String? skill,
    String? description,
    double? severity,
    List<int>? exampleAnswerIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Weakness',
      'skill': skill,
      'description': description,
      'severity': severity,
      'exampleAnswerIds': exampleAnswerIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Weakness',
      'skill': skill,
      'description': description,
      'severity': severity,
      'exampleAnswerIds': exampleAnswerIds.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _WeaknessImpl extends Weakness {
  _WeaknessImpl({
    required String skill,
    required String description,
    required double severity,
    required List<int> exampleAnswerIds,
  }) : super._(
         skill: skill,
         description: description,
         severity: severity,
         exampleAnswerIds: exampleAnswerIds,
       );

  /// Returns a shallow copy of this [Weakness]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Weakness copyWith({
    String? skill,
    String? description,
    double? severity,
    List<int>? exampleAnswerIds,
  }) {
    return Weakness(
      skill: skill ?? this.skill,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      exampleAnswerIds:
          exampleAnswerIds ?? this.exampleAnswerIds.map((e0) => e0).toList(),
    );
  }
}
