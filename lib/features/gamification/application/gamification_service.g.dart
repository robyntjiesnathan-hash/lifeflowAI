// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gamificationService)
final gamificationServiceProvider = GamificationServiceProvider._();

final class GamificationServiceProvider
    extends
        $FunctionalProvider<
          GamificationService,
          GamificationService,
          GamificationService
        >
    with $Provider<GamificationService> {
  GamificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamificationServiceHash();

  @$internal
  @override
  $ProviderElement<GamificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GamificationService create(Ref ref) {
    return gamificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamificationService>(value),
    );
  }
}

String _$gamificationServiceHash() =>
    r'fd6e84ec836011935e57970e6fa815379ad5bad4';

@ProviderFor(gamificationSummary)
final gamificationSummaryProvider = GamificationSummaryFamily._();

final class GamificationSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<GamificationSummary>,
          GamificationSummary,
          Stream<GamificationSummary>
        >
    with
        $FutureModifier<GamificationSummary>,
        $StreamProvider<GamificationSummary> {
  GamificationSummaryProvider._({
    required GamificationSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gamificationSummaryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gamificationSummaryHash();

  @override
  String toString() {
    return r'gamificationSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<GamificationSummary> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<GamificationSummary> create(Ref ref) {
    final argument = this.argument as String;
    return gamificationSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GamificationSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gamificationSummaryHash() =>
    r'7bbaf1b4e85ad43eb41c5551efdaa0cb1b91c8fd';

final class GamificationSummaryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<GamificationSummary>, String> {
  GamificationSummaryFamily._()
    : super(
        retry: null,
        name: r'gamificationSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GamificationSummaryProvider call(String uid) =>
      GamificationSummaryProvider._(argument: uid, from: this);

  @override
  String toString() => r'gamificationSummaryProvider';
}
