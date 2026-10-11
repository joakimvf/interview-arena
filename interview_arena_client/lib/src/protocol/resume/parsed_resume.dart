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
import '../resume/extracted_skill.dart' as _i0np4tum;
import '../resume/work_experience.dart' as _ik3mkbry;

/// Structured result of AI resume parsing. Stored as jsonb in Resume.parsedData.
abstract class ParsedResume
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ParsedResume._({
    this.fullName,
    this.headline,
    this.yearsOfExperience,
    required this.skills,
    required this.experience,
    required this.education,
  });

  factory ParsedResume({
    String? fullName,
    String? headline,
    double? yearsOfExperience,
    required List<_i0np4tum.ExtractedSkill> skills,
    required List<_ik3mkbry.WorkExperience> experience,
    required List<String> education,
  }) = _ParsedResumeImpl;

  factory ParsedResume.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParsedResume(
      fullName: jsonSerialization['fullName'] as String?,
      headline: jsonSerialization['headline'] as String?,
      yearsOfExperience: (jsonSerialization['yearsOfExperience'] as num?)
          ?.toDouble(),
      skills: _i8wnw200.Protocol().deserialize<List<_i0np4tum.ExtractedSkill>>(
        jsonSerialization['skills'],
      ),
      experience: _i8wnw200.Protocol()
          .deserialize<List<_ik3mkbry.WorkExperience>>(
            jsonSerialization['experience'],
          ),
      education: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['education'],
      ),
    );
  }

  String? fullName;

  String? headline;

  double? yearsOfExperience;

  List<_i0np4tum.ExtractedSkill> skills;

  List<_ik3mkbry.WorkExperience> experience;

  List<String> education;

  /// Returns a shallow copy of this [ParsedResume]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ParsedResume copyWith({
    String? fullName,
    String? headline,
    double? yearsOfExperience,
    List<_i0np4tum.ExtractedSkill>? skills,
    List<_ik3mkbry.WorkExperience>? experience,
    List<String>? education,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParsedResume',
      if (fullName != null) 'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'skills': skills.toJson(valueToJson: (v) => v.toJson()),
      'experience': experience.toJson(valueToJson: (v) => v.toJson()),
      'education': education.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParsedResume',
      if (fullName != null) 'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'skills': skills.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'experience': experience.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'education': education.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParsedResumeImpl extends ParsedResume {
  _ParsedResumeImpl({
    String? fullName,
    String? headline,
    double? yearsOfExperience,
    required List<_i0np4tum.ExtractedSkill> skills,
    required List<_ik3mkbry.WorkExperience> experience,
    required List<String> education,
  }) : super._(
         fullName: fullName,
         headline: headline,
         yearsOfExperience: yearsOfExperience,
         skills: skills,
         experience: experience,
         education: education,
       );

  /// Returns a shallow copy of this [ParsedResume]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ParsedResume copyWith({
    Object? fullName = _Undefined,
    Object? headline = _Undefined,
    Object? yearsOfExperience = _Undefined,
    List<_i0np4tum.ExtractedSkill>? skills,
    List<_ik3mkbry.WorkExperience>? experience,
    List<String>? education,
  }) {
    return ParsedResume(
      fullName: fullName is String? ? fullName : this.fullName,
      headline: headline is String? ? headline : this.headline,
      yearsOfExperience: yearsOfExperience is double?
          ? yearsOfExperience
          : this.yearsOfExperience,
      skills: skills ?? this.skills.map((e0) => e0.copyWith()).toList(),
      experience:
          experience ?? this.experience.map((e0) => e0.copyWith()).toList(),
      education: education ?? this.education.map((e0) => e0).toList(),
    );
  }
}
