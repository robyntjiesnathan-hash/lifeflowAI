import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskStatus { todo, inProgress, done }

enum TaskPriority { low, medium, high }

class _TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const _TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) => object == null ? null : Timestamp.fromDate(object);
}

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? notes,
    @_TimestampConverter() DateTime? dueDate,
    String? dueTime,
    @Default(false) bool isAllDay,
    @Default(TaskStatus.todo) TaskStatus status,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default(<String>[]) List<String> tags,
    String? goalId,
    @_TimestampConverter() DateTime? createdAt,
    @_TimestampConverter() DateTime? updatedAt,
    @_TimestampConverter() DateTime? completedAt,
    String? reminderId,
  }) = _Task;

  const Task._();

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  bool get isDone => status == TaskStatus.done;
}

extension TaskPriorityX on TaskPriority {
  /// Left-accent / badge color per priority, matching the reference
  /// design's colored left-bar timeline cards.
  Color color(BuildContext context) {
    final theme = Theme.of(context);
    switch (this) {
      case TaskPriority.high:
        return theme.colorScheme.error;
      case TaskPriority.medium:
        return const Color(0xFFF59E0B);
      case TaskPriority.low:
        return const Color(0xFF14B8A6);
    }
  }

  String get label {
    switch (this) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }
}
