/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

part of 'candidate_input.dart';

abstract class EndInterview extends _iototaiw.CandidateInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EndInterview._({
    required super.clientSeq,
    this.reason,
  });

  factory EndInterview({
    required int clientSeq,
    String? reason,
  }) = _EndInterviewImpl;

  factory EndInterview.fromJson(Map<String, dynamic> jsonSerialization) {
    return EndInterview(
      clientSeq: jsonSerialization['clientSeq'] as int,
      reason: jsonSerialization['reason'] as String?,
    );
  }

  String? reason;

  /// Returns a shallow copy of this [EndInterview]
  /// with some or all fields replaced by the given arguments.
  @override
  @_isc.useResult
  EndInterview copyWith({
    int? clientSeq,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EndInterview',
      'clientSeq': clientSeq,
      if (reason != null) 'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EndInterview',
      'clientSeq': clientSeq,
      if (reason != null) 'reason': reason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EndInterviewImpl extends EndInterview {
  _EndInterviewImpl({
    required int clientSeq,
    String? reason,
  }) : super._(
         clientSeq: clientSeq,
         reason: reason,
       );

  /// Returns a shallow copy of this [EndInterview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EndInterview copyWith({
    int? clientSeq,
    Object? reason = _Undefined,
  }) {
    return EndInterview(
      clientSeq: clientSeq ?? this.clientSeq,
      reason: reason is String? ? reason : this.reason,
    );
  }
}
