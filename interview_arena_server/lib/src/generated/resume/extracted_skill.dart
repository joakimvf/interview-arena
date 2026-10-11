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
import 'package:serverpod/serverpod.dart' as _is;

/// A skill the AI extracted from a resume.
abstract class ExtractedSkill
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ExtractedSkill._({
    required this.name,
    this.category,
    double? confidence,
    this.evidence,
  }) : confidence = confidence ?? 0.5;

  factory ExtractedSkill({
    required String name,
    String? category,
    double? confidence,
    String? evidence,
  }) = _ExtractedSkillImpl;

  factory ExtractedSkill.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExtractedSkill(
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String?,
      confidence: (jsonSerialization['confidence'] as num?)?.toDouble(),
      evidence: jsonSerialization['evidence'] as String?,
    );
  }

  String name;

  String? category;

  /// 0.0 - 1.0 confidence that the candidate has this skill.
  double confidence;

  String? evidence;

  /// Returns a shallow copy of this [ExtractedSkill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExtractedSkill copyWith({
    String? name,
    String? category,
    double? confidence,
    String? evidence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExtractedSkill',
      'name': name,
      if (category != null) 'category': category,
      'confidence': confidence,
      if (evidence != null) 'evidence': evidence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExtractedSkill',
      'name': name,
      if (category != null) 'category': category,
      'confidence': confidence,
      if (evidence != null) 'evidence': evidence,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExtractedSkillImpl extends ExtractedSkill {
  _ExtractedSkillImpl({
    required String name,
    String? category,
    double? confidence,
    String? evidence,
  }) : super._(
         name: name,
         category: category,
         confidence: confidence,
         evidence: evidence,
       );

  /// Returns a shallow copy of this [ExtractedSkill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExtractedSkill copyWith({
    String? name,
    Object? category = _Undefined,
    double? confidence,
    Object? evidence = _Undefined,
  }) {
    return ExtractedSkill(
      name: name ?? this.name,
      category: category is String? ? category : this.category,
      confidence: confidence ?? this.confidence,
      evidence: evidence is String? ? evidence : this.evidence,
    );
  }
}
