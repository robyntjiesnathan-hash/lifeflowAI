import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

enum HabitFrequency { daily, weekly, customDays }

/// Small catalog mapping a stored string key to an [IconData] so Firestore
/// docs never store platform-specific icon codepoints directly.
enum HabitIconKey {
  meditate(Icons.self_improvement_rounded),
  workout(Icons.fitness_center_rounded),
  read(Icons.menu_book_rounded),
  water(Icons.water_drop_rounded),
  sleep(Icons.bedtime_rounded),
  noSugar(Icons.no_food_rounded),
  journal(Icons.edit_note_rounded),
  walk(Icons.directions_walk_rounded),
  custom(Icons.star_rounded);

  const HabitIconKey(this.icon);
  final IconData icon;
}

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
abstract class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String name,
    @Default(HabitIconKey.custom) HabitIconKey iconKey,
    @Default('#8B5CF6') String colorHex,
    @Default(HabitFrequency.daily) HabitFrequency frequency,
    @Default(<int>[]) List<int> customDays,
    @Default(1) int targetPerPeriod,
    String? reminderTime,
    String? subtitle,
    @_TimestampConverter() DateTime? createdAt,
    @_TimestampConverter() DateTime? archivedAt,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @_TimestampConverter() DateTime? lastCompletedDate,
  }) = _Habit;

  const Habit._();

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Color get color => Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
}
