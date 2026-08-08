// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GamificationSummary _$GamificationSummaryFromJson(
  Map<String, dynamic> json,
) => _GamificationSummary(
  xp: (json['xp'] as num?)?.toInt() ?? 0,
  level: (json['level'] as num?)?.toInt() ?? 1,
  xpToNextLevel: (json['xpToNextLevel'] as num?)?.toInt() ?? 100,
  currentStreakDays: (json['currentStreakDays'] as num?)?.toInt() ?? 0,
  longestStreakDays: (json['longestStreakDays'] as num?)?.toInt() ?? 0,
  lastActiveDate: const _TimestampConverter().fromJson(json['lastActiveDate']),
  habitsCompletedCount: (json['habitsCompletedCount'] as num?)?.toInt() ?? 0,
  tasksCompletedCount: (json['tasksCompletedCount'] as num?)?.toInt() ?? 0,
  goalsCompletedCount: (json['goalsCompletedCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GamificationSummaryToJson(
  _GamificationSummary instance,
) => <String, dynamic>{
  'xp': instance.xp,
  'level': instance.level,
  'xpToNextLevel': instance.xpToNextLevel,
  'currentStreakDays': instance.currentStreakDays,
  'longestStreakDays': instance.longestStreakDays,
  'lastActiveDate': const _TimestampConverter().toJson(instance.lastActiveDate),
  'habitsCompletedCount': instance.habitsCompletedCount,
  'tasksCompletedCount': instance.tasksCompletedCount,
  'goalsCompletedCount': instance.goalsCompletedCount,
};
