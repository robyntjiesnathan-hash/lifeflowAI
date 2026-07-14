import 'package:freezed_annotation/freezed_annotation.dart';

import 'budget_category.dart';

part 'budget_profile.freezed.dart';
part 'budget_profile.g.dart';

/// Single per-user settings document at `users/{uid}/budget/profile`.
@freezed
abstract class BudgetProfile with _$BudgetProfile {
  const factory BudgetProfile({
    @Default('USD') String currency,
    @Default(0) num monthlyIncomeTarget,
    @Default(2000) num monthlyBudgetTarget,
    @Default(<BudgetCategory>[]) List<BudgetCategory> categories,
  }) = _BudgetProfile;

  const BudgetProfile._();

  factory BudgetProfile.fromJson(Map<String, dynamic> json) => _$BudgetProfileFromJson(json);

  /// Sensible starting point for a brand-new user (or when in fake-auth mode
  /// before any profile has been saved), matching the categories shown in
  /// the reference design's Budget panel.
  factory BudgetProfile.defaultProfile() => const BudgetProfile(
        currency: 'USD',
        monthlyIncomeTarget: 4000,
        monthlyBudgetTarget: 2000,
        categories: [
          BudgetCategory(
            id: 'housing',
            name: 'Housing',
            iconKey: BudgetCategoryIconKey.housing,
            colorHex: '#EC4899',
            monthlyLimit: 800,
          ),
          BudgetCategory(
            id: 'food',
            name: 'Food',
            iconKey: BudgetCategoryIconKey.food,
            colorHex: '#F59E0B',
            monthlyLimit: 500,
          ),
          BudgetCategory(
            id: 'transport',
            name: 'Transport',
            iconKey: BudgetCategoryIconKey.transport,
            colorHex: '#3B82F6',
            monthlyLimit: 250,
          ),
          BudgetCategory(
            id: 'entertainment',
            name: 'Entertainment',
            iconKey: BudgetCategoryIconKey.entertainment,
            colorHex: '#EF4444',
            monthlyLimit: 150,
          ),
          BudgetCategory(
            id: 'shopping',
            name: 'Shopping',
            iconKey: BudgetCategoryIconKey.shopping,
            colorHex: '#8B5CF6',
            monthlyLimit: 300,
          ),
        ],
      );
}
