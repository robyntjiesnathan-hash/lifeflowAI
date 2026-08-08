import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/fake_meals_repository.dart';
import '../data/firestore_meals_repository.dart';
import '../domain/curated_recipes.dart';
import '../domain/meal_plan.dart';
import '../domain/meals_repository.dart';
import '../domain/recipe.dart';
import '../domain/shopping_list_item.dart';

part 'meals_providers.g.dart';

@Riverpod(keepAlive: true)
MealsRepository mealsRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeMealsRepository();
  return FirestoreMealsRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

/// The ISO-8601 id (e.g. `"2026-W28"`) of the week containing "now". Kept as
/// its own provider so screens/controllers reference a single canonical
/// value rather than each recomputing `DateTime.now()` independently.
@riverpod
String currentWeekId(Ref ref) => MealPlanWeek.weekIdFor(DateTime.now());

@riverpod
Stream<MealPlan> currentWeekMealPlan(Ref ref) {
  final uid = _currentUid(ref);
  final weekId = ref.watch(currentWeekIdProvider);
  if (uid == null) return Stream.value(MealPlan(id: weekId));
  return ref.watch(mealsRepositoryProvider).watchMealPlan(uid, weekId);
}

/// The user's own recipes, or — while they haven't created any yet — the
/// static [curatedRecipes] catalog (each tagged `'suggested'`) so the
/// planner and recipe picker never show a completely empty list.
@riverpod
Stream<List<Recipe>> recipes(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(curatedRecipes);
  return ref.watch(mealsRepositoryProvider).watchRecipes(uid).map((list) => list.isEmpty ? curatedRecipes : list);
}

@riverpod
Stream<List<ShoppingListItem>> shoppingList(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(mealsRepositoryProvider).watchShoppingList(uid);
}

@Riverpod(keepAlive: true)
class MealsController extends _$MealsController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Future<void> assignRecipeToSlot({
    required String weekId,
    required String day,
    required String slot,
    required String? recipeId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(mealsRepositoryProvider);
      final current = await repo.watchMealPlan(_uid, weekId).first;
      await repo.saveMealPlan(_uid, current.withAssignment(day, slot, recipeId));
    });
  }

  /// Persists [recipe] to the user's own collection, returning the saved
  /// copy (with a real id) — used both for "new recipe" forms and for
  /// promoting a tapped suggested/curated recipe into a real one before it
  /// can be assigned to a meal slot.
  Future<Recipe?> createRecipe(Recipe recipe) async {
    state = const AsyncLoading();
    Recipe? created;
    state = await AsyncValue.guard(() async {
      created = await ref.read(mealsRepositoryProvider).createRecipe(_uid, recipe);
    });
    return created;
  }

  Future<void> deleteRecipe(String recipeId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(mealsRepositoryProvider).deleteRecipe(_uid, recipeId));
  }

  Future<void> generateShoppingList(String weekId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(mealsRepositoryProvider).generateShoppingListFromMealPlan(_uid, weekId),
    );
  }

  Future<void> addShoppingListItem(ShoppingListItem item) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(mealsRepositoryProvider).addShoppingListItem(_uid, item));
  }

  Future<void> toggleShoppingListItem(String itemId, bool isChecked) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(mealsRepositoryProvider).toggleShoppingListItem(_uid, itemId, isChecked),
    );
  }

  Future<void> deleteShoppingListItem(String itemId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(mealsRepositoryProvider).deleteShoppingListItem(_uid, itemId));
  }
}
