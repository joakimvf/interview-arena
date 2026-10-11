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
import '../../protocol.dart' as _iototaiw;
import '../answer_feedback.dart' as _i8jmf1yf;
import '../interview_report.dart' as _id2icacn;
import '../interview_scores.dart' as _ifl1hwc4;
import '../question_category.dart' as _irka2p12;
part 'answer_evaluated.dart';
part 'answer_received.dart';
part 'interview_finished.dart';
part 'interview_notice.dart';
part 'question_asked.dart';
part 'score_update.dart';

/// Server -> client event on the live interview stream.
sealed class InterviewEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InterviewEvent({
    required this.interviewSessionId,
    required this.sequence,
  });

  int interviewSessionId;

  /// Monotonic per conduct() call.
  int sequence;

  /// Returns a shallow copy of this [InterviewEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InterviewEvent copyWith({
    int? interviewSessionId,
    int? sequence,
  });
}

class _Undefined {}
