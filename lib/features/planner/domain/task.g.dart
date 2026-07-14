// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  notes: json['notes'] as String?,
  dueDate: const _TimestampConverter().fromJson(json['dueDate']),
  dueTime: json['dueTime'] as String?,
  isAllDay: json['isAllDay'] as bool? ?? false,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.todo,
  priority:
      $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
      TaskPriority.medium,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  goalId: json['goalId'] as String?,
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const _TimestampConverter().fromJson(json['updatedAt']),
  completedAt: const _TimestampConverter().fromJson(json['completedAt']),
  reminderId: json['reminderId'] as String?,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'notes': instance.notes,
  'dueDate': const _TimestampConverter().toJson(instance.dueDate),
  'dueTime': instance.dueTime,
  'isAllDay': instance.isAllDay,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'tags': instance.tags,
  'goalId': instance.goalId,
  'createdAt': const _TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const _TimestampConverter().toJson(instance.updatedAt),
  'completedAt': const _TimestampConverter().toJson(instance.completedAt),
  'reminderId': instance.reminderId,
};

const _$TaskStatusEnumMap = {
  TaskStatus.todo: 'todo',
  TaskStatus.inProgress: 'inProgress',
  TaskStatus.done: 'done',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
};
