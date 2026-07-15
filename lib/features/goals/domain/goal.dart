import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/theme/app_colors.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalStatus { active, completed, abandoned }

enum GoalProgressMode { milestoneBased, manual }

/// Fixed category catalog for goals — unlike habits (freeform icon picker),
/// each category carries its own icon + saturated/tint color pair so goal
/// cards get a consistent look without per-goal color pickers.
enum GoalCategory {
  health(Icons.directions_run_rounded, AppColors.streakFlame, AppColors.streakFlameTint),
  career(Icons.work_rounded, AppColors.categoryTeal, AppColors.categoryTealTint),
  finance(Icons.attach_money_rounded, AppColors.success, AppColors.successTint),
  personal(Icons.menu_book_rounded, AppColors.categoryPurple, AppColors.categoryPurpleTint),
  learning(Icons.school_rounded, AppColors.categoryBlue, AppColors.categoryBlueTint),
  other(Icons.flag_rounded, AppColors.categoryPink, AppColors.categoryPinkTint);

  const GoalCategory(this.icon, this.color, this.tint);
  final IconData icon;
  final Color color;
  final Color tint;
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
abstract class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String title,
    @Default('') String description,
    @Default(GoalCategory.other) GoalCategory category,
    @_TimestampConverter() DateTime? targetDate,
    @Default(GoalStatus.active) GoalStatus status,
    @Default(GoalProgressMode.milestoneBased) GoalProgressMode progressMode,
    num? manualProgressPercent,
    @Default(0) num progressPercent,
    @_TimestampConverter() DateTime? createdAt,
    @_TimestampConverter() DateTime? updatedAt,
    @_TimestampConverter() DateTime? completedAt,
  }) = _Goal;

  const Goal._();

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  /// 0.0 - 1.0, clamped for safe use with progress widgets.
  double get progressFraction => (progressPercent / 100).clamp(0.0, 1.0).toDouble();
}
