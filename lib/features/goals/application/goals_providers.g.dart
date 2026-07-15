// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goalsRepository)
final goalsRepositoryProvider = GoalsRepositoryProvider._();

final class GoalsRepositoryProvider
    extends
        $FunctionalProvider<GoalsRepository, GoalsRepository, GoalsRepository>
    with $Provider<GoalsRepository> {
  GoalsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoalsRepository create(Ref ref) {
    return goalsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalsRepository>(value),
    );
  }
}

String _$goalsRepositoryHash() => r'6eae52a1c70c39b4ef652bef264ec5d85e8bd502';

@ProviderFor(goals)
final goalsProvider = GoalsProvider._();

final class GoalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Goal>>,
          List<Goal>,
          Stream<List<Goal>>
        >
    with $FutureModifier<List<Goal>>, $StreamProvider<List<Goal>> {
  GoalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsHash();

  @$internal
  @override
  $StreamProviderElement<List<Goal>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Goal>> create(Ref ref) {
    return goals(ref);
  }
}

String _$goalsHash() => r'c66a3793907ca09928bb3de51077ac9e8469613d';

@ProviderFor(goalMilestones)
final goalMilestonesProvider = GoalMilestonesFamily._();

final class GoalMilestonesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Milestone>>,
          List<Milestone>,
          Stream<List<Milestone>>
        >
    with $FutureModifier<List<Milestone>>, $StreamProvider<List<Milestone>> {
  GoalMilestonesProvider._({
    required GoalMilestonesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'goalMilestonesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalMilestonesHash();

  @override
  String toString() {
    return r'goalMilestonesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Milestone>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Milestone>> create(Ref ref) {
    final argument = this.argument as String;
    return goalMilestones(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalMilestonesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalMilestonesHash() => r'da54b2a84eb38173f13631303174a5c75e90ed56';

final class GoalMilestonesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Milestone>>, String> {
  GoalMilestonesFamily._()
    : super(
        retry: null,
        name: r'goalMilestonesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GoalMilestonesProvider call(String goalId) =>
      GoalMilestonesProvider._(argument: goalId, from: this);

  @override
  String toString() => r'goalMilestonesProvider';
}

@ProviderFor(GoalsController)
final goalsControllerProvider = GoalsControllerProvider._();

final class GoalsControllerProvider
    extends $AsyncNotifierProvider<GoalsController, void> {
  GoalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsControllerHash();

  @$internal
  @override
  GoalsController create() => GoalsController();
}

String _$goalsControllerHash() => r'67b925795dcf7bc8da4f5c2b0975b07c19ce73d4';

abstract class _$GoalsController extends $AsyncNotifier<void> {
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
