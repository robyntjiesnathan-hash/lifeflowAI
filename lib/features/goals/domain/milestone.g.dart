// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Milestone _$MilestoneFromJson(Map<String, dynamic> json) => _Milestone(
  id: json['id'] as String,
  title: json['title'] as String,
  isDone: json['isDone'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt() ?? 0,
  dueDate: const _TimestampConverter().fromJson(json['dueDate']),
  completedAt: const _TimestampConverter().fromJson(json['completedAt']),
);

Map<String, dynamic> _$MilestoneToJson(_Milestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isDone': instance.isDone,
      'order': instance.order,
      'dueDate': const _TimestampConverter().toJson(instance.dueDate),
      'completedAt': const _TimestampConverter().toJson(instance.completedAt),
    };
