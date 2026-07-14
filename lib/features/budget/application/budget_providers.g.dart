// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetRepository)
final budgetRepositoryProvider = BudgetRepositoryProvider._();

final class BudgetRepositoryProvider
    extends
        $FunctionalProvider<
          BudgetRepository,
          BudgetRepository,
          BudgetRepository
        >
    with $Provider<BudgetRepository> {
  BudgetRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetRepositoryHash();

  @$internal
  @override
  $ProviderElement<BudgetRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BudgetRepository create(Ref ref) {
    return budgetRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetRepository>(value),
    );
  }
}

String _$budgetRepositoryHash() => r'08c02a12ecaee2c7138f5d2f8d8713cd640c499f';

@ProviderFor(budgetProfile)
final budgetProfileProvider = BudgetProfileProvider._();

final class BudgetProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<BudgetProfile>,
          BudgetProfile,
          Stream<BudgetProfile>
        >
    with $FutureModifier<BudgetProfile>, $StreamProvider<BudgetProfile> {
  BudgetProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetProfileHash();

  @$internal
  @override
  $StreamProviderElement<BudgetProfile> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetProfile> create(Ref ref) {
    return budgetProfile(ref);
  }
}

String _$budgetProfileHash() => r'8a76378ce826b89bd552a05f47aff36543acd2c1';

@ProviderFor(transactions)
final transactionsProvider = TransactionsProvider._();

final class TransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BudgetTransaction>>,
          List<BudgetTransaction>,
          Stream<List<BudgetTransaction>>
        >
    with
        $FutureModifier<List<BudgetTransaction>>,
        $StreamProvider<List<BudgetTransaction>> {
  TransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionsHash();

  @$internal
  @override
  $StreamProviderElement<List<BudgetTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BudgetTransaction>> create(Ref ref) {
    return transactions(ref);
  }
}

String _$transactionsHash() => r'fbc8dad7378cbcaa3fb51976f8690652e5761194';

@ProviderFor(bills)
final billsProvider = BillsProvider._();

final class BillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bill>>,
          List<Bill>,
          Stream<List<Bill>>
        >
    with $FutureModifier<List<Bill>>, $StreamProvider<List<Bill>> {
  BillsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billsHash();

  @$internal
  @override
  $StreamProviderElement<List<Bill>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Bill>> create(Ref ref) {
    return bills(ref);
  }
}

String _$billsHash() => r'61af5a0aeb88f021a0bc1f58d9879ac424ca88d5';

@ProviderFor(todayBudgetSummary)
final todayBudgetSummaryProvider = TodayBudgetSummaryProvider._();

final class TodayBudgetSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<BudgetTodaySummary>,
          BudgetTodaySummary,
          FutureOr<BudgetTodaySummary>
        >
    with
        $FutureModifier<BudgetTodaySummary>,
        $FutureProvider<BudgetTodaySummary> {
  TodayBudgetSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayBudgetSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayBudgetSummaryHash();

  @$internal
  @override
  $FutureProviderElement<BudgetTodaySummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BudgetTodaySummary> create(Ref ref) {
    return todayBudgetSummary(ref);
  }
}

String _$todayBudgetSummaryHash() =>
    r'2081b0c36af9b5694e201fbb20472e991c70fd60';

@ProviderFor(BudgetController)
final budgetControllerProvider = BudgetControllerProvider._();

final class BudgetControllerProvider
    extends $AsyncNotifierProvider<BudgetController, void> {
  BudgetControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetControllerHash();

  @$internal
  @override
  BudgetController create() => BudgetController();
}

String _$budgetControllerHash() => r'ed5881d82ab1a050cf65c1997feead1232e35d30';

abstract class _$BudgetController extends $AsyncNotifier<void> {
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
