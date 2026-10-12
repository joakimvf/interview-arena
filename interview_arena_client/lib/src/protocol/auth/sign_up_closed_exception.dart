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

/// Thrown when someone tries to create an account on a server where sign-up
/// is closed (every deployed server; see sign_up_policy.dart).
abstract class SignUpClosedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  SignUpClosedException._({required this.message});

  factory SignUpClosedException({required String message}) =
      _SignUpClosedExceptionImpl;

  factory SignUpClosedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SignUpClosedException(
      message: jsonSerialization['message'] as String,
    );
  }

  String message;

  /// Returns a shallow copy of this [SignUpClosedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SignUpClosedException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignUpClosedException',
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SignUpClosedException',
      'message': message,
    };
  }

  @override
  String toString() {
    return 'SignUpClosedException(message: $message)';
  }
}

class _SignUpClosedExceptionImpl extends SignUpClosedException {
  _SignUpClosedExceptionImpl({required String message})
    : super._(message: message);

  /// Returns a shallow copy of this [SignUpClosedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SignUpClosedException copyWith({String? message}) {
    return SignUpClosedException(message: message ?? this.message);
  }
}
