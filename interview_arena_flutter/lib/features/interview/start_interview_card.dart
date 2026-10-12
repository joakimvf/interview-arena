import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/client_providers.dart';
import '../../core/data_providers.dart';

/// Role field with quick picks and the primary "Start interview" action.
class StartInterviewCard extends ConsumerStatefulWidget {
  const StartInterviewCard({super.key});

  @override
  ConsumerState<StartInterviewCard> createState() => _StartInterviewCardState();
}

class _StartInterviewCardState extends ConsumerState<StartInterviewCard> {
  /// Shown only until a CV is analyzed; then the CV's suggested roles are.
  static const _genericRoles = [
    'Software Engineer',
    'Product Manager',
    'Project Manager',
    'Marketing Specialist',
    'Sales Manager',
  ];

  final _role = TextEditingController();
  var _prefilled = false;
  var _starting = false;

  @override
  void dispose() {
    _role.dispose();
    super.dispose();
  }

  Resume? _latestParsed(List<Resume>? resumes) =>
      resumes?.where((r) => r.status == ResumeParseStatus.parsed).firstOrNull;

  Future<void> _start(Resume? resume) async {
    final role = _role.text.trim();
    if (role.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick or type the role to practice for.')),
      );
      return;
    }
    setState(() => _starting = true);
    try {
      final s = await ref
          .read(clientProvider)
          .interview
          .start(role, resume?.id);
      if (mounted) context.go('/interview/${s.id}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Couldn\'t start the interview.')),
        );
      }
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resume = _latestParsed(ref.watch(resumesProvider).value);
    final headline = resume?.parsedData?.headline;
    final suggested = resume?.parsedData?.suggestedRoles ?? const [];
    final roles = suggested.isEmpty ? _genericRoles : suggested;
    if (!_prefilled && headline != null && _role.text.isEmpty) {
      _prefilled = true;
      _role.text = headline;
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _role,
              decoration: const InputDecoration(
                labelText: 'Role you\'re interviewing for',
                prefixIcon: Icon(Icons.work_outline),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _start(resume),
            ),
            const SizedBox(height: 12),
            if (suggested.isNotEmpty) ...[
              Text(
                'Suggested from your CV',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 6),
            ],
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final r in roles)
                  ChoiceChip(
                    label: Text(r),
                    selected: _role.text == r,
                    onSelected: (_) => setState(() => _role.text = r),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              resume == null
                  ? 'Tip: upload a resume first for questions about your experience.'
                  : 'Questions will draw on ${resume.fileName}.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _starting ? null : () => _start(resume),
              icon: _starting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: const Text('Start interview'),
            ),
          ],
        ),
      ),
    );
  }
}
