import 'package:after_call/models/call_record.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallRecordCard extends StatelessWidget {
  final CallRecord record;
  final VoidCallback onTap;

  const CallRecordCard({super.key, required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy • h:mm a');

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        Icons.call,
                        size: 20,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        dateFormat.format(record.createdAt),
                        style: context.textStyles.labelMedium?.withColor(
                          theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    if (record.actionItems.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          '${record.actionItems.length} tasks',
                          style: context.textStyles.labelSmall?.withColor(
                            theme.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  record.summary,
                  style: context.textStyles.bodyLarge?.semiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (record.deadlines.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: theme.colorScheme.tertiary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${record.deadlines.length} deadline${record.deadlines.length > 1 ? 's' : ''}',
                        style: context.textStyles.labelSmall?.withColor(
                          theme.colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
