// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(habitsRepository)
final habitsRepositoryProvider = HabitsRepositoryProvider._();

final class HabitsRepositoryProvider
    extends
        $FunctionalProvider<
          HabitsRepository,
          HabitsRepository,
          HabitsRepository
        >
    with $Provider<HabitsRepository> {
  HabitsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsRepositoryHash();

  @$internal
  @override
  $ProviderElement<HabitsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitsRepository create(Ref ref) {
    return habitsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitsRepository>(value),
    );
  }
}

String _$habitsRepositoryHash() => r'19739ed0786fe66bbceef1410b58cc81a56cc79d';

@ProviderFor(habits)
final habitsProvider = HabitsProvider._();

final class HabitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Habit>>,
          List<Habit>,
          Stream<List<Habit>>
        >
    with $FutureModifier<List<Habit>>, $StreamProvider<List<Habit>> {
  HabitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsHash();

  @$internal
  @override
  $StreamProviderElement<List<Habit>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Habit>> create(Ref ref) {
    return habits(ref);
  }
}

String _$habitsHash() => r'6dde4d5f7b96e6dfabe523902420a48e32612ef7';

@ProviderFor(habitCompletionsForRange)
final habitCompletionsForRangeProvider = HabitCompletionsForRangeFamily._();

final class HabitCompletionsForRangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HabitCompletion>>,
          List<HabitCompletion>,
          Stream<List<HabitCompletion>>
        >
    with
        $FutureModifier<List<HabitCompletion>>,
        $StreamProvider<List<HabitCompletion>> {
  HabitCompletionsForRangeProvider._({
    required HabitCompletionsForRangeFamily super.from,
    required (String, {DateTime start, DateTime end}) super.argument,
  }) : super(
         retry: null,
         name: r'habitCompletionsForRangeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$habitCompletionsForRangeHash();

  @override
  String toString() {
    return r'habitCompletionsForRangeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<HabitCompletion>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HabitCompletion>> create(Ref ref) {
    final argument = this.argument as (String, {DateTime start, DateTime end});
    return habitCompletionsForRange(
      ref,
      argument.$1,
      start: argument.start,
      end: argument.end,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HabitCompletionsForRangeProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$habitCompletionsForRangeHash() =>
    r'3fc4fb98fc57adddfb686ea42f4c942dd7e1cdc8';

final class HabitCompletionsForRangeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<HabitCompletion>>,
          (String, {DateTime start, DateTime end})
        > {
  HabitCompletionsForRangeFamily._()
    : super(
        retry: null,
        name: r'habitCompletionsForRangeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HabitCompletionsForRangeProvider call(
    String habitId, {
    required DateTime start,
    required DateTime end,
  }) => HabitCompletionsForRangeProvider._(
    argument: (habitId, start: start, end: end),
    from: this,
  );

  @override
  String toString() => r'habitCompletionsForRangeProvider';
}

@ProviderFor(habitCompletedToday)
final habitCompletedTodayProvider = HabitCompletedTodayFamily._();

final class HabitCompletedTodayProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  HabitCompletedTodayProvider._({
    required HabitCompletedTodayFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'habitCompletedTodayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$habitCompletedTodayHash();

  @override
  String toString() {
    return r'habitCompletedTodayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as String;
    return habitCompletedToday(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitCompletedTodayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$habitCompletedTodayHash() =>
    r'6b52259575c872de889e91da5c738c8965be93a0';

final class HabitCompletedTodayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, String> {
  HabitCompletedTodayFamily._()
    : super(
        retry: null,
        name: r'habitCompletedTodayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HabitCompletedTodayProvider call(String habitId) =>
      HabitCompletedTodayProvider._(argument: habitId, from: this);

  @override
  String toString() => r'habitCompletedTodayProvider';
}

/// Percent of habits completed on each of the last 7 days (Mon-Sun of the
/// current week), used for the Habits screen's "Overall Progress" sparkline.

@ProviderFor(habitsWeeklyProgress)
final habitsWeeklyProgressProvider = HabitsWeeklyProgressProvider._();

/// Percent of habits completed on each of the last 7 days (Mon-Sun of the
/// current week), used for the Habits screen's "Overall Progress" sparkline.

final class HabitsWeeklyProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<double>>,
          List<double>,
          FutureOr<List<double>>
        >
    with $FutureModifier<List<double>>, $FutureProvider<List<double>> {
  /// Percent of habits completed on each of the last 7 days (Mon-Sun of the
  /// current week), used for the Habits screen's "Overall Progress" sparkline.
  HabitsWeeklyProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsWeeklyProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsWeeklyProgressHash();

  @$internal
  @override
  $FutureProviderElement<List<double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<double>> create(Ref ref) {
    return habitsWeeklyProgress(ref);
  }
}

String _$habitsWeeklyProgressHash() =>
    r'd6c4db802ab9bcae933a37d2e28d7f99a2268402';

@ProviderFor(HabitsController)
final habitsControllerProvider = HabitsControllerProvider._();

final class HabitsControllerProvider
    extends $AsyncNotifierProvider<HabitsController, void> {
  HabitsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsControllerHash();

  @$internal
  @override
  HabitsController create() => HabitsController();
}

String _$habitsControllerHash() => r'00f5617f70e67e1eeb8044c98b5dab30828df4bc';

abstract class _$HabitsController extends $AsyncNotifier<void> {
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
