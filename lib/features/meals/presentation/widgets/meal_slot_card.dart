import 'package:flutter/material.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../domain/meal_plan.dart';
import '../../domain/recipe.dart';

/// Maps a recipe category to a semantic accent color, shared by the meal
/// slot card, recipe picker, and recipe detail screen.
Color recipeCategoryColor(RecipeCategory category, AppSemanticColors semantic) {
  switch (category) {
    case RecipeCategory.healthy:
      return semantic.success;
    case RecipeCategory.budget:
      return semantic.warning;
    case RecipeCategory.quick:
      return semantic.categoryBlue;
    case RecipeCategory.general:
      return semantic.categoryPurple;
  }
}

String recipeMacroLabel(Recipe recipe) {
  final parts = <String>[
    if (recipe.calories != null) '${recipe.calories} kcal',
    if (recipe.proteinGrams != null) '${recipe.proteinGrams}g protein',
  ];
  return parts.isEmpty ? '${recipe.prepMinutes} min · ${recipe.servings} servings' : parts.join(' · ');
}

/// A single meal-slot row on the Meal Planner screen: slot label, assigned
/// recipe (or a prompt to add one), macro tag, and a colored icon
/// thumbnail — mirrors the reference design's "Breakfast / Lunch" cards.
class MealSlotCard extends StatelessWidget {
  const MealSlotCard({super.key, required this.slot, required this.recipe, required this.onAssign, this.onViewRecipe});

  final MealSlot slot;
  final Recipe? recipe;
  final VoidCallback onAssign;
  final VoidCallback? onViewRecipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final recipe = this.recipe;
    final color = recipe == null ? theme.colorScheme.primary : recipeCategoryColor(recipe.category, semantic);

    return AppCard(
      onTap: recipe == null ? onAssign : onViewRecipe,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot.label, style: theme.textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(recipe?.title ?? 'Tap to add a recipe', style: theme.textTheme.titleMedium),
                if (recipe != null) ...[
                  const SizedBox(height: 4),
                  Text(recipeMacroLabel(recipe), style: theme.textTheme.bodySmall),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          CategoryIconChip(icon: recipe?.category.icon ?? slot.icon, color: color, tint: color.withValues(alpha: 0.14)),
          IconButton(
            icon: Icon(recipe == null ? Icons.add_circle_outline_rounded : Icons.swap_horiz_rounded, size: 20),
            color: theme.colorScheme.primary,
            onPressed: onAssign,
          ),
        ],
      ),
    );
  }
}
