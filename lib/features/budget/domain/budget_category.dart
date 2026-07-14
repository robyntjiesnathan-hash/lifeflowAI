import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_category.freezed.dart';
part 'budget_category.g.dart';

/// Small catalog mapping a stored string key to an [IconData] so Firestore
/// docs never store platform-specific icon codepoints directly. Mirrors
/// `HabitIconKey` in the habits feature.
enum BudgetCategoryIconKey {
  housing(Icons.house_rounded),
  food(Icons.restaurant_rounded),
  transport(Icons.directions_car_filled_rounded),
  entertainment(Icons.local_movies_rounded),
  shopping(Icons.shopping_bag_rounded),
  health(Icons.favorite_rounded),
  other(Icons.category_rounded);

  const BudgetCategoryIconKey(this.icon);
  final IconData icon;
}

/// A single spending category, embedded as a list entry on [BudgetProfile]
/// (`users/{uid}/budget/profile.categories`) rather than stored as its own
/// Firestore collection.
@freezed
abstract class BudgetCategory with _$BudgetCategory {
  const factory BudgetCategory({
    required String id,
    required String name,
    @Default(BudgetCategoryIconKey.other) BudgetCategoryIconKey iconKey,
    @Default('#8B5CF6') String colorHex,
    @Default(0) num monthlyLimit,
  }) = _BudgetCategory;

  const BudgetCategory._();

  factory BudgetCategory.fromJson(Map<String, dynamic> json) => _$BudgetCategoryFromJson(json);

  Color get color => Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
}
