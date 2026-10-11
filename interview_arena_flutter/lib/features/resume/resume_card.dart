import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/client_providers.dart';
import '../../core/data_providers.dart';
import 'resume_upload.dart';

/// Latest resume with its parse status and extracted skills (Upwork-style).
class ResumeCard extends ConsumerStatefulWidget {
  const ResumeCard({super.key});

  @override
  ConsumerState<ResumeCard> createState() => _ResumeCardState();
}

class _ResumeCardState extends ConsumerState<ResumeCard> {
  String? _uploadingName;

  Future<void> _pickAndUpload() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    if (file == null) return;
    setState(() => _uploadingName = file.name);
    try {
      final bytes = await file.readAsBytes();
      final resume = await uploadAndParseResume(
        ref.read(clientProvider),
        file.name,
        bytes,
      );
      if (resume.status == ResumeParseStatus.failed && mounted) {
        _snack('We couldn\'t read that PDF. Try another file.');
      }
    } on ResumeException catch (e) {
      _snack(switch (e.reason) {
        'not_pdf' => 'That file isn\'t a PDF.',
        'too_large' => 'That PDF is larger than 5 MB.',
        _ => 'Upload failed (${e.reason}).',
      });
    } catch (e) {
      _snack('Upload failed. Check your connection and try again.');
    } finally {
      if (mounted) setState(() => _uploadingName = null);
      ref.invalidate(resumesProvider);
    }
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resumes = ref.watch(resumesProvider);
    final uploading = _uploadingName;

    if (uploading != null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.picture_as_pdf_outlined),
          title: Text(uploading),
          subtitle: const Text('Uploading and analyzing…'),
          trailing: const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: switch (resumes) {
          AsyncData(:final value) when value.isEmpty => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add your resume so the questions match your experience.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text('PDF, 5 MB or less', style: theme.textTheme.labelSmall),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _pickAndUpload,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload your resume'),
              ),
            ],
          ),
          AsyncData(:final value) => _ResumeDetails(
            resume: value.first,
            onReplace: _pickAndUpload,
            onRefresh: () => ref.invalidate(resumesProvider),
          ),
          AsyncError() => Row(
            children: [
              const Expanded(child: Text('Couldn\'t load your resume.')),
              TextButton(
                onPressed: () => ref.invalidate(resumesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          _ => const LinearProgressIndicator(),
        },
      ),
    );
  }
}

class _ResumeDetails extends StatelessWidget {
  const _ResumeDetails({
    required this.resume,
    required this.onReplace,
    required this.onRefresh,
  });

  final Resume resume;
  final VoidCallback onReplace;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parsed = resume.parsedData;
    final skills = [...?parsed?.skills]
      ..sort((a, b) => b.confidence.compareTo(a.confidence));
    final (statusText, statusIcon) = switch (resume.status) {
      ResumeParseStatus.parsed => (
        'Analyzed',
        Icon(Icons.check_circle, color: Colors.green.shade600),
      ),
      ResumeParseStatus.failed => (
        resume.parseError ?? 'Couldn\'t be analyzed',
        Icon(Icons.error_outline, color: theme.colorScheme.error),
      ),
      _ => (
        'Analyzing…',
        const SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.picture_as_pdf_outlined),
          title: Text(resume.fileName),
          subtitle: Text(statusText),
          trailing: statusIcon,
        ),
        if (parsed != null) ...[
          if (parsed.headline case final headline?)
            Text(headline, style: theme.textTheme.titleMedium),
          if (parsed.yearsOfExperience case final years?)
            Text(
              '${years % 1 == 0 ? years.toInt() : years} years of experience',
              style: theme.textTheme.bodyMedium,
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final s in skills.take(12))
                Chip(label: Text(s.name), visualDensity: VisualDensity.compact),
            ],
          ),
        ],
        const SizedBox(height: 8),
        Row(
          children: [
            TextButton.icon(
              onPressed: onReplace,
              icon: const Icon(Icons.upload_file),
              label: const Text('Replace'),
            ),
            if (resume.status == ResumeParseStatus.parsing)
              TextButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
          ],
        ),
      ],
    );
  }
}
