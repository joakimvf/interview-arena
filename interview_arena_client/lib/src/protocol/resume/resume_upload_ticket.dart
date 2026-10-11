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

/// Returned by ResumeEndpoint.createUpload.
abstract class ResumeUploadTicket
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ResumeUploadTicket._({
    required this.resumeId,
    required this.uploadDescription,
  });

  factory ResumeUploadTicket({
    required int resumeId,
    required String uploadDescription,
  }) = _ResumeUploadTicketImpl;

  factory ResumeUploadTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return ResumeUploadTicket(
      resumeId: jsonSerialization['resumeId'] as int,
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  int resumeId;

  /// JSON upload description for FileUploader on the client.
  String uploadDescription;

  /// Returns a shallow copy of this [ResumeUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ResumeUploadTicket copyWith({
    int? resumeId,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ResumeUploadTicket',
      'resumeId': resumeId,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ResumeUploadTicket',
      'resumeId': resumeId,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ResumeUploadTicketImpl extends ResumeUploadTicket {
  _ResumeUploadTicketImpl({
    required int resumeId,
    required String uploadDescription,
  }) : super._(
         resumeId: resumeId,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [ResumeUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ResumeUploadTicket copyWith({
    int? resumeId,
    String? uploadDescription,
  }) {
    return ResumeUploadTicket(
      resumeId: resumeId ?? this.resumeId,
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
