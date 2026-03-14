import 'package:after_call/components/subtle_gradient_background.dart';
import 'package:after_call/sevices/ai_service.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:after_call/sevices/call_record_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProcessingScreen extends StatefulWidget {
  final String audioPath;

  const ProcessingScreen({super.key, required this.audioPath});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _processAudio();
  }

  Future<void> _processAudio() async {
    try {
      debugPrint('=== STARTING AUDIO PROCESSING ===');
      debugPrint('Audio path: ${widget.audioPath}');
      debugPrint('Is web: $kIsWeb');

      final aiService = AIService();
      final authService = context.read<AuthService>();
      final recordService = context.read<CallRecordService>();

      debugPrint('Generating summary...');
      final record = await aiService.generateSummary(
        widget.audioPath,
        authService.currentUser?.id ?? 'demo',
      );

      debugPrint('Summary generated, adding to records...');
      await recordService.addRecord(record);

      if (mounted) {
        debugPrint('Processing complete, navigating to summary...');
        setState(() => _isProcessing = false);
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.go('/summary/${record.id}');
        }
      }
    } catch (e) {
      debugPrint('=== PROCESSING ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: ${e.toString()}');

      if (!mounted) return;
      String message;
      if (e is FileAccessException) {
        message = 'File access error: ${e.message}';
      } else if (e is TranscriptionException) {
        message = 'Transcription failed: ${e.message}';
      } else if (e is SummarizationException) {
        message = 'Processing failed: ${e.message}';
      } else {
        message = 'Processing failed: $e';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 5)),
      );

      // Go back to home instead of record screen
      context.go('/');
    }
  }

  // Future<void> _processAudio() async {
  //   try {
  //     final aiService = AIService(); // No config needed
  //     final authService = context.read<AuthService>();
  //     final recordService = context.read<CallRecordService>();

  //     final record = await aiService.generateSummary(
  //       widget.audioPath,
  //       authService.currentUser?.id ?? 'demo',
  //     );

  //     await recordService.addRecord(record);

  //     if (mounted) {
  //       setState(() => _isProcessing = false);
  //       await Future.delayed(const Duration(milliseconds: 500));
  //       if (mounted) {
  //         context.go('/summary/${record.id}');
  //       }
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     String message;
  //     if (e is FileAccessException) {
  //       message = 'File access error: ${e.message}';
  //     } else if (e is TranscriptionException) {
  //       message = 'Transcription failed: ${e.message}';
  //     } else if (e is SummarizationException) {
  //       message = 'Processing failed: ${e.message}';
  //     } else {
  //       message = 'Processing failed. Please try again.';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  //     context.pop();
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SubtleGradientBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: AppSpacing.paddingXl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: _controller,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 4,
                        ),
                        gradient: SweepGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Turning your thoughts into clarity…',
                    style: context.textStyles.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'We\'re extracting key points, action items, and dates from your note.',
                    style: context.textStyles.bodyMedium?.withColor(
                      theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
