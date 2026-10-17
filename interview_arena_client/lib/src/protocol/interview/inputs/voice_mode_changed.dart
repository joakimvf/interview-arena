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

/// The candidate chose speaking or typing: sent when the interview begins,
/// on every switch, and again after a reconnect. The server only makes
/// question audio (ElevenLabs) while this is on.
abstract class VoiceModeChanged extends _iototaiw.CandidateInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VoiceModeChanged._({
    required super.clientSeq,
    required this.enabled,
  });

  factory VoiceModeChanged({
    required int clientSeq,
    required bool enabled,
  }) = _VoiceModeChangedImpl;

  factory VoiceModeChanged.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceModeChanged(
      clientSeq: jsonSerialization['clientSeq'] as int,
      enabled: _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  bool enabled;

  /// Returns a shallow copy of this [VoiceModeChanged]
  /// with some or all fields replaced by the given arguments.
  @override
  @_isc.useResult
  VoiceModeChanged copyWith({
    int? clientSeq,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceModeChanged',
      'clientSeq': clientSeq,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceModeChanged',
      'clientSeq': clientSeq,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _VoiceModeChangedImpl extends VoiceModeChanged {
  _VoiceModeChangedImpl({
    required int clientSeq,
    required bool enabled,
  }) : super._(
         clientSeq: clientSeq,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [VoiceModeChanged]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VoiceModeChanged copyWith({
    int? clientSeq,
    bool? enabled,
  }) {
    return VoiceModeChanged(
      clientSeq: clientSeq ?? this.clientSeq,
      enabled: enabled ?? this.enabled,
    );
  }
}
