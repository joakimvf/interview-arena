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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// The five live scores, each 0-100.
abstract class InterviewScores
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InterviewScores._({
    double? communication,
    double? confidence,
    double? technicalDepth,
    double? completeness,
    double? structure,
  }) : communication = communication ?? 0.0,
       confidence = confidence ?? 0.0,
       technicalDepth = technicalDepth ?? 0.0,
       completeness = completeness ?? 0.0,
       structure = structure ?? 0.0;

  factory InterviewScores({
    double? communication,
    double? confidence,
    double? technicalDepth,
    double? completeness,
    double? structure,
  }) = _InterviewScoresImpl;

  factory InterviewScores.fromJson(Map<String, dynamic> jsonSerialization) {
    return InterviewScores(
      communication: (jsonSerialization['communication'] as num?)?.toDouble(),
      confidence: (jsonSerialization['confidence'] as num?)?.toDouble(),
      technicalDepth: (jsonSerialization['technicalDepth'] as num?)?.toDouble(),
      completeness: (jsonSerialization['completeness'] as num?)?.toDouble(),
      structure: (jsonSerialization['structure'] as num?)?.toDouble(),
    );
  }

  double communication;

  double confidence;

  double technicalDepth;

  double completeness;

  double structure;

  /// Returns a shallow copy of this [InterviewScores]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InterviewScores copyWith({
    double? communication,
    double? confidence,
    double? technicalDepth,
    double? completeness,
    double? structure,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewScores',
      'communication': communication,
      'confidence': confidence,
      'technicalDepth': technicalDepth,
      'completeness': completeness,
      'structure': structure,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewScores',
      'communication': communication,
      'confidence': confidence,
      'technicalDepth': technicalDepth,
      'completeness': completeness,
      'structure': structure,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InterviewScoresImpl extends InterviewScores {
  _InterviewScoresImpl({
    double? communication,
    double? confidence,
    double? technicalDepth,
    double? completeness,
    double? structure,
  }) : super._(
         communication: communication,
         confidence: confidence,
         technicalDepth: technicalDepth,
         completeness: completeness,
         structure: structure,
       );

  /// Returns a shallow copy of this [InterviewScores]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InterviewScores copyWith({
    double? communication,
    double? confidence,
    double? technicalDepth,
    double? completeness,
    double? structure,
  }) {
    return InterviewScores(
      communication: communication ?? this.communication,
      confidence: confidence ?? this.confidence,
      technicalDepth: technicalDepth ?? this.technicalDepth,
      completeness: completeness ?? this.completeness,
      structure: structure ?? this.structure,
    );
  }
}
