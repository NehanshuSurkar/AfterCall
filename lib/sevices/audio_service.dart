import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class AudioService extends ChangeNotifier {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  Timer? _recordingTimer;

  bool _isRecording = false;
  bool _isPlaying = false;
  Duration _recordingDuration = Duration.zero;
  Duration _playbackPosition = Duration.zero;
  Duration _playbackDuration = Duration.zero;
  String? _currentRecordingPath;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  Duration get recordingDuration => _recordingDuration;
  Duration get playbackPosition => _playbackPosition;
  Duration get playbackDuration => _playbackDuration;

  AudioService() {
    _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _player.onPositionChanged.listen((position) {
      _playbackPosition = position;
      notifyListeners();
    });

    _player.onDurationChanged.listen((duration) {
      _playbackDuration = duration;
      notifyListeners();
    });
  }

  Future<bool> requestMicrophonePermission() async {
    try {
      if (kIsWeb) {
        // On web, the recorder handles permission automatically
        debugPrint('Web: Checking microphone permission via recorder');
        return await _recorder.hasPermission();
      }

      // Mobile platforms
      debugPrint('Mobile: Checking microphone permission');
      var status = await Permission.microphone.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        status = await Permission.microphone.request();
        return status.isGranted;
      }

      return false;
    } catch (e) {
      debugPrint('Permission request error: $e');
      return false;
    }
  }

  Future<String?> startRecording() async {
    try {
      debugPrint('=== START RECORDING ===');

      if (_isRecording) {
        await stopRecording();
      }

      final hasPermission = await requestMicrophonePermission();
      if (!hasPermission) {
        debugPrint('Microphone permission denied');
        return null;
      }

      String path;

      if (kIsWeb) {
        debugPrint('Starting web recording...');
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        path = 'web_recording_$timestamp';

        // On web, we can call start() without a path
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: '',
        );

        _isRecording = true;
        _recordingDuration = Duration.zero;
        _currentRecordingPath = path;
        _startRecordingTimer();

        notifyListeners();
        debugPrint('Web recording started');
        return path;
      } else {
        debugPrint('Starting mobile recording...');
        final directory = await getApplicationDocumentsDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        path = '${directory.path}/recording_$timestamp.m4a';

        debugPrint('Recording to: $path');

        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: path,
        );

        _isRecording = true;
        _recordingDuration = Duration.zero;
        _currentRecordingPath = path;
        _startRecordingTimer();

        notifyListeners();
        debugPrint('Mobile recording started');
        return path;
      }
    } catch (e) {
      debugPrint('Failed to start recording: $e');
      _isRecording = false;
      notifyListeners();

      if (kIsWeb) {
        debugPrint('Web recording failed. Tips:');
        debugPrint('1. Use HTTPS (localhost works)');
        debugPrint('2. Allow microphone when browser asks');
        debugPrint('3. Try: flutter run -d chrome --web-renderer html');
      }

      return null;
    }
  }

  void _startRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isRecording) {
        timer.cancel();
        return;
      }

      _recordingDuration += const Duration(seconds: 1);
      notifyListeners();

      if (_recordingDuration.inMinutes >= 5) {
        stopRecording();
        timer.cancel();
      }
    });
  }

  // In the stopRecording() method, add web audio conversion
  Future<String?> stopRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      if (!_isRecording) {
        debugPrint('No recording in progress');
        return _currentRecordingPath;
      }

      debugPrint('Stopping recording...');

      final path = await _recorder.stop();
      _isRecording = false;
      notifyListeners();

      if (path != null) {
        debugPrint('Recording saved: $path');

        // For web, convert blob to data URL for easier processing
        if (kIsWeb && path.startsWith('blob:')) {
          debugPrint('Converting web blob to data URL...');
          try {
            // Convert blob URL to data URL
            final dataUrl = await _convertBlobToDataUrl(path);
            debugPrint('Converted to data URL: ${dataUrl.substring(0, 50)}...');
            return dataUrl;
          } catch (e) {
            debugPrint('Failed to convert blob: $e');
            // Return original blob URL as fallback
            return path;
          }
        }

        if (!kIsWeb) {
          final file = File(path);
          if (await file.exists()) {
            final size = await file.length();
            debugPrint('File size: ${size / 1024} KB');
          }
        }
      } else {
        debugPrint('Recorder returned null path');
      }

      return path;
    } catch (e) {
      debugPrint('Failed to stop recording: $e');
      _isRecording = false;
      _recordingTimer?.cancel();
      _recordingTimer = null;
      notifyListeners();
      return null;
    }
  }

  // Add this helper method for web blob conversion
  Future<String> _convertBlobToDataUrl(String blobUrl) async {
    if (!kIsWeb) return blobUrl;

    try {
      // Fetch the blob
      final response = await http.get(Uri.parse(blobUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final base64 = base64Encode(bytes);
        return 'data:audio/mp4;base64,$base64';
      }
      throw Exception('Failed to fetch blob: ${response.statusCode}');
    } catch (e) {
      debugPrint('Blob conversion error: $e');
      rethrow;
    }
  }

  Future<void> playAudio(String path) async {
    try {
      await _player.stop();

      if (path.startsWith('http') ||
          path.startsWith('blob:') ||
          path.startsWith('data:')) {
        await _player.play(UrlSource(path));
      } else if (!kIsWeb) {
        final file = File(path);
        if (await file.exists()) {
          await _player.play(DeviceFileSource(path));
        }
      }
    } catch (e) {
      debugPrint('Failed to play audio: $e');
    }
  }

  Future<void> pauseAudio() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Failed to pause audio: $e');
    }
  }

  Future<void> resumeAudio() async {
    try {
      await _player.resume();
    } catch (e) {
      debugPrint('Failed to resume audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await _player.stop();
      _playbackPosition = Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to stop audio: $e');
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint('Failed to seek: $e');
    }
  }

  Future<bool> deleteAudioFile(String path) async {
    try {
      if (kIsWeb) return true;

      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Failed to delete audio file: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }
}
