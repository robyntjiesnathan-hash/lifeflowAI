import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../application/meals_providers.dart';
import '../../domain/recipe.dart';
import '../widgets/meal_slot_card.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipesProvider);
    final recipes = recipesAsync.value ?? const <Recipe>[];
    final matches = recipes.where((r) => r.id == recipeId);

    if (matches.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: recipesAsync.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Center(child: Text('Recipe not found')),
      );
    }

    final recipe = matches.first;
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final color = recipeCategoryColor(recipe.category, semantic);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete recipe?',
                message: 'Remove "${recipe.title}" from your recipes.',
                confirmLabel: 'Delete',
                isDestructive: true,
              );
              if (confirmed && context.mounted) {
                await ref.read(mealsControllerProvider.notifier).deleteRecipe(recipe.id);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryIconChip(icon: recipe.category.icon, color: color, tint: color.withValues(alpha: 0.14), size: 56),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    BadgeChip(label: '${recipe.prepMinutes} min', icon: Icons.timer_outlined),
                    BadgeChip(label: '${recipe.servings} servings', icon: Icons.people_outline_rounded),
                    if (recipe.calories != null)
                      BadgeChip(label: '${recipe.calories} kcal', icon: Icons.local_fire_department_rounded),
                    if (recipe.proteinGrams != null)
                      BadgeChip(label: '${recipe.proteinGrams}g protein', icon: Icons.fitness_center_rounded),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ingredients', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                for (final ingredient in recipe.ingredients)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 6, color: theme.dividerColor),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: Text(ingredient.name, style: theme.textTheme.bodyMedium)),
                        Text(_formatQuantity(ingredient.quantity, ingredient.unit), style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Instructions', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                for (int i = 0; i < recipe.instructions.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.14)),
                          child: Text(
                            '${i + 1}',
                            style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: Text(recipe.instructions[i], style: theme.textTheme.bodyMedium)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatQuantity(double quantity, String unit) {
  final quantityLabel = quantity == quantity.roundToDouble() ? quantity.toInt().toString() : quantity.toString();
  return unit.isEmpty ? quantityLabel : '$quantityLabel $unit';
}
