// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Habit _$HabitFromJson(Map<String, dynamic> json) => _Habit(
  id: json['id'] as String,
  name: json['name'] as String,
  iconKey:
      $enumDecodeNullable(_$HabitIconKeyEnumMap, json['iconKey']) ??
      HabitIconKey.custom,
  colorHex: json['colorHex'] as String? ?? '#8B5CF6',
  frequency:
      $enumDecodeNullable(_$HabitFrequencyEnumMap, json['frequency']) ??
      HabitFrequency.daily,
  customDays:
      (json['customDays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  targetPerPeriod: (json['targetPerPeriod'] as num?)?.toInt() ?? 1,
  reminderTime: json['reminderTime'] as String?,
  subtitle: json['subtitle'] as String?,
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
  archivedAt: const _TimestampConverter().fromJson(json['archivedAt']),
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  lastCompletedDate: const _TimestampConverter().fromJson(
    json['lastCompletedDate'],
  ),
);

Map<String, dynamic> _$HabitToJson(_Habit instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'iconKey': _$HabitIconKeyEnumMap[instance.iconKey]!,
  'colorHex': instance.colorHex,
  'frequency': _$HabitFrequencyEnumMap[instance.frequency]!,
  'customDays': instance.customDays,
  'targetPerPeriod': instance.targetPerPeriod,
  'reminderTime': instance.reminderTime,
  'subtitle': instance.subtitle,
  'createdAt': const _TimestampConverter().toJson(instance.createdAt),
  'archivedAt': const _TimestampConverter().toJson(instance.archivedAt),
  'currentStreak': instance.currentStreak,
  'longestStreak': instance.longestStreak,
  'lastCompletedDate': const _TimestampConverter().toJson(
    instance.lastCompletedDate,
  ),
};

const _$HabitIconKeyEnumMap = {
  HabitIconKey.meditate: 'meditate',
  HabitIconKey.workout: 'workout',
  HabitIconKey.read: 'read',
  HabitIconKey.water: 'water',
  HabitIconKey.sleep: 'sleep',
  HabitIconKey.noSugar: 'noSugar',
  HabitIconKey.journal: 'journal',
  HabitIconKey.walk: 'walk',
  HabitIconKey.custom: 'custom',
};

const _$HabitFrequencyEnumMap = {
  HabitFrequency.daily: 'daily',
  HabitFrequency.weekly: 'weekly',
  HabitFrequency.customDays: 'customDays',
};
