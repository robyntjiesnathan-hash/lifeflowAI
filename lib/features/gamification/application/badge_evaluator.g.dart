// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_evaluator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(badgeEvaluator)
final badgeEvaluatorProvider = BadgeEvaluatorProvider._();

final class BadgeEvaluatorProvider
    extends $FunctionalProvider<BadgeEvaluator, BadgeEvaluator, BadgeEvaluator>
    with $Provider<BadgeEvaluator> {
  BadgeEvaluatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgeEvaluatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgeEvaluatorHash();

  @$internal
  @override
  $ProviderElement<BadgeEvaluator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BadgeEvaluator create(Ref ref) {
    return badgeEvaluator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BadgeEvaluator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BadgeEvaluator>(value),
    );
  }
}

String _$badgeEvaluatorHash() => r'bd6ed09f399affdc9ca4404894e0ba4cb0baf588';
