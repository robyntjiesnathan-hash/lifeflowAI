// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  category:
      $enumDecodeNullable(_$GoalCategoryEnumMap, json['category']) ??
      GoalCategory.other,
  targetDate: const _TimestampConverter().fromJson(json['targetDate']),
  status:
      $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
      GoalStatus.active,
  progressMode:
      $enumDecodeNullable(_$GoalProgressModeEnumMap, json['progressMode']) ??
      GoalProgressMode.milestoneBased,
  manualProgressPercent: json['manualProgressPercent'] as num?,
  progressPercent: json['progressPercent'] as num? ?? 0,
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const _TimestampConverter().fromJson(json['updatedAt']),
  completedAt: const _TimestampConverter().fromJson(json['completedAt']),
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': _$GoalCategoryEnumMap[instance.category]!,
  'targetDate': const _TimestampConverter().toJson(instance.targetDate),
  'status': _$GoalStatusEnumMap[instance.status]!,
  'progressMode': _$GoalProgressModeEnumMap[instance.progressMode]!,
  'manualProgressPercent': instance.manualProgressPercent,
  'progressPercent': instance.progressPercent,
  'createdAt': const _TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const _TimestampConverter().toJson(instance.updatedAt),
  'completedAt': const _TimestampConverter().toJson(instance.completedAt),
};

const _$GoalCategoryEnumMap = {
  GoalCategory.health: 'health',
  GoalCategory.career: 'career',
  GoalCategory.finance: 'finance',
  GoalCategory.personal: 'personal',
  GoalCategory.learning: 'learning',
  GoalCategory.other: 'other',
};

const _$GoalStatusEnumMap = {
  GoalStatus.active: 'active',
  GoalStatus.completed: 'completed',
  GoalStatus.abandoned: 'abandoned',
};

const _$GoalProgressModeEnumMap = {
  GoalProgressMode.milestoneBased: 'milestoneBased',
  GoalProgressMode.manual: 'manual',
};
