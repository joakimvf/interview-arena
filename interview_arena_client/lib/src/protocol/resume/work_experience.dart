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

abstract class WorkExperience
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkExperience._({
    required this.title,
    this.company,
    this.startDate,
    this.endDate,
    required this.highlights,
  });

  factory WorkExperience({
    required String title,
    String? company,
    String? startDate,
    String? endDate,
    required List<String> highlights,
  }) = _WorkExperienceImpl;

  factory WorkExperience.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkExperience(
      title: jsonSerialization['title'] as String,
      company: jsonSerialization['company'] as String?,
      startDate: jsonSerialization['startDate'] as String?,
      endDate: jsonSerialization['endDate'] as String?,
      highlights: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['highlights'],
      ),
    );
  }

  String title;

  String? company;

  String? startDate;

  String? endDate;

  List<String> highlights;

  /// Returns a shallow copy of this [WorkExperience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkExperience copyWith({
    String? title,
    String? company,
    String? startDate,
    String? endDate,
    List<String>? highlights,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkExperience',
      'title': title,
      if (company != null) 'company': company,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      'highlights': highlights.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkExperience',
      'title': title,
      if (company != null) 'company': company,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      'highlights': highlights.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkExperienceImpl extends WorkExperience {
  _WorkExperienceImpl({
    required String title,
    String? company,
    String? startDate,
    String? endDate,
    required List<String> highlights,
  }) : super._(
         title: title,
         company: company,
         startDate: startDate,
         endDate: endDate,
         highlights: highlights,
       );

  /// Returns a shallow copy of this [WorkExperience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkExperience copyWith({
    String? title,
    Object? company = _Undefined,
    Object? startDate = _Undefined,
    Object? endDate = _Undefined,
    List<String>? highlights,
  }) {
    return WorkExperience(
      title: title ?? this.title,
      company: company is String? ? company : this.company,
      startDate: startDate is String? ? startDate : this.startDate,
      endDate: endDate is String? ? endDate : this.endDate,
      highlights: highlights ?? this.highlights.map((e0) => e0).toList(),
    );
  }
}
