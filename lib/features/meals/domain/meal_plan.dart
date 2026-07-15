import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan.freezed.dart';
part 'meal_plan.g.dart';

/// The four planner slots per day, in display order, each carrying the
/// label/icon shown on the Meal Planner screen.
enum MealSlot {
  breakfast('breakfast', 'Breakfast', Icons.free_breakfast_rounded),
  lunch('lunch', 'Lunch', Icons.lunch_dining_rounded),
  dinner('dinner', 'Dinner', Icons.dinner_dining_rounded),
  snack('snack', 'Snack', Icons.cookie_rounded);

  const MealSlot(this.key, this.label, this.icon);

  /// Matches the string key stored under `MealPlan.days[day]`.
  final String key;
  final String label;
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

/// Doc id is the ISO-8601 week id (e.g. `"2026-W28"`, see [MealPlanWeek]), so
/// "what's planned for week Y" is a direct doc lookup rather than a query.
@freezed
abstract class MealPlan with _$MealPlan {
  const factory MealPlan({
    required String id,
    @_TimestampConverter() DateTime? weekStartDate,
    @Default(<String, Map<String, String?>>{}) Map<String, Map<String, String?>> days,
  }) = _MealPlan;

  const MealPlan._();

  factory MealPlan.fromJson(Map<String, dynamic> json) => _$MealPlanFromJson(json);

  String? recipeIdFor(String day, String slot) => days[day]?[slot];

  /// Returns a copy with `days[day][slot]` set to [recipeId] (or cleared if
  /// null), leaving every other assignment untouched.
  MealPlan withAssignment(String day, String slot, String? recipeId) {
    final newDays = <String, Map<String, String?>>{
      for (final entry in days.entries) entry.key: Map<String, String?>.from(entry.value),
    };
    final slotMap = Map<String, String?>.from(newDays[day] ?? const <String, String?>{});
    slotMap[slot] = recipeId;
    newDays[day] = slotMap;
    return copyWith(days: newDays);
  }
}

/// Week-related helpers shared by the providers and screens: the canonical
/// weekday key order, and ISO-8601 week-id math (`"2026-W28"`).
class MealPlanWeek {
  const MealPlanWeek._();

  static const List<String> weekdayKeys = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

  /// Midnight Monday of the week containing [date].
  static DateTime mondayOf(DateTime date) {
    final dayOnly = DateTime(date.year, date.month, date.day);
    return dayOnly.subtract(Duration(days: dayOnly.weekday - 1));
  }

  /// ISO-8601 week id for the week containing [date], e.g. `"2026-W28"`.
  ///
  /// The Thursday of a week always falls in the Gregorian year that "owns"
  /// that ISO week, so the ISO year is simply `thursday.year` — no extra
  /// year-boundary adjustment is needed.
  static String weekIdFor(DateTime date) {
    final monday = mondayOf(date);
    final thursday = monday.add(const Duration(days: 3));
    final isoYear = thursday.year;
    final firstThursday = _firstThursdayOfIsoYear(isoYear);
    final weekNumber = (thursday.difference(firstThursday).inDays / 7).floor() + 1;
    return '$isoYear-W${weekNumber.toString().padLeft(2, '0')}';
  }

  /// The Thursday of ISO week 1, i.e. the Thursday of the week containing
  /// January 4th (per the ISO 8601 definition of week 1).
  static DateTime _firstThursdayOfIsoYear(int year) {
    final jan4 = DateTime(year, 1, 4);
    return mondayOf(jan4).add(const Duration(days: 3));
  }
}
