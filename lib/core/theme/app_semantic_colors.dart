import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic colors Material 3's [ColorScheme] doesn't cover natively —
/// success/warning states, income vs. expense, streaks, and XP —
/// registered as a [ThemeExtension] so they animate/interpolate with theme
/// changes like every other themed color.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successTint,
    required this.warning,
    required this.warningTint,
    required this.income,
    required this.expense,
    required this.expenseTint,
    required this.streakFlame,
    required this.streakFlameTint,
    required this.xpGold,
    required this.xpGoldTint,
    required this.categoryPurple,
    required this.categoryPurpleTint,
    required this.categoryBlue,
    required this.categoryBlueTint,
    required this.categoryPink,
    required this.categoryPinkTint,
    required this.categoryTeal,
    required this.categoryTealTint,
  });

  final Color success;
  final Color successTint;
  final Color warning;
  final Color warningTint;
  final Color income;
  final Color expense;
  final Color expenseTint;
  final Color streakFlame;
  final Color streakFlameTint;
  final Color xpGold;
  final Color xpGoldTint;
  final Color categoryPurple;
  final Color categoryPurpleTint;
  final Color categoryBlue;
  final Color categoryBlueTint;
  final Color categoryPink;
  final Color categoryPinkTint;
  final Color categoryTeal;
  final Color categoryTealTint;

  static const AppSemanticColors light = AppSemanticColors(
    success: AppColors.success,
    successTint: AppColors.successTint,
    warning: AppColors.warning,
    warningTint: AppColors.warningTint,
    income: AppColors.income,
    expense: AppColors.expense,
    expenseTint: AppColors.expenseTint,
    streakFlame: AppColors.streakFlame,
    streakFlameTint: AppColors.streakFlameTint,
    xpGold: AppColors.xpGold,
    xpGoldTint: AppColors.xpGoldTint,
    categoryPurple: AppColors.categoryPurple,
    categoryPurpleTint: AppColors.categoryPurpleTint,
    categoryBlue: AppColors.categoryBlue,
    categoryBlueTint: AppColors.categoryBlueTint,
    categoryPink: AppColors.categoryPink,
    categoryPinkTint: AppColors.categoryPinkTint,
    categoryTeal: AppColors.categoryTeal,
    categoryTealTint: AppColors.categoryTealTint,
  );

  static final AppSemanticColors dark = AppSemanticColors(
    success: AppColors.success,
    successTint: AppColors.success.withValues(alpha: 0.16),
    warning: AppColors.warning,
    warningTint: AppColors.warning.withValues(alpha: 0.16),
    income: AppColors.income,
    expense: AppColors.expense,
    expenseTint: AppColors.expense.withValues(alpha: 0.16),
    streakFlame: AppColors.streakFlame,
    streakFlameTint: AppColors.streakFlame.withValues(alpha: 0.18),
    xpGold: AppColors.xpGold,
    xpGoldTint: AppColors.xpGold.withValues(alpha: 0.18),
    categoryPurple: AppColors.categoryPurple,
    categoryPurpleTint: AppColors.categoryPurple.withValues(alpha: 0.18),
    categoryBlue: AppColors.categoryBlue,
    categoryBlueTint: AppColors.categoryBlue.withValues(alpha: 0.18),
    categoryPink: AppColors.categoryPink,
    categoryPinkTint: AppColors.categoryPink.withValues(alpha: 0.18),
    categoryTeal: AppColors.categoryTeal,
    categoryTealTint: AppColors.categoryTeal.withValues(alpha: 0.18),
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successTint,
    Color? warning,
    Color? warningTint,
    Color? income,
    Color? expense,
    Color? expenseTint,
    Color? streakFlame,
    Color? streakFlameTint,
    Color? xpGold,
    Color? xpGoldTint,
    Color? categoryPurple,
    Color? categoryPurpleTint,
    Color? categoryBlue,
    Color? categoryBlueTint,
    Color? categoryPink,
    Color? categoryPinkTint,
    Color? categoryTeal,
    Color? categoryTealTint,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      successTint: successTint ?? this.successTint,
      warning: warning ?? this.warning,
      warningTint: warningTint ?? this.warningTint,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      expenseTint: expenseTint ?? this.expenseTint,
      streakFlame: streakFlame ?? this.streakFlame,
      streakFlameTint: streakFlameTint ?? this.streakFlameTint,
      xpGold: xpGold ?? this.xpGold,
      xpGoldTint: xpGoldTint ?? this.xpGoldTint,
      categoryPurple: categoryPurple ?? this.categoryPurple,
      categoryPurpleTint: categoryPurpleTint ?? this.categoryPurpleTint,
      categoryBlue: categoryBlue ?? this.categoryBlue,
      categoryBlueTint: categoryBlueTint ?? this.categoryBlueTint,
      categoryPink: categoryPink ?? this.categoryPink,
      categoryPinkTint: categoryPinkTint ?? this.categoryPinkTint,
      categoryTeal: categoryTeal ?? this.categoryTeal,
      categoryTealTint: categoryTealTint ?? this.categoryTealTint,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppSemanticColors(
      success: l(success, other.success),
      successTint: l(successTint, other.successTint),
      warning: l(warning, other.warning),
      warningTint: l(warningTint, other.warningTint),
      income: l(income, other.income),
      expense: l(expense, other.expense),
      expenseTint: l(expenseTint, other.expenseTint),
      streakFlame: l(streakFlame, other.streakFlame),
      streakFlameTint: l(streakFlameTint, other.streakFlameTint),
      xpGold: l(xpGold, other.xpGold),
      xpGoldTint: l(xpGoldTint, other.xpGoldTint),
      categoryPurple: l(categoryPurple, other.categoryPurple),
      categoryPurpleTint: l(categoryPurpleTint, other.categoryPurpleTint),
      categoryBlue: l(categoryBlue, other.categoryBlue),
      categoryBlueTint: l(categoryBlueTint, other.categoryBlueTint),
      categoryPink: l(categoryPink, other.categoryPink),
      categoryPinkTint: l(categoryPinkTint, other.categoryPinkTint),
      categoryTeal: l(categoryTeal, other.categoryTeal),
      categoryTealTint: l(categoryTealTint, other.categoryTealTint),
    );
  }
}

extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semanticColors => Theme.of(this).extension<AppSemanticColors>()!;
}
