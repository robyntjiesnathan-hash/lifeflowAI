import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/meal_plan.dart';
import '../domain/meals_repository.dart';
import '../domain/recipe.dart';
import '../domain/shopping_list_item.dart';

class FirestoreMealsRepository implements MealsRepository {
  FirestoreMealsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _mealPlansCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.mealPlans);

  CollectionReference<Map<String, dynamic>> _recipesCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.recipes);

  CollectionReference<Map<String, dynamic>> _shoppingListCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.shoppingList);

  @override
  Stream<MealPlan> watchMealPlan(String uid, String weekId) {
    return _mealPlansCol(uid).doc(weekId).snapshots().map((snap) {
      final data = snap.data();
      if (!snap.exists || data == null) return MealPlan(id: weekId);
      return MealPlan.fromJson({...data, 'id': snap.id});
    });
  }

  @override
  Future<void> saveMealPlan(String uid, MealPlan mealPlan) =>
      _mealPlansCol(uid).doc(mealPlan.id).set(mealPlan.toJson()..remove('id'), SetOptions(merge: true));

  @override
  Stream<List<Recipe>> watchRecipes(String uid) {
    return _recipesCol(uid).orderBy('title').snapshots().map(
          (snap) => snap.docs.map((d) => Recipe.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<Recipe> createRecipe(String uid, Recipe recipe) async {
    final doc = _recipesCol(uid).doc();
    final withId = recipe.copyWith(id: doc.id);
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> deleteRecipe(String uid, String recipeId) => _recipesCol(uid).doc(recipeId).delete();

  @override
  Stream<List<ShoppingListItem>> watchShoppingList(String uid) {
    return _shoppingListCol(uid).orderBy('addedAt', descending: true).snapshots().map(
          (snap) => snap.docs.map((d) => ShoppingListItem.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<void> addShoppingListItem(String uid, ShoppingListItem item) async {
    final doc = item.id.isEmpty ? _shoppingListCol(uid).doc() : _shoppingListCol(uid).doc(item.id);
    final withId = item.copyWith(id: doc.id, addedAt: item.addedAt ?? DateTime.now());
    await doc.set(withId.toJson()..remove('id'));
  }

  @override
  Future<void> toggleShoppingListItem(String uid, String itemId, bool isChecked) =>
      _shoppingListCol(uid).doc(itemId).update({'isChecked': isChecked});

  @override
  Future<void> deleteShoppingListItem(String uid, String itemId) => _shoppingListCol(uid).doc(itemId).delete();

  @override
  Future<void> generateShoppingListFromMealPlan(String uid, String weekId) async {
    final planSnap = await _mealPlansCol(uid).doc(weekId).get();
    final planData = planSnap.data();
    if (!planSnap.exists || planData == null) return;
    final mealPlan = MealPlan.fromJson({...planData, 'id': weekId});

    final recipeIds = <String>{
      for (final slots in mealPlan.days.values) for (final recipeId in slots.values) ?recipeId,
    };
    if (recipeIds.isEmpty) return;

    final recipes = <Recipe>[];
    for (final id in recipeIds) {
      final doc = await _recipesCol(uid).doc(id).get();
      final data = doc.data();
      if (doc.exists && data != null) recipes.add(Recipe.fromJson({...data, 'id': doc.id}));
    }

    final aggregated = aggregateIngredients(recipes);
    if (aggregated.isEmpty) return;

    final batch = _firestore.batch();
    for (final ingredient in aggregated) {
      final doc = _shoppingListCol(uid).doc();
      final item = ShoppingListItem(
        id: doc.id,
        name: ingredient.name,
        quantity: ingredient.quantity,
        unit: ingredient.unit,
        sourceMealPlanId: weekId,
        addedAt: DateTime.now(),
      );
      batch.set(doc, item.toJson()..remove('id'));
    }
    await batch.commit();
  }
}
