// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mealsRepository)
final mealsRepositoryProvider = MealsRepositoryProvider._();

final class MealsRepositoryProvider
    extends
        $FunctionalProvider<MealsRepository, MealsRepository, MealsRepository>
    with $Provider<MealsRepository> {
  MealsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MealsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MealsRepository create(Ref ref) {
    return mealsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealsRepository>(value),
    );
  }
}

String _$mealsRepositoryHash() => r'7a6529772ad699f7cf8000b053a99f1d5de12a21';

/// The ISO-8601 id (e.g. `"2026-W28"`) of the week containing "now". Kept as
/// its own provider so screens/controllers reference a single canonical
/// value rather than each recomputing `DateTime.now()` independently.

@ProviderFor(currentWeekId)
final currentWeekIdProvider = CurrentWeekIdProvider._();

/// The ISO-8601 id (e.g. `"2026-W28"`) of the week containing "now". Kept as
/// its own provider so screens/controllers reference a single canonical
/// value rather than each recomputing `DateTime.now()` independently.

final class CurrentWeekIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// The ISO-8601 id (e.g. `"2026-W28"`) of the week containing "now". Kept as
  /// its own provider so screens/controllers reference a single canonical
  /// value rather than each recomputing `DateTime.now()` independently.
  CurrentWeekIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentWeekIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentWeekIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentWeekId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentWeekIdHash() => r'f0dd2f3a8ca22627b036272253c64d705183f68a';

@ProviderFor(currentWeekMealPlan)
final currentWeekMealPlanProvider = CurrentWeekMealPlanProvider._();

final class CurrentWeekMealPlanProvider
    extends
        $FunctionalProvider<AsyncValue<MealPlan>, MealPlan, Stream<MealPlan>>
    with $FutureModifier<MealPlan>, $StreamProvider<MealPlan> {
  CurrentWeekMealPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentWeekMealPlanProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentWeekMealPlanHash();

  @$internal
  @override
  $StreamProviderElement<MealPlan> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<MealPlan> create(Ref ref) {
    return currentWeekMealPlan(ref);
  }
}

String _$currentWeekMealPlanHash() =>
    r'd16c31a36bf43fdfee19a82c4d231b3fa9a30deb';

/// The user's own recipes, or — while they haven't created any yet — the
/// static [curatedRecipes] catalog (each tagged `'suggested'`) so the
/// planner and recipe picker never show a completely empty list.

@ProviderFor(recipes)
final recipesProvider = RecipesProvider._();

/// The user's own recipes, or — while they haven't created any yet — the
/// static [curatedRecipes] catalog (each tagged `'suggested'`) so the
/// planner and recipe picker never show a completely empty list.

final class RecipesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Recipe>>,
          List<Recipe>,
          Stream<List<Recipe>>
        >
    with $FutureModifier<List<Recipe>>, $StreamProvider<List<Recipe>> {
  /// The user's own recipes, or — while they haven't created any yet — the
  /// static [curatedRecipes] catalog (each tagged `'suggested'`) so the
  /// planner and recipe picker never show a completely empty list.
  RecipesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipesHash();

  @$internal
  @override
  $StreamProviderElement<List<Recipe>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Recipe>> create(Ref ref) {
    return recipes(ref);
  }
}

String _$recipesHash() => r'37fccb6a5f25890d091cb3345ed332a71e4c9b39';

@ProviderFor(shoppingList)
final shoppingListProvider = ShoppingListProvider._();

final class ShoppingListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShoppingListItem>>,
          List<ShoppingListItem>,
          Stream<List<ShoppingListItem>>
        >
    with
        $FutureModifier<List<ShoppingListItem>>,
        $StreamProvider<List<ShoppingListItem>> {
  ShoppingListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shoppingListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shoppingListHash();

  @$internal
  @override
  $StreamProviderElement<List<ShoppingListItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ShoppingListItem>> create(Ref ref) {
    return shoppingList(ref);
  }
}

String _$shoppingListHash() => r'2f87cd0b7aee0d3e1dc0683bda66d885775562cb';

@ProviderFor(MealsController)
final mealsControllerProvider = MealsControllerProvider._();

final class MealsControllerProvider
    extends $AsyncNotifierProvider<MealsController, void> {
  MealsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealsControllerHash();

  @$internal
  @override
  MealsController create() => MealsController();
}

String _$mealsControllerHash() => r'b9cefb7a354653f0595916a40644d6b6d0eab16c';

abstract class _$MealsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
