// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remindersRepository)
final remindersRepositoryProvider = RemindersRepositoryProvider._();

final class RemindersRepositoryProvider
    extends
        $FunctionalProvider<
          RemindersRepository,
          RemindersRepository,
          RemindersRepository
        >
    with $Provider<RemindersRepository> {
  RemindersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemindersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemindersRepository create(Ref ref) {
    return remindersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemindersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemindersRepository>(value),
    );
  }
}

String _$remindersRepositoryHash() =>
    r'38417d685711ad39c08abfd13bf71702362e7bfc';

@ProviderFor(reminders)
final remindersProvider = RemindersProvider._();

final class RemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reminder>>,
          List<Reminder>,
          Stream<List<Reminder>>
        >
    with $FutureModifier<List<Reminder>>, $StreamProvider<List<Reminder>> {
  RemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersHash();

  @$internal
  @override
  $StreamProviderElement<List<Reminder>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reminder>> create(Ref ref) {
    return reminders(ref);
  }
}

String _$remindersHash() => r'902483a6008dfeecfb11e385021e4ed7992b93a7';

@ProviderFor(RemindersController)
final remindersControllerProvider = RemindersControllerProvider._();

final class RemindersControllerProvider
    extends $AsyncNotifierProvider<RemindersController, void> {
  RemindersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersControllerHash();

  @$internal
  @override
  RemindersController create() => RemindersController();
}

String _$remindersControllerHash() =>
    r'2042a09563705e290e38a87b8878a36f7e6fc93e';

abstract class _$RemindersController extends $AsyncNotifier<void> {
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
