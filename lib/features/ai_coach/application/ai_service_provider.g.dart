// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The single seam a future real-LLM integration (e.g. Anthropic's Claude
/// API) replaces: swap the implementation constructed here, or override it
/// at the top of the widget tree with
/// `ProviderScope(overrides: [aiServiceProvider.overrideWithValue(RealAiService(...))])`.
/// Nothing else in the ai_coach feature depends on which [AiService]
/// implementation is wired up here.

@ProviderFor(aiService)
final aiServiceProvider = AiServiceProvider._();

/// The single seam a future real-LLM integration (e.g. Anthropic's Claude
/// API) replaces: swap the implementation constructed here, or override it
/// at the top of the widget tree with
/// `ProviderScope(overrides: [aiServiceProvider.overrideWithValue(RealAiService(...))])`.
/// Nothing else in the ai_coach feature depends on which [AiService]
/// implementation is wired up here.

final class AiServiceProvider
    extends $FunctionalProvider<AiService, AiService, AiService>
    with $Provider<AiService> {
  /// The single seam a future real-LLM integration (e.g. Anthropic's Claude
  /// API) replaces: swap the implementation constructed here, or override it
  /// at the top of the widget tree with
  /// `ProviderScope(overrides: [aiServiceProvider.overrideWithValue(RealAiService(...))])`.
  /// Nothing else in the ai_coach feature depends on which [AiService]
  /// implementation is wired up here.
  AiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiServiceHash();

  @$internal
  @override
  $ProviderElement<AiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AiService create(Ref ref) {
    return aiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiService>(value),
    );
  }
}

String _$aiServiceHash() => r'ac77cb1c2439e80c083f4f06d10b2fe398e46a34';
