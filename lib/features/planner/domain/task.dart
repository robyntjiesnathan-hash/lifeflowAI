import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/theme/app_semantic_colors.dart';

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
  /// Left-accent / badge color per priority, routed through the app's
  /// named semantic tokens (Brick Rose/Honey/Meadow-teal) rather than
  /// one-off hex values so priority colors stay in sync with the rest of
  /// the palette.
  Color color(BuildContext context) {
    final semantic = context.semanticColors;
    switch (this) {
      case TaskPriority.high:
        return semantic.error;
      case TaskPriority.medium:
        return semantic.warning;
      case TaskPriority.low:
        return semantic.categoryTeal;
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
