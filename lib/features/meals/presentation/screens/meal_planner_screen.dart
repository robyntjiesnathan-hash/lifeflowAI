import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/week_day_strip.dart';
import '../../application/meals_providers.dart';
import '../../domain/meal_plan.dart';
import '../../domain/recipe.dart';
import '../widgets/meal_slot_card.dart';
import '../widgets/recipe_picker_sheet.dart';

class MealPlannerScreen extends ConsumerStatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  ConsumerState<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends ConsumerState<MealPlannerScreen> {
  late int _selectedDayIndex = DateTime.now().weekday - 1;

  @override
  Widget build(BuildContext context) {
    final mealPlanAsync = ref.watch(currentWeekMealPlanProvider);
    final recipesAsync = ref.watch(recipesProvider);
    final weekId = ref.watch(currentWeekIdProvider);
    final selectedDayKey = MealPlanWeek.weekdayKeys[_selectedDayIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        // "This Week" used to sit here as a TextButton with an empty
        // onPressed — a tap target that visibly did nothing. There's no
        // week-navigation concept anywhere in the data layer (weekId is
        // always DateTime.now()'s week), so removed rather than faked.
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.push(RoutePaths.mealsShoppingList),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentWeekMealPlanProvider);
          ref.invalidate(recipesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 100),
          children: [
            WeekDayStrip(
              days: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
              selectedIndex: _selectedDayIndex,
              onSelect: (index) => setState(() => _selectedDayIndex = index),
            ),
            const SizedBox(height: AppSpacing.lg),
            mealPlanAsync.when(
              loading: () => const Column(children: [LoadingCardSkeleton(), LoadingCardSkeleton()]),
              error: (error, stack) => Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Text('$error')),
              data: (mealPlan) {
                final recipes = recipesAsync.value ?? const <Recipe>[];
                return Column(
                  children: [
                    for (final slot in MealSlot.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: MealSlotCard(
                          slot: slot,
                          recipe: _recipeFor(mealPlan, recipes, selectedDayKey, slot.key),
                          onAssign: () => showRecipePickerSheet(context, weekId: weekId, day: selectedDayKey, slot: slot.key),
                          onViewRecipe: () {
                            final recipe = _recipeFor(mealPlan, recipes, selectedDayKey, slot.key);
                            if (recipe != null) context.push(RoutePaths.mealRecipe(recipe.id));
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            GradientPillButton(
              label: 'Shopping List',
              icon: Icons.shopping_cart_rounded,
              onPressed: () => context.push(RoutePaths.mealsShoppingList),
            ),
          ],
        ),
      ),
    );
  }

  Recipe? _recipeFor(MealPlan plan, List<Recipe> recipes, String day, String slot) {
    final recipeId = plan.recipeIdFor(day, slot);
    if (recipeId == null) return null;
    for (final recipe in recipes) {
      if (recipe.id == recipeId) return recipe;
    }
    return null;
  }
}
