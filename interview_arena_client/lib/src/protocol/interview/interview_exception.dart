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

/// Thrown inside interview methods. Reaches the client typed.
abstract class InterviewAccessException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  InterviewAccessException._({required this.reason});

  factory InterviewAccessException({required String reason}) =
      _InterviewAccessExceptionImpl;

  factory InterviewAccessException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InterviewAccessException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  /// not_found | wrong_state
  String reason;

  /// Returns a shallow copy of this [InterviewAccessException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InterviewAccessException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewAccessException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewAccessException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'InterviewAccessException(reason: $reason)';
  }
}

class _InterviewAccessExceptionImpl extends InterviewAccessException {
  _InterviewAccessExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [InterviewAccessException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InterviewAccessException copyWith({String? reason}) {
    return InterviewAccessException(reason: reason ?? this.reason);
  }
}
