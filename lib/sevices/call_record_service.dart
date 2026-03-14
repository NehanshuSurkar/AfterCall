import 'dart:convert';
import 'package:after_call/models/call_record.dart';
import 'package:after_call/models/deadline.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallRecordService extends ChangeNotifier {
  List<CallRecord> _records = [];
  bool _isLoading = false;

  List<CallRecord> get records => List.unmodifiable(_records);
  bool get isLoading => _isLoading;

  CallRecordService() {
    loadRecords();
  }

  Future<void> loadRecords() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('call_records');

      if (recordsJson != null && recordsJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(recordsJson);
        _records =
            decoded
                .map((json) {
                  try {
                    return CallRecord.fromJson(json as Map<String, dynamic>);
                  } catch (e) {
                    debugPrint('Skipping invalid record: $e');
                    return null;
                  }
                })
                .whereType<CallRecord>()
                .toList();

        _records.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        _records = _generateSampleData();
        await _saveRecords();
      }
    } catch (e) {
      debugPrint('Failed to load records: $e');
      _records = _generateSampleData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<CallRecord> _generateSampleData() {
    final now = DateTime.now();
    return [
      CallRecord(
        id: '1',
        userId: 'demo',
        audioUrl: '',
        transcript:
            'We discussed the Q4 marketing campaign, including budget allocation for social media ads and content creation. Sarah mentioned the new product launch timeline needs to be moved up by two weeks.',
        summary:
            'Q4 marketing campaign planning with revised product launch timeline',
        actionItems: [
          'Review updated budget spreadsheet',
          'Schedule meeting with product team',
          'Draft social media content calendar',
        ],
        deadlines: [
          Deadline(
            description: 'Submit final campaign budget',
            dueDate: now.add(const Duration(days: 5)),
          ),
          Deadline(
            description: 'Product launch kickoff meeting',
            dueDate: now.add(const Duration(days: 3)),
          ),
        ],
        voiceSummaryUrl: '',
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      CallRecord(
        id: '2',
        userId: 'demo',
        audioUrl: '',
        transcript:
            'Client wants to update the website design with a more modern look. They liked the wireframes but want to see more color options. Budget is approved, and they want to start development next month.',
        summary:
            'Website redesign project approved - modern aesthetic with color variations',
        actionItems: [
          'Create 3 color palette options',
          'Update wireframes with chosen colors',
          'Send proposal to client',
          'Schedule development kickoff',
        ],
        deadlines: [
          Deadline(
            description: 'Send color options to client',
            dueDate: now.add(const Duration(days: 7)),
          ),
        ],
        voiceSummaryUrl: '',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      CallRecord(
        id: '3',
        userId: 'demo',
        audioUrl: '',
        transcript:
            'Weekly team standup covering sprint progress. Backend API is delayed by a few days, but frontend team is making good progress on the dashboard. Need to coordinate on the data format.',
        summary:
            'Team standup - backend delay, frontend progressing on dashboard',
        actionItems: [
          'Coordinate with backend on API data format',
          'Update sprint board with new timeline',
        ],
        deadlines: [],
        voiceSummaryUrl: '',
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  Future<void> _saveRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _records.map((r) => r.toJson()).toList();
      await prefs.setString('call_records', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Failed to save records: $e');
    }
  }

  Future<void> addRecord(CallRecord record) async {
    _records.insert(0, record);
    await _saveRecords();
    notifyListeners();
  }

  Future<void> updateRecord(CallRecord record) async {
    final index = _records.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _records[index] = record;
      await _saveRecords();
      notifyListeners();
    }
  }

  Future<void> deleteRecord(String id) async {
    _records.removeWhere((r) => r.id == id);
    await _saveRecords();
    notifyListeners();
  }

  CallRecord? getRecordById(String id) {
    try {
      return _records.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}
