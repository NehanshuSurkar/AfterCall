class Deadline {
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  Deadline({
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
  };

  factory Deadline.fromJson(Map<String, dynamic> json) => Deadline(
    description: json['description'] as String,
    dueDate: DateTime.parse(json['dueDate'] as String),
    isCompleted: json['isCompleted'] as bool? ?? false,
  );

  Deadline copyWith({
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) => Deadline(
    description: description ?? this.description,
    dueDate: dueDate ?? this.dueDate,
    isCompleted: isCompleted ?? this.isCompleted,
  );

  bool get isOverdue => DateTime.now().isAfter(dueDate) && !isCompleted;
}
