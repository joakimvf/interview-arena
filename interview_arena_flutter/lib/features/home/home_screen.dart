import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/client_providers.dart';
import '../../core/data_providers.dart';
import '../interview/interview_history.dart';
import '../interview/start_interview_card.dart';
import '../resume/resume_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Arena'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authInfoProvider.notifier).signOut(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(resumesProvider);
          ref.invalidate(interviewsProvider);
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                Text(
                  'Ready for your next interview?',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upload your CV, pick a role, and practice with an AI '
                  'interviewer that scores you as you answer.',
                  style: theme.textTheme.bodyMedium,
                ),
                const _SectionHeader(
                  icon: Icons.description_outlined,
                  title: 'Your resume',
                ),
                const ResumeCard(),
                const _SectionHeader(
                  icon: Icons.play_circle_outline,
                  title: 'Start a mock interview',
                ),
                const StartInterviewCard(),
                _SectionHeader(
                  icon: Icons.history,
                  title: 'Recent interviews',
                  trailing: IconButton(
                    tooltip: 'Refresh',
                    icon: const Icon(Icons.refresh),
                    onPressed: () => ref.invalidate(interviewsProvider),
                  ),
                ),
                const InterviewHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.trailing,
  });
  final IconData icon;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
