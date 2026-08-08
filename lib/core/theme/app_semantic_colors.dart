import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic colors Material 3's [ColorScheme] doesn't cover natively —
/// success/warning/error/info, income vs. expense, streaks, and XP —
/// registered as a [ThemeExtension] so they animate/interpolate with theme
/// changes like every other themed color.
///
/// Dark mode is its own hand-picked set of brightened accents (Meadow Glow,
/// Ember Glow, Moon Violet, …), not the light-mode colors reused at reduced
/// alpha over a dark background.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successTint,
    required this.warning,
    required this.warningTint,
    required this.error,
    required this.errorTint,
    required this.info,
    required this.infoTint,
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
  final Color error;
  final Color errorTint;
  final Color info;
  final Color infoTint;
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
    error: AppColors.error,
    errorTint: AppColors.errorTint,
    info: AppColors.info,
    infoTint: AppColors.infoTint,
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
    success: AppColors.darkSuccess,
    successTint: AppColors.darkSuccess.withValues(alpha: 0.16),
    warning: AppColors.darkWarning,
    warningTint: AppColors.darkWarning.withValues(alpha: 0.16),
    error: AppColors.darkError,
    errorTint: AppColors.darkError.withValues(alpha: 0.16),
    info: AppColors.darkInfo,
    infoTint: AppColors.darkInfo.withValues(alpha: 0.16),
    income: AppColors.darkSuccess,
    expense: AppColors.darkError,
    expenseTint: AppColors.darkError.withValues(alpha: 0.16),
    streakFlame: AppColors.darkStreakFlame,
    streakFlameTint: AppColors.darkStreakFlame.withValues(alpha: 0.18),
    xpGold: AppColors.darkXpGold,
    xpGoldTint: AppColors.darkXpGold.withValues(alpha: 0.18),
    categoryPurple: AppColors.darkCategoryPurple,
    categoryPurpleTint: AppColors.darkCategoryPurple.withValues(alpha: 0.18),
    categoryBlue: AppColors.darkCategoryBlue,
    categoryBlueTint: AppColors.darkCategoryBlue.withValues(alpha: 0.18),
    categoryPink: AppColors.darkCategoryPink,
    categoryPinkTint: AppColors.darkCategoryPink.withValues(alpha: 0.18),
    categoryTeal: AppColors.darkCategoryTeal,
    categoryTealTint: AppColors.darkCategoryTeal.withValues(alpha: 0.18),
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successTint,
    Color? warning,
    Color? warningTint,
    Color? error,
    Color? errorTint,
    Color? info,
    Color? infoTint,
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
      error: error ?? this.error,
      errorTint: errorTint ?? this.errorTint,
      info: info ?? this.info,
      infoTint: infoTint ?? this.infoTint,
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
      error: l(error, other.error),
      errorTint: l(errorTint, other.errorTint),
      info: l(info, other.info),
      infoTint: l(infoTint, other.infoTint),
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
