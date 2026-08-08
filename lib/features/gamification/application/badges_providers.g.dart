// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badges_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(badgesRepository)
final badgesRepositoryProvider = BadgesRepositoryProvider._();

final class BadgesRepositoryProvider
    extends
        $FunctionalProvider<
          BadgesRepository,
          BadgesRepository,
          BadgesRepository
        >
    with $Provider<BadgesRepository> {
  BadgesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgesRepositoryHash();

  @$internal
  @override
  $ProviderElement<BadgesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BadgesRepository create(Ref ref) {
    return badgesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BadgesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BadgesRepository>(value),
    );
  }
}

String _$badgesRepositoryHash() => r'a2b78378e958b4d77e1e978e9baab0edcac81f26';

@ProviderFor(earnedBadges)
final earnedBadgesProvider = EarnedBadgesProvider._();

final class EarnedBadgesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EarnedBadge>>,
          List<EarnedBadge>,
          Stream<List<EarnedBadge>>
        >
    with
        $FutureModifier<List<EarnedBadge>>,
        $StreamProvider<List<EarnedBadge>> {
  EarnedBadgesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earnedBadgesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earnedBadgesHash();

  @$internal
  @override
  $StreamProviderElement<List<EarnedBadge>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<EarnedBadge>> create(Ref ref) {
    return earnedBadges(ref);
  }
}

String _$earnedBadgesHash() => r'dae235094974eeed2cb73cc0ea0b5f9c8f137e36';
