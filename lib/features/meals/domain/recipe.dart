import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

/// Broad recipe categories, mapped to an icon so recipe/meal-slot cards can
/// show a colored thumbnail chip instead of network food photography.
enum RecipeCategory {
  general(Icons.restaurant_rounded),
  healthy(Icons.eco_rounded),
  budget(Icons.savings_rounded),
  quick(Icons.bolt_rounded);

  const RecipeCategory(this.icon);
  final IconData icon;
}

@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    @Default(1) double quantity,
    @Default('') String unit,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
}

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String title,
    @Default(15) int prepMinutes,
    @Default(2) int servings,
    @Default(RecipeCategory.general) RecipeCategory category,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
    @Default(<String>[]) List<String> instructions,
    @Default(<String>[]) List<String> tags,
    int? calories,
    int? proteinGrams,
  }) = _Recipe;

  const Recipe._();

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  /// Curated/suggested-catalog recipes are tagged 'suggested' rather than
  /// modeled with a separate field, so the picker can show a "Suggested"
  /// badge and know to persist a real copy before it can be assigned to a
  /// meal slot.
  bool get isSuggested => tags.contains('suggested');
}

/// Sums ingredient quantities across [recipes] whenever both the (trimmed,
/// lowercased) name and unit match, so e.g. two recipes both calling for
/// "garlic / cloves" collapse into a single shopping list entry. Shared by
/// the Firestore and fake meals repositories' shopping-list generation.
List<Ingredient> aggregateIngredients(List<Recipe> recipes) {
  final aggregated = <String, Ingredient>{};
  for (final recipe in recipes) {
    for (final ingredient in recipe.ingredients) {
      final key = '${ingredient.name.trim().toLowerCase()}|${ingredient.unit.trim().toLowerCase()}';
      final existing = aggregated[key];
      aggregated[key] =
          existing == null ? ingredient : existing.copyWith(quantity: existing.quantity + ingredient.quantity);
    }
  }
  return aggregated.values.toList();
}
