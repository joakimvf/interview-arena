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

/// Thrown when someone without the admin scope asks for AI costs.
abstract class AiCostAccessException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  AiCostAccessException._({required this.reason});

  factory AiCostAccessException({required String reason}) =
      _AiCostAccessExceptionImpl;

  factory AiCostAccessException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiCostAccessException(reason: jsonSerialization['reason'] as String);
  }

  String reason;

  /// Returns a shallow copy of this [AiCostAccessException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiCostAccessException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiCostAccessException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiCostAccessException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'AiCostAccessException(reason: $reason)';
  }
}

class _AiCostAccessExceptionImpl extends AiCostAccessException {
  _AiCostAccessExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [AiCostAccessException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiCostAccessException copyWith({String? reason}) {
    return AiCostAccessException(reason: reason ?? this.reason);
  }
}
