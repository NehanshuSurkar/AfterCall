import 'package:after_call/models/deadline.dart';

class CallRecord {
  final String id;
  final String userId;
  final String audioUrl;
  final String transcript;
  final String summary;
  final List<String> actionItems;
  final List<Deadline> deadlines;
  final String voiceSummaryUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  CallRecord({
    required this.id,
    required this.userId,
    required this.audioUrl,
    required this.transcript,
    required this.summary,
    required this.actionItems,
    required this.deadlines,
    required this.voiceSummaryUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'audioUrl': audioUrl,
    'transcript': transcript,
    'summary': summary,
    'actionItems': actionItems,
    'deadlines': deadlines.map((d) => d.toJson()).toList(),
    'voiceSummaryUrl': voiceSummaryUrl,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CallRecord.fromJson(Map<String, dynamic> json) {
    final actionItemsData = json['actionItems'];
    final List<String> actionItems =
        actionItemsData is List
            ? actionItemsData.map((item) => item.toString()).toList()
            : [];

    final deadlinesData = json['deadlines'];
    final List<Deadline> deadlines =
        deadlinesData is List
            ? deadlinesData
                .map((item) => Deadline.fromJson(item as Map<String, dynamic>))
                .toList()
            : [];

    return CallRecord(
      id: json['id'] as String,
      userId: json['userId'] as String,
      audioUrl: json['audioUrl'] as String? ?? '',
      transcript: json['transcript'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      actionItems: actionItems,
      deadlines: deadlines,
      voiceSummaryUrl: json['voiceSummaryUrl'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  CallRecord copyWith({
    String? id,
    String? userId,
    String? audioUrl,
    String? transcript,
    String? summary,
    List<String>? actionItems,
    List<Deadline>? deadlines,
    String? voiceSummaryUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CallRecord(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    audioUrl: audioUrl ?? this.audioUrl,
    transcript: transcript ?? this.transcript,
    summary: summary ?? this.summary,
    actionItems: actionItems ?? this.actionItems,
    deadlines: deadlines ?? this.deadlines,
    voiceSummaryUrl: voiceSummaryUrl ?? this.voiceSummaryUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  String get previewText {
    if (summary.length > 80) return '${summary.substring(0, 80)}...';
    return summary;
  }
}
