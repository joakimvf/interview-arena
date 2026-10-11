/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

part of 'interview_event.dart';

/// Non-fatal problem (AI overloaded, refusal, ...). The stream stays open.
abstract class InterviewNotice extends _iototaiw.InterviewEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InterviewNotice._({
    required super.interviewSessionId,
    required super.sequence,
    required this.code,
    required this.message,
  });

  factory InterviewNotice({
    required int interviewSessionId,
    required int sequence,
    required String code,
    required String message,
  }) = _InterviewNoticeImpl;

  factory InterviewNotice.fromJson(Map<String, dynamic> jsonSerialization) {
    return InterviewNotice(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String code;

  String message;

  /// Returns a shallow copy of this [InterviewNotice]
  /// with some or all fields replaced by the given arguments.
  @override
  @_isc.useResult
  InterviewNotice copyWith({
    int? interviewSessionId,
    int? sequence,
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewNotice',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'code': code,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewNotice',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InterviewNoticeImpl extends InterviewNotice {
  _InterviewNoticeImpl({
    required int interviewSessionId,
    required int sequence,
    required String code,
    required String message,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [InterviewNotice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InterviewNotice copyWith({
    int? interviewSessionId,
    int? sequence,
    String? code,
    String? message,
  }) {
    return InterviewNotice(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
