import 'dart:convert';
import 'dart:io' show File, Platform;
import 'package:after_call/components/call_record_card.dart';
import 'package:after_call/components/pressable_scale.dart';
import 'package:after_call/components/subtle_gradient_background.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:after_call/sevices/call_record_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _uploadRecording(BuildContext context) async {
    try {
      if (!kIsWeb && Platform.isAndroid) {
        try {
          await Permission.storage.request();
        } catch (_) {}
      }

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['mp3', 'm4a', 'wav'],
        withData: kIsWeb,
        withReadStream: !kIsWeb,
      );

      if (result == null || result.files.isEmpty) return;
      final file = result.files.single;

      String audioPathOrUrl;

      if (kIsWeb) {
        final bytes = file.bytes;
        if (bytes == null) throw Exception('No file data selected');
        // Construct data URL for web playback and processing
        final ext = (file.extension ?? '').toLowerCase();
        final mime =
            ext == 'mp3'
                ? 'audio/mpeg'
                : ext == 'wav'
                ? 'audio/wav'
                : 'audio/mp4';
        final b64 = base64Encode(bytes);
        audioPathOrUrl = 'data:$mime;base64,$b64';
      } else {
        // Persist a copy inside the app temporary directory and normalize to a real file path
        final tmp = await getTemporaryDirectory();
        final destPath =
            '${tmp.path}/upload_${DateTime.now().millisecondsSinceEpoch}.${file.extension ?? 'm4a'}';

        final srcPath = file.path;
        if (srcPath != null && !srcPath.startsWith('content://')) {
          // Direct filesystem path
          await File(srcPath).copy(destPath);
        } else if (file.readStream != null) {
          // Copy from content:// URI using the provided read stream
          final out = File(destPath).openWrite();
          await file.readStream!.pipe(out);
          await out.flush();
          await out.close();
        } else if (file.bytes != null) {
          await File(destPath).writeAsBytes(file.bytes!, flush: true);
        } else {
          throw Exception('Unable to access selected file data');
        }
        audioPathOrUrl = destPath;
      }

      if (context.mounted) context.push('/processing', extra: audioPathOrUrl);
    } catch (e) {
      debugPrint('Upload failed: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to access audio file: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final authService = context.watch<AuthService>();
    final recordService = context.watch<CallRecordService>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          toolbarHeight: 44,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      body: SubtleGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback:
                                  (bounds) =>
                                      AppGradients.primary.createShader(bounds),
                              child: Text(
                                'AfterCall',
                                style: context.textStyles.headlineMedium?.bold,
                              ),
                            ),
                            Text(
                              'Hi, ${authService.currentUser?.name ?? "there"} 👋',
                              style: context.textStyles.bodyMedium?.withColor(
                                colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.surfaceContainerHighest,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text(
                                        'Sign Out',
                                        style:
                                            context
                                                .textStyles
                                                .titleMedium
                                                ?.semiBold,
                                      ),
                                      content: Text(
                                        'Are you sure you want to sign out?',
                                        style: context.textStyles.bodyMedium,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.lg,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => context.pop(),
                                          child: Text(
                                            'Cancel',
                                            style: context.textStyles.bodyMedium
                                                ?.withColor(
                                                  colors.onSurfaceVariant,
                                                ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                            authService.signOut();
                                            context.go('/auth');
                                          },
                                          child: Text(
                                            'Sign Out',
                                            style: context
                                                .textStyles
                                                .bodyMedium
                                                ?.semiBold
                                                .withColor(colors.error),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              color: colors.onSurfaceVariant,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Tips Card
                    Container(
                      width: double.infinity,
                      padding: AppSpacing.paddingLg,
                      decoration: BoxDecoration(
                        gradient:
                            AppStyles.elevatedCard(
                              dark: theme.brightness == Brightness.dark,
                            ).gradient,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                          color: colors.outline.withOpacity(0.15),
                        ),
                        boxShadow: AppShadows.subtle,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppGradients.primary,
                              boxShadow: AppShadows.glowPrimary,
                            ),
                            child: Icon(
                              Icons.lightbulb_outline_rounded,
                              color: colors.onPrimary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Capture the moments ',
                                  style:
                                      context.textStyles.titleMedium?.semiBold,
                                ),

                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Record a short summary right after your call to keep things clear.',
                                  style: context.textStyles.bodyMedium
                                      ?.withColor(colors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Records List / Empty State
              Expanded(
                child:
                    recordService.isLoading
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppGradients.primary,
                                  boxShadow: AppShadows.glowPrimary,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                'Loading your calls...',
                                style: context.textStyles.titleMedium
                                    ?.withColor(colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        )
                        : recordService.records.isEmpty
                        ? _buildEmptyState(context, theme)
                        : _buildRecordsList(context, recordService),
              ),
            ],
          ),
        ),
      ),

      // **IMPROVED: Two Buttons Side by Side**
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(color: colors.outline.withOpacity(0.1), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Upload Button
            Expanded(
              child: PressableScale(
                onTap: () => _uploadRecording(context),
                scale: 0.98,
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: colors.outline.withOpacity(0.2)),
                    boxShadow: AppShadows.subtle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      onTap: () => _uploadRecording(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    colors.primary,
                                    colors.primaryContainer,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: AppShadows.glowPrimary,
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                color: colors.onPrimary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload',
                                  style:
                                      context.textStyles.labelLarge?.semiBold,
                                ),
                                Text(
                                  'Recording',
                                  style: context.textStyles.labelSmall
                                      ?.withColor(colors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // Record Button (Primary)
            Expanded(
              child: PressableScale(
                onTap: () => context.push('/record'),
                scale: 0.98,
                child: Container(
                  height: 68,
                  decoration: AppStyles.primaryGradientButton().copyWith(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: AppShadows.glowPrimary,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      onTap: () => context.push('/record'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.onPrimary,
                                boxShadow: AppShadows.large,
                              ),
                              child: Icon(
                                Icons.mic_rounded,
                                color: colors.primary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Record',
                                  style: context.textStyles.labelLarge?.semiBold
                                      .withColor(colors.onPrimary),
                                ),
                                Text(
                                  'New Call',
                                  style: context.textStyles.labelSmall
                                      ?.withColor(
                                        colors.onPrimary.withOpacity(0.9),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colors.surfaceContainer,
                    colors.surfaceContainerHigh,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: AppShadows.medium,
              ),
              child: Icon(
                Icons.call_end_rounded,
                size: 60,
                color: colors.onSurfaceVariant.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'No calls recorded yet',
              style: context.textStyles.headlineSmall?.semiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: AppSpacing.horizontalMd,
              child: Text(
                'Start by recording your first call summary or uploading a recording.',
                style: context.textStyles.bodyMedium?.withColor(
                  colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordsList(
    BuildContext context,
    CallRecordService recordService,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg, // Normal padding since buttons are now at bottom
      ),
      itemCount: recordService.records.length,
      itemBuilder: (context, index) {
        final record = recordService.records[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: CallRecordCard(
            record: record,
            onTap: () => context.push('/summary/${record.id}'),
          ),
        );
      },
    );
  }
}
