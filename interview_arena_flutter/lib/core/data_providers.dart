import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import 'client_providers.dart';

/// The signed-in user's resumes, newest first.
final resumesProvider = FutureProvider.autoDispose<List<Resume>>(
  (ref) => ref.watch(clientProvider).resume.listResumes(),
);

/// One interview with its questions and answers (in order), for the
/// question-by-question breakdown.
final interviewDetailsProvider = FutureProvider.autoDispose
    .family<InterviewSession?, int>(
      (ref, id) => ref.watch(clientProvider).interview.getInterview(id),
    );

/// The signed-in user's interviews, newest first.
final interviewsProvider = FutureProvider.autoDispose<List<InterviewSession>>(
  (ref) => ref.watch(clientProvider).interview.listInterviews(),
);
