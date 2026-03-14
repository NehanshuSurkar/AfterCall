import 'package:after_call/components/recording_button.dart';
import 'package:after_call/components/subtle_gradient_background.dart';
import 'package:after_call/sevices/audio_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String? _recordingPath;
  bool _permissionDenied = false;

  Future<void> _toggleRecording() async {
    final audioService = context.read<AudioService>();

    if (audioService.isRecording) {
      debugPrint('Stopping recording...');
      final path = await audioService.stopRecording();

      if (path != null && mounted) {
        debugPrint('Recording path: $path');

        // For web, we might need to handle the audio data differently
        // but for now, just pass it to the processing screen
        context.push('/processing', extra: path);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save recording'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      debugPrint('Starting recording...');
      final path = await audioService.startRecording();

      if (path == null && mounted) {
        // Show permission error
        if (kIsWeb) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please allow microphone access in your browser'),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          _showPermissionDialog();
        }
      }
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Microphone Permission Required'),
            content: const Text(
              'AfterCall needs access to your microphone to record voice notes.\n\n'
              'Please grant permission in your device settings:\n'
              '1. Go to your device Settings\n'
              '2. Find "AfterCall" in the apps list\n'
              '3. Tap "Permissions"\n'
              '4. Enable "Microphone"',
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  context.pop();
                  await openAppSettings(); // This opens device settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audioService = context.watch<AudioService>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Record Summary'),
      ),
      body: SubtleGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.paddingXl,
            child: Column(
              children: [
                const Spacer(),
                RecordingButton(
                  isRecording: audioService.isRecording,
                  onPressed: _toggleRecording,
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  audioService.isRecording
                      ? _formatDuration(audioService.recordingDuration)
                      : '00:00',
                  style: context.textStyles.displayMedium?.copyWith(
                    fontFeatures: [const FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  audioService.isRecording
                      ? 'Recording in progress...'
                      : 'Tap to start recording',
                  style: context.textStyles.titleMedium?.withColor(
                    theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: AppSpacing.paddingLg,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Record what was discussed, not the call itself. Max 5 minutes.',
                          style: context.textStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
