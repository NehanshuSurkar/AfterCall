import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;

import 'package:after_call/models/call_record.dart';
import 'package:after_call/models/deadline.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Thrown when speech-to-text transcription fails.
class TranscriptionException implements Exception {
  final String message;
  TranscriptionException(this.message);
  @override
  String toString() => 'TranscriptionException: $message';
}

/// Thrown when LLM summarization fails.
class SummarizationException implements Exception {
  final String message;
  SummarizationException(this.message);
  @override
  String toString() => 'SummarizationException: $message';
}

/// Thrown when ElevenLabs TTS fails.
class TTSException implements Exception {
  final String message;
  TTSException(this.message);
  @override
  String toString() => 'TTSException: $message';
}

/// Thrown when the audio file cannot be read (permissions, missing file, etc.).
class FileAccessException implements Exception {
  final String message;
  FileAccessException(this.message);
  @override
  String toString() => 'FileAccessException: $message';
}

class AIService {
  // Hardcoded ElevenLabs credentials
  static const String _elevenLabsApiKey =
      'sk_194edde5df3fbb0554c2410b26601f403cb609479d07a28f'; // ⚠️ Replace with your actual key
  static const String _elevenLabsVoiceId = '21m00Tcm4TlvDq8ikWAM';

  AIService(); // No config parameter needed anymore

  Future<String> transcribeAudio(String audioPath) async {
    try {
      debugPrint('=== Starting ElevenLabs Speech-to-Text ===');
      debugPrint('Audio path type: $audioPath');

      // Check if it's a web blob URL or data URL
      if (kIsWeb) {
        debugPrint('Processing web audio...');

        // Handle web audio (blob URLs or data URLs)
        if (audioPath.startsWith('blob:')) {
          // Convert blob URL to data URL first
          debugPrint('Converting blob URL to data URL...');
          final dataUrl = await _blobUrlToDataUrl(audioPath);
          return await _transcribeDataUrl(dataUrl);
        } else if (audioPath.startsWith('data:')) {
          // Already a data URL
          return await _transcribeDataUrl(audioPath);
        } else {
          throw Exception('Unsupported web audio format: $audioPath');
        }
      }

      // Mobile/Desktop platform - existing code
      // Prepare audio bytes
      Uint8List audioBytes;
      String filename = 'audio.m4a';

      if (audioPath.startsWith('data:')) {
        final commaIndex = audioPath.indexOf(',');
        final base64Data =
            commaIndex != -1 ? audioPath.substring(commaIndex + 1) : '';
        audioBytes = base64Decode(base64Data);
        final mime = audioPath.substring(5, audioPath.indexOf(';'));
        if (mime.contains('mpeg')) filename = 'audio.mp3';
        if (mime.contains('wav')) filename = 'audio.wav';
        if (mime.contains('mp4') || mime.contains('aac'))
          filename = 'audio.m4a';
        debugPrint('Using data URL, file type: $mime');
      } else {
        try {
          final file = File(audioPath);
          if (!await file.exists()) {
            throw FileAccessException('Audio file not found');
          }
          audioBytes = await file.readAsBytes();
          filename = audioPath.split('/').last;
          debugPrint('Local file: $filename, size: ${audioBytes.length} bytes');
        } catch (e) {
          if (e is FileAccessException) rethrow;
          debugPrint('File read error: $e');
          throw FileAccessException('Unable to read the audio file');
        }
      }

      // Send to ElevenLabs STT
      return await _sendToElevenLabsStt(audioBytes, filename);
    } catch (e) {
      debugPrint('❌ ElevenLabs STT error: $e');
      if (e is TranscriptionException || e is FileAccessException) rethrow;
      throw TranscriptionException('Could not transcribe your recording: $e');
    }
  }

  // Helper method to transcribe data URL
  Future<String> _transcribeDataUrl(String dataUrl) async {
    debugPrint('Transcribing data URL...');

    // Extract base64 data from data URL
    final commaIndex = dataUrl.indexOf(',');
    if (commaIndex == -1) {
      throw Exception('Invalid data URL');
    }

    final base64Data = dataUrl.substring(commaIndex + 1);
    final audioBytes = base64Decode(base64Data);

    // Determine file type from MIME
    final mime = dataUrl.substring(5, dataUrl.indexOf(';'));
    String filename = 'audio.m4a';
    if (mime.contains('mpeg')) filename = 'audio.mp3';
    if (mime.contains('wav')) filename = 'audio.wav';
    if (mime.contains('mp4') || mime.contains('aac')) filename = 'audio.m4a';

    return await _sendToElevenLabsStt(audioBytes, filename);
  }

  // Helper method to send to ElevenLabs STT
  Future<String> _sendToElevenLabsStt(
    Uint8List audioBytes,
    String filename,
  ) async {
    debugPrint('Sending ${audioBytes.length} bytes to ElevenLabs STT...');

    final uri = Uri.parse('https://api.elevenlabs.io/v1/speech-to-text');

    final request =
        http.MultipartRequest('POST', uri)
          ..headers.addAll({
            'xi-api-key': _elevenLabsApiKey,
            'Accept': 'application/json',
          })
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              audioBytes,
              filename: filename,
            ),
          )
          ..fields['model_id'] = 'scribe_v1'
          ..fields['language_code'] = 'en';

    debugPrint('Sending to ElevenLabs STT API...');

    final stopwatch = Stopwatch()..start();
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    stopwatch.stop();

    final body = utf8.decode(response.bodyBytes);

    debugPrint('=== ElevenLabs STT Response ===');
    debugPrint('Status: ${response.statusCode}');
    debugPrint('Time: ${stopwatch.elapsedMilliseconds}ms');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final jsonMap = jsonDecode(body) as Map<String, dynamic>;
        final text = jsonMap['text'] as String?;

        if (text == null || text.isEmpty) {
          throw TranscriptionException('No speech detected in recording');
        }

        debugPrint('✅ ElevenLabs STT successful! Text length: ${text.length}');
        return text.trim();
      } catch (e) {
        debugPrint('❌ JSON parse error: $e');
        throw TranscriptionException('Invalid response from service');
      }
    }

    // Error handling
    String errMsg = 'Speech-to-text failed (${response.statusCode})';
    try {
      final errJson = jsonDecode(body) as Map<String, dynamic>;
      final detail = errJson['detail']?.toString();
      if (detail != null && detail.isNotEmpty) {
        errMsg = detail;
      }
    } catch (_) {}

    throw TranscriptionException(errMsg);
  }

  // Helper method to convert blob URL to data URL (web only)
  Future<String> _blobUrlToDataUrl(String blobUrl) async {
    debugPrint('Converting blob URL to data URL...');

    try {
      // On web, we need to fetch the blob and convert it
      final response = await http.get(Uri.parse(blobUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final base64 = base64Encode(bytes);
        // Assume it's m4a audio (common for web recording)
        return 'data:audio/mp4;base64,$base64';
      }
      throw Exception('Failed to fetch blob');
    } catch (e) {
      debugPrint('Error converting blob: $e');
      rethrow;
    }
  }

  //   Future<String> transcribeAudio(String audioPath) async {
  //   try {
  //     debugPrint('=== Starting ElevenLabs Speech-to-Text ===');

  //     // Prepare audio bytes
  //     Uint8List audioBytes;
  //     String filename = 'audio.m4a';

  //     if (audioPath.startsWith('data:')) {
  //       final commaIndex = audioPath.indexOf(',');
  //       final base64Data = commaIndex != -1 ? audioPath.substring(commaIndex + 1) : '';
  //       audioBytes = base64Decode(base64Data);
  //       final mime = audioPath.substring(5, audioPath.indexOf(';'));
  //       if (mime.contains('mpeg')) filename = 'audio.mp3';
  //       if (mime.contains('wav')) filename = 'audio.wav';
  //       if (mime.contains('mp4') || mime.contains('aac')) filename = 'audio.m4a';
  //       debugPrint('Using data URL, file type: $mime');
  //     } else if (!kIsWeb) {
  //       try {
  //         final file = File(audioPath);
  //         if (!await file.exists()) {
  //           throw FileAccessException('Audio file not found');
  //         }
  //         audioBytes = await file.readAsBytes();
  //         filename = audioPath.split('/').last;
  //         debugPrint('Local file: $filename, size: ${audioBytes.length} bytes');
  //       } catch (e) {
  //         if (e is FileAccessException) rethrow;
  //         debugPrint('File read error: $e');
  //         throw FileAccessException('Unable to read the audio file');
  //       }
  //     } else {
  //       throw Exception('Web audio not supported');
  //     }

  //     // ElevenLabs Speech-to-Text API endpoint
  //     final uri = Uri.parse('https://api.elevenlabs.io/v1/speech-to-text');

  //     debugPrint('ElevenLabs STT endpoint: $uri');

  //     // Create multipart request for ElevenLabs STT
  //     final request = http.MultipartRequest('POST', uri)
  //       ..headers.addAll({
  //         'xi-api-key': _elevenLabsApiKey,
  //         'Accept': 'application/json',
  //       })
  //       ..files.add(http.MultipartFile.fromBytes(
  //         'file',
  //         audioBytes,
  //         filename: filename,
  //       ))
  //       ..fields['model_id'] = 'scribe_v1';

  //     debugPrint('Sending to ElevenLabs STT API...');

  //     final stopwatch = Stopwatch()..start();
  //     final streamed = await request.send();
  //     final response = await http.Response.fromStream(streamed);
  //     stopwatch.stop();

  //     final body = utf8.decode(response.bodyBytes);

  //     debugPrint('=== ElevenLabs STT Response ===');
  //     debugPrint('Status: ${response.statusCode}');
  //     debugPrint('Time: ${stopwatch.elapsedMilliseconds}ms');
  //     debugPrint('Response (first 200 chars): ${body.length > 200 ? '${body.substring(0, 200)}...' : body}');
  //     // Replace the error handling section with this:

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       try {
  //         final jsonMap = jsonDecode(body) as Map<String, dynamic>;

  //         // Log the full structure for debugging
  //         debugPrint('Response keys: ${jsonMap.keys.join(', ')}');

  //         // ElevenLabs STT returns text directly in response
  //         final text = jsonMap['text'] as String?;
  //         if (text == null || text.isEmpty) {
  //           throw TranscriptionException('No speech detected in recording');
  //         }

  //         debugPrint('✅ ElevenLabs STT successful! Text: "$text"');
  //         return text.trim();
  //       } catch (e) {
  //         debugPrint('❌ JSON parse error: $e');
  //         debugPrint('Raw response: $body');
  //         throw TranscriptionException('Invalid response from service');
  //       }
  //     }

  //     // Handle ElevenLabs specific errors
  //     String errMsg = 'Speech-to-text failed (${response.statusCode})';
  //     try {
  //       final errJson = jsonDecode(body) as Map<String, dynamic>;
  //       final detail = errJson['detail']?.toString();
  //       if (detail != null && detail.isNotEmpty) {
  //         errMsg = detail;
  //       }
  //       debugPrint('Error details: $body');
  //     } catch (_) {
  //       debugPrint('Could not parse error response');
  //     }

  //     // Generic error messages for users
  //     if (response.statusCode == 401 || response.statusCode == 403) {
  //       errMsg = 'Speech-to-text service is currently unavailable';
  //     } else if (response.statusCode == 429) {
  //       errMsg = 'Service limit reached. Please try again later';
  //     } else if (response.statusCode == 500) {
  //       errMsg = 'Server error. Please try again';
  //     }

  //     throw TranscriptionException(errMsg);
  //   } catch (e) {
  //     debugPrint('❌ ElevenLabs STT error: $e');
  //     if (e is TranscriptionException || e is FileAccessException) rethrow;
  //     throw TranscriptionException('Could not transcribe your recording');
  //   }
  // }

  Future<CallRecord> generateSummary(String audioPath, String userId) async {
    final now = DateTime.now();

    // 1) Use ElevenLabs for Speech-to-Text
    debugPrint('=== Step 1: ElevenLabs Speech-to-Text ===');
    final transcript = await transcribeAudio(audioPath);

    // 2) Since no OpenAI, use transcript as summary with basic parsing
    debugPrint('Creating summary from transcript...');

    // Simple summary extraction (first 200 chars or till first period)
    String summaryText =
        transcript.length > 200
            ? '${transcript.substring(0, 200)}...'
            : transcript;

    // Simple action items extraction (look for common patterns)
    final List<String> actionItems = _extractActionItems(transcript);

    // Simple deadlines extraction
    final List<Deadline> deadlines = _extractDeadlines(transcript);

    // 3) Use ElevenLabs for Text-to-Speech (Voice Summary)
    String voiceUrl = '';
    try {
      debugPrint('=== Step 2: ElevenLabs Text-to-Speech ===');
      voiceUrl = await generateVoiceSummary(summaryText);
    } catch (e) {
      debugPrint('Voice summary generation failed: $e');
    }

    return CallRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      audioUrl: audioPath,
      transcript: transcript,
      summary: summaryText,
      actionItems: actionItems,
      deadlines: deadlines,
      voiceSummaryUrl: voiceUrl,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Helper method to extract simple action items from transcript
  List<String> _extractActionItems(String transcript) {
    final List<String> items = [];
    final lines = transcript.split('.');

    for (var line in lines) {
      final trimmed = line.trim().toLowerCase();
      if (trimmed.contains('need to') ||
          trimmed.contains('should') ||
          trimmed.contains('must') ||
          trimmed.contains('action:') ||
          trimmed.contains('task:')) {
        // Clean up the line
        String cleanLine = line.trim();
        if (cleanLine.length > 10) {
          // Only add if meaningful
          items.add(cleanLine);
          if (items.length >= 5) break; // Limit to 5 items
        }
      }
    }

    // Fallback: if no action items found, use first few sentences
    if (items.isEmpty && lines.length > 1) {
      items.addAll(
        lines.take(3).map((l) => l.trim()).where((l) => l.isNotEmpty),
      );
    }

    return items;
  }

  // Helper method to extract deadlines (simplified)
  List<Deadline> _extractDeadlines(String transcript) {
    final List<Deadline> deadlines = [];
    final now = DateTime.now();

    // Simple pattern matching for dates
    final datePatterns = [
      RegExp(r'by (\w+ \d{1,2}(?:st|nd|rd|th)?)'),
      RegExp(r'on (\w+ \d{1,2}(?:st|nd|rd|th)?)'),
      RegExp(r'(\d{1,2}/\d{1,2}/\d{2,4})'),
      RegExp(r'(\w+day)'),
    ];

    final lines = transcript.split('.');
    for (var line in lines) {
      for (var pattern in datePatterns) {
        final match = pattern.firstMatch(line.toLowerCase());
        if (match != null && line.trim().length > 20) {
          try {
            // Simplified deadline creation
            deadlines.add(
              Deadline(
                description: line.trim(),
                dueDate: now.add(const Duration(days: 7)), // Default 7 days
              ),
            );
            break;
          } catch (e) {
            debugPrint('Failed to create deadline: $e');
          }
        }
      }
      if (deadlines.length >= 3) break; // Limit to 3 deadlines
    }

    return deadlines;
  }

  Future<String> generateVoiceSummary(String summary) async {
    final uri = Uri.parse(
      'https://api.elevenlabs.io/v1/text-to-speech/$_elevenLabsVoiceId',
    );

    final payload = jsonEncode({
      'text': summary.length > 500 ? summary.substring(0, 500) : summary,
      'model_id': 'eleven_multilingual_v2',
      'voice_settings': {
        'stability': 0.4,
        'similarity_boost': 0.8,
        'style': 0.3,
        'use_speaker_boost': true,
      },
    });

    final resp = await http.post(
      uri,
      headers: {
        'accept': 'audio/mpeg',
        'content-type': 'application/json',
        'xi-api-key': _elevenLabsApiKey,
      },
      body: payload,
    );

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      final text = utf8.decode(resp.bodyBytes);
      debugPrint('ElevenLabs TTS failed: ${resp.statusCode} $text');
      throw TTSException('Voice generation failed');
    }

    final bytes = resp.bodyBytes;

    if (kIsWeb) {
      final b64 = base64Encode(bytes);
      return 'data:audio/mpeg;base64,$b64';
    }

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/tts_${DateTime.now().millisecondsSinceEpoch}.mp3';
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    return path;
  }
}
