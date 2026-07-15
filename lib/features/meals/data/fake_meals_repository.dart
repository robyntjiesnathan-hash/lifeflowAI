import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/meal_plan.dart';
import '../domain/meals_repository.dart';
import '../domain/recipe.dart';
import '../domain/shopping_list_item.dart';

/// In-memory meals store for fake-auth mode, keyed by uid so each fake
/// session is isolated but persists for the app's lifetime.
class FakeMealsRepository implements MealsRepository {
  static final Map<String, Map<String, MealPlan>> _mealPlans = {}; // uid -> weekId -> plan
  static final Map<String, List<Recipe>> _recipes = {};
  static final Map<String, List<ShoppingListItem>> _shoppingList = {};

  static final Map<String, Map<String, StreamController<MealPlan>>> _mealPlanControllers = {};
  static final Map<String, StreamController<List<Recipe>>> _recipeControllers = {};
  static final Map<String, StreamController<List<ShoppingListItem>>> _shoppingControllers = {};

  final _uuid = const Uuid();

  StreamController<MealPlan> _mealPlanControllerFor(String uid, String weekId) => _mealPlanControllers
      .putIfAbsent(uid, () => {})
      .putIfAbsent(weekId, () => StreamController<MealPlan>.broadcast());

  void _emitMealPlan(String uid, String weekId) {
    final plan = _mealPlans[uid]?[weekId] ?? MealPlan(id: weekId);
    _mealPlanControllerFor(uid, weekId).add(plan);
  }

  StreamController<List<Recipe>> _recipeControllerFor(String uid) =>
      _recipeControllers.putIfAbsent(uid, () => StreamController<List<Recipe>>.broadcast());

  void _emitRecipes(String uid) => _recipeControllerFor(uid).add(List.unmodifiable(_recipes[uid] ?? const []));

  StreamController<List<ShoppingListItem>> _shoppingControllerFor(String uid) =>
      _shoppingControllers.putIfAbsent(uid, () => StreamController<List<ShoppingListItem>>.broadcast());

  void _emitShopping(String uid) =>
      _shoppingControllerFor(uid).add(List.unmodifiable(_shoppingList[uid] ?? const []));

  @override
  Stream<MealPlan> watchMealPlan(String uid, String weekId) {
    final controller = _mealPlanControllerFor(uid, weekId);
    Future.microtask(() => _emitMealPlan(uid, weekId));
    return controller.stream;
  }

  @override
  Future<void> saveMealPlan(String uid, MealPlan mealPlan) async {
    _mealPlans.putIfAbsent(uid, () => {})[mealPlan.id] = mealPlan;
    _emitMealPlan(uid, mealPlan.id);
  }

  @override
  Stream<List<Recipe>> watchRecipes(String uid) {
    final controller = _recipeControllerFor(uid);
    Future.microtask(() => _emitRecipes(uid));
    return controller.stream;
  }

  @override
  Future<Recipe> createRecipe(String uid, Recipe recipe) async {
    final withId = recipe.copyWith(id: recipe.id.isEmpty ? _uuid.v4() : recipe.id);
    _recipes.putIfAbsent(uid, () => []).add(withId);
    _emitRecipes(uid);
    return withId;
  }

  @override
  Future<void> deleteRecipe(String uid, String recipeId) async {
    _recipes[uid]?.removeWhere((r) => r.id == recipeId);
    _emitRecipes(uid);
  }

  @override
  Stream<List<ShoppingListItem>> watchShoppingList(String uid) {
    final controller = _shoppingControllerFor(uid);
    Future.microtask(() => _emitShopping(uid));
    return controller.stream;
  }

  @override
  Future<void> addShoppingListItem(String uid, ShoppingListItem item) async {
    final withId = item.copyWith(
      id: item.id.isEmpty ? _uuid.v4() : item.id,
      addedAt: item.addedAt ?? DateTime.now(),
    );
    _shoppingList.putIfAbsent(uid, () => []).insert(0, withId);
    _emitShopping(uid);
  }

  @override
  Future<void> toggleShoppingListItem(String uid, String itemId, bool isChecked) async {
    final list = _shoppingList[uid];
    if (list == null) return;
    final index = list.indexWhere((i) => i.id == itemId);
    if (index == -1) return;
    list[index] = list[index].copyWith(isChecked: isChecked);
    _emitShopping(uid);
  }

  @override
  Future<void> deleteShoppingListItem(String uid, String itemId) async {
    _shoppingList[uid]?.removeWhere((i) => i.id == itemId);
    _emitShopping(uid);
  }

  @override
  Future<void> generateShoppingListFromMealPlan(String uid, String weekId) async {
    final plan = _mealPlans[uid]?[weekId];
    if (plan == null) return;

    final recipeIds = <String>{
      for (final slots in plan.days.values) for (final recipeId in slots.values) ?recipeId,
    };
    if (recipeIds.isEmpty) return;

    final catalog = _recipes[uid] ?? const <Recipe>[];
    final recipes = [for (final id in recipeIds) ...catalog.where((r) => r.id == id)];

    final aggregated = aggregateIngredients(recipes);
    if (aggregated.isEmpty) return;

    final list = _shoppingList.putIfAbsent(uid, () => []);
    for (final ingredient in aggregated) {
      list.insert(
        0,
        ShoppingListItem(
          id: _uuid.v4(),
          name: ingredient.name,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
          sourceMealPlanId: weekId,
          addedAt: DateTime.now(),
        ),
      );
    }
    _emitShopping(uid);
  }
}
