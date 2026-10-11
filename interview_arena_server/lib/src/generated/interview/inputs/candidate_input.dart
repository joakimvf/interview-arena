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
import '../../protocol.dart' as _iototaiw;
part 'answer_chunk.dart';
part 'answer_submitted.dart';
part 'end_interview.dart';

/// Client -> server message on the live interview stream.
sealed class CandidateInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CandidateInput({required this.clientSeq});

  /// Client-side monotonic counter (idempotency / debugging).
  int clientSeq;

  /// Returns a shallow copy of this [CandidateInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CandidateInput copyWith({int? clientSeq});
}

class _Undefined {}
