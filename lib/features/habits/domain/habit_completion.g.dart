// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HabitCompletion _$HabitCompletionFromJson(Map<String, dynamic> json) =>
    _HabitCompletion(
      date: json['date'] as String,
      completed: json['completed'] as bool? ?? true,
      completedAt: const _TimestampConverter().fromJson(json['completedAt']),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$HabitCompletionToJson(_HabitCompletion instance) =>
    <String, dynamic>{
      'date': instance.date,
      'completed': instance.completed,
      'completedAt': const _TimestampConverter().toJson(instance.completedAt),
      'note': instance.note,
    };
