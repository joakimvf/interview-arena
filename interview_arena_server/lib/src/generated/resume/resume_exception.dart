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

abstract class ResumeException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  ResumeException._({required this.reason});

  factory ResumeException({required String reason}) = _ResumeExceptionImpl;

  factory ResumeException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ResumeException(reason: jsonSerialization['reason'] as String);
  }

  /// invalid_size | not_found | not_uploaded | not_pdf | wrong_state
  String reason;

  /// Returns a shallow copy of this [ResumeException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ResumeException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ResumeException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ResumeException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'ResumeException(reason: $reason)';
  }
}

class _ResumeExceptionImpl extends ResumeException {
  _ResumeExceptionImpl({required String reason}) : super._(reason: reason);

  /// Returns a shallow copy of this [ResumeException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ResumeException copyWith({String? reason}) {
    return ResumeException(reason: reason ?? this.reason);
  }
}
