import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../application/meals_providers.dart';
import '../../domain/recipe.dart';
import 'meal_slot_card.dart';

/// Opens a bottom sheet listing available recipes (the user's own, or the
/// suggested catalog if they have none yet) so the user can assign one to
/// `days[day][slot]` in the current week's meal plan, or clear the slot.
Future<void> showRecipePickerSheet(
  BuildContext context, {
  required String weekId,
  required String day,
  required String slot,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => RecipePickerSheet(weekId: weekId, day: day, slot: slot),
  );
}

class RecipePickerSheet extends ConsumerWidget {
  const RecipePickerSheet({super.key, required this.weekId, required this.day, required this.slot});

  final String weekId;
  final String day;
  final String slot;

  Future<void> _selectRecipe(BuildContext context, WidgetRef ref, Recipe recipe) async {
    final controller = ref.read(mealsControllerProvider.notifier);
    var recipeId = recipe.id;
    if (recipe.isSuggested) {
      final persisted = await controller.createRecipe(
        recipe.copyWith(id: '', tags: recipe.tags.where((t) => t != 'suggested').toList()),
      );
      if (persisted == null) return;
      recipeId = persisted.id;
    }
    await controller.assignRecipeToSlot(weekId: weekId, day: day, slot: slot, recipeId: recipeId);
    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> _clearSlot(BuildContext context, WidgetRef ref) async {
    await ref
        .read(mealsControllerProvider.notifier)
        .assignRecipeToSlot(weekId: weekId, day: day, slot: slot, recipeId: null);
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipesProvider);
    final semantic = context.semanticColors;
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Choose a recipe', style: theme.textTheme.titleLarge),
                TextButton(onPressed: () => _clearSlot(context, ref), child: const Text('Clear')),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
              child: recipesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Text('$error')),
                data: (recipes) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: recipes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    final color = recipeCategoryColor(recipe.category, semantic);
                    return AppCard(
                      onTap: () => _selectRecipe(context, ref, recipe),
                      child: Row(
                        children: [
                          CategoryIconChip(icon: recipe.category.icon, color: color, tint: color.withValues(alpha: 0.14)),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        recipe.title,
                                        style: theme.textTheme.titleMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (recipe.isSuggested) ...[
                                      const SizedBox(width: AppSpacing.xs),
                                      const BadgeChip(label: 'Suggested', icon: Icons.auto_awesome_rounded),
                                    ],
                                  ],
                                ),
                                Text(recipeMacroLabel(recipe), style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
