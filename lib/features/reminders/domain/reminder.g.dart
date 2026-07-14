// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  title: json['title'] as String,
  scheduledAt: DateTime.parse(json['scheduledAt'] as String),
  repeat:
      $enumDecodeNullable(_$ReminderRepeatEnumMap, json['repeat']) ??
      ReminderRepeat.none,
  relatedType:
      $enumDecodeNullable(_$ReminderRelatedTypeEnumMap, json['relatedType']) ??
      ReminderRelatedType.custom,
  relatedId: json['relatedId'] as String?,
  isEnabled: json['isEnabled'] as bool? ?? true,
  localNotificationId: (json['localNotificationId'] as num?)?.toInt(),
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'scheduledAt': instance.scheduledAt.toIso8601String(),
  'repeat': _$ReminderRepeatEnumMap[instance.repeat]!,
  'relatedType': _$ReminderRelatedTypeEnumMap[instance.relatedType]!,
  'relatedId': instance.relatedId,
  'isEnabled': instance.isEnabled,
  'localNotificationId': instance.localNotificationId,
  'createdAt': const _TimestampConverter().toJson(instance.createdAt),
};

const _$ReminderRepeatEnumMap = {
  ReminderRepeat.none: 'none',
  ReminderRepeat.daily: 'daily',
  ReminderRepeat.weekly: 'weekly',
  ReminderRepeat.monthly: 'monthly',
};

const _$ReminderRelatedTypeEnumMap = {
  ReminderRelatedType.task: 'task',
  ReminderRelatedType.habit: 'habit',
  ReminderRelatedType.goal: 'goal',
  ReminderRelatedType.custom: 'custom',
};
