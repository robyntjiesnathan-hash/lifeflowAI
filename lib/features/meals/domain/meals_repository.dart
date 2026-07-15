import 'meal_plan.dart';
import 'recipe.dart';
import 'shopping_list_item.dart';

abstract class MealsRepository {
  /// Emits the plan for [weekId], or an empty [MealPlan] if the user hasn't
  /// assigned anything for that week yet — never null, so callers can always
  /// read/mutate `days` without a separate "does it exist" branch.
  Stream<MealPlan> watchMealPlan(String uid, String weekId);

  Future<void> saveMealPlan(String uid, MealPlan mealPlan);

  Stream<List<Recipe>> watchRecipes(String uid);

  Future<Recipe> createRecipe(String uid, Recipe recipe);

  Future<void> deleteRecipe(String uid, String recipeId);

  Stream<List<ShoppingListItem>> watchShoppingList(String uid);

  Future<void> addShoppingListItem(String uid, ShoppingListItem item);

  Future<void> toggleShoppingListItem(String uid, String itemId, bool isChecked);

  Future<void> deleteShoppingListItem(String uid, String itemId);

  /// Aggregates ingredients from every recipe assigned in [weekId]'s plan
  /// into shopping list items, summing quantities where name+unit match, and
  /// appends them to the user's shopping list.
  Future<void> generateShoppingListFromMealPlan(String uid, String weekId);
}
