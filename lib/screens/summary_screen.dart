import 'package:after_call/components/audio_player_widget.dart';
import 'package:after_call/components/subtle_gradient_background.dart';
import 'package:after_call/sevices/audio_service.dart';
import 'package:after_call/sevices/call_record_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SummaryScreen extends StatefulWidget {
  final String recordId;

  const SummaryScreen({super.key, required this.recordId});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordService = context.watch<CallRecordService>();
    final audioService = context.watch<AudioService>();
    final record = recordService.getRecordById(widget.recordId);

    if (record == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Call Summary')),
        body: const Center(child: Text('Record not found')),
      );
    }

    final dateFormat = DateFormat('EEEE, MMMM dd, yyyy • h:mm a');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.surface, // Uses theme surface color
        foregroundColor: context.colors.onSurface, // Uses theme text/icon color
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: context.colors.onSurface, // Theme icon color
          ),
        ),
        title: Text(
          'Call Summary',
          style: context.textStyles.titleLarge?.semiBold.copyWith(
            color: context.colors.onSurface, // Theme text color
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/edit-summary/${record.id}'),
            icon: Icon(
              Icons.edit_outlined,
              color: context.colors.onSurface, // Theme icon color
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      backgroundColor:
                          context.colors.surface, // Theme dialog background
                      surfaceTintColor: Colors.transparent,
                      title: Text(
                        'Delete Record',
                        style: context.textStyles.titleMedium?.semiBold
                            .copyWith(
                              color:
                                  context
                                      .colors
                                      .onSurface, // Theme dialog text color
                            ),
                      ),
                      content: Text(
                        'Are you sure you want to delete this record?',
                        style: context.textStyles.bodyMedium?.copyWith(
                          color:
                              context
                                  .colors
                                  .onSurfaceVariant, // Theme dialog content color
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            'Cancel',
                            style: context.textStyles.bodyMedium?.copyWith(
                              color:
                                  context
                                      .colors
                                      .onSurfaceVariant, // Theme cancel text
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            recordService.deleteRecord(record.id);
                            context.go('/');
                          },
                          child: Text(
                            'Delete',
                            style: context.textStyles.bodyMedium?.semiBold
                                .copyWith(
                                  color:
                                      context
                                          .colors
                                          .error, // Theme delete text color
                                ),
                          ),
                        ),
                      ],
                    ),
              );
            },
            icon: Icon(
              Icons.delete_outline,
              color: context.colors.onSurface, // Theme icon color
            ),
          ),
        ],
      ),
      body: SubtleGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateFormat.format(record.createdAt),
                  style: context.textStyles.labelMedium?.withColor(
                    theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _buildSection(
                  context,
                  theme,
                  'Summary',
                  Icons.description_outlined,
                  Text(record.summary, style: context.textStyles.bodyLarge),
                ),
                if (record.actionItems.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  _buildSection(
                    context,
                    theme,
                    'Action Items',
                    Icons.checklist,
                    Column(
                      children:
                          record.actionItems
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.sm,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 6,
                                          right: AppSpacing.md,
                                        ),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.tertiary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: context.textStyles.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
                if (record.deadlines.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  _buildSection(
                    context,
                    theme,
                    'Deadlines',
                    Icons.schedule,
                    Column(
                      children:
                          record.deadlines
                              .map(
                                (deadline) => Container(
                                  margin: const EdgeInsets.only(
                                    bottom: AppSpacing.sm,
                                  ),
                                  padding: AppSpacing.paddingMd,
                                  decoration: BoxDecoration(
                                    color:
                                        deadline.isOverdue
                                            ? theme.colorScheme.errorContainer
                                            : theme
                                                .colorScheme
                                                .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.md,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color:
                                            deadline.isOverdue
                                                ? theme
                                                    .colorScheme
                                                    .onErrorContainer
                                                : theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              deadline.description,
                                              style:
                                                  context
                                                      .textStyles
                                                      .bodyMedium
                                                      ?.medium,
                                            ),
                                            Text(
                                              DateFormat(
                                                'MMM dd, yyyy',
                                              ).format(deadline.dueDate),
                                              style: context
                                                  .textStyles
                                                  .labelSmall
                                                  ?.withColor(
                                                    deadline.isOverdue
                                                        ? theme
                                                            .colorScheme
                                                            .onErrorContainer
                                                        : theme
                                                            .colorScheme
                                                            .onSurfaceVariant,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (deadline.isOverdue)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacing.sm,
                                            vertical: AppSpacing.xs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.error,
                                            borderRadius: BorderRadius.circular(
                                              AppRadius.sm,
                                            ),
                                          ),
                                          child: Text(
                                            'Overdue',
                                            style: context.textStyles.labelSmall
                                                ?.withColor(
                                                  theme.colorScheme.onError,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                _buildSection(
                  context,
                  theme,
                  'Transcript',
                  Icons.notes,
                  Text(
                    record.transcript,
                    style: context.textStyles.bodyMedium?.withColor(
                      theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (record.audioUrl.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  AudioPlayerWidget(
                    isPlaying: audioService.isPlaying,
                    position: audioService.playbackPosition,
                    duration: audioService.playbackDuration,
                    onPlayPause: () {
                      if (audioService.isPlaying) {
                        audioService.pauseAudio();
                      } else {
                        audioService.playAudio(record.audioUrl);
                      }
                    },
                    onSeek: (position) => audioService.seekTo(position),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    ThemeData theme,
    String title,
    IconData icon,
    Widget content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(title, style: context.textStyles.titleMedium?.semiBold),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: AppSpacing.paddingLg,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: content,
        ),
      ],
    );
  }
}
