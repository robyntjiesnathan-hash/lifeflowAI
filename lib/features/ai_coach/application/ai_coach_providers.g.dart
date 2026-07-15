// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_coach_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiConversationsRepository)
final aiConversationsRepositoryProvider = AiConversationsRepositoryProvider._();

final class AiConversationsRepositoryProvider
    extends
        $FunctionalProvider<
          AiConversationsRepository,
          AiConversationsRepository,
          AiConversationsRepository
        >
    with $Provider<AiConversationsRepository> {
  AiConversationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiConversationsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiConversationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AiConversationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiConversationsRepository create(Ref ref) {
    return aiConversationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiConversationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiConversationsRepository>(value),
    );
  }
}

String _$aiConversationsRepositoryHash() =>
    r'a091b049a4238e8aa09250e79c727971512d4b9f';

@ProviderFor(conversations)
final conversationsProvider = ConversationsProvider._();

final class ConversationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AiConversation>>,
          List<AiConversation>,
          Stream<List<AiConversation>>
        >
    with
        $FutureModifier<List<AiConversation>>,
        $StreamProvider<List<AiConversation>> {
  ConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationsHash();

  @$internal
  @override
  $StreamProviderElement<List<AiConversation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AiConversation>> create(Ref ref) {
    return conversations(ref);
  }
}

String _$conversationsHash() => r'efce5bcfc77e81158247d7b3fbd079cce4ecce95';

@ProviderFor(conversationMessages)
final conversationMessagesProvider = ConversationMessagesFamily._();

final class ConversationMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AiMessage>>,
          List<AiMessage>,
          Stream<List<AiMessage>>
        >
    with $FutureModifier<List<AiMessage>>, $StreamProvider<List<AiMessage>> {
  ConversationMessagesProvider._({
    required ConversationMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'conversationMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMessagesHash();

  @override
  String toString() {
    return r'conversationMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<AiMessage>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AiMessage>> create(Ref ref) {
    final argument = this.argument as String;
    return conversationMessages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMessagesHash() =>
    r'260cbd2c7626a2bff17df49f9940fe8132e8905a';

final class ConversationMessagesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<AiMessage>>, String> {
  ConversationMessagesFamily._()
    : super(
        retry: null,
        name: r'conversationMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationMessagesProvider call(String conversationId) =>
      ConversationMessagesProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'conversationMessagesProvider';
}

/// Holds the conversationId + accumulated text of an assistant reply that
/// is still streaming in, or `null` when nothing is in progress.
///
/// The presentation layer watches this to render a live-updating assistant
/// bubble while [AiCoachController.sendMessage] is accumulating chunks from
/// [AiService.sendMessage]. Once the stream completes, the final message
/// has already been persisted via the repository and this is cleared, so
/// [conversationMessagesProvider] takes over rendering it from then on.

@ProviderFor(AiCoachStreamingReply)
final aiCoachStreamingReplyProvider = AiCoachStreamingReplyProvider._();

/// Holds the conversationId + accumulated text of an assistant reply that
/// is still streaming in, or `null` when nothing is in progress.
///
/// The presentation layer watches this to render a live-updating assistant
/// bubble while [AiCoachController.sendMessage] is accumulating chunks from
/// [AiService.sendMessage]. Once the stream completes, the final message
/// has already been persisted via the repository and this is cleared, so
/// [conversationMessagesProvider] takes over rendering it from then on.
final class AiCoachStreamingReplyProvider
    extends
        $NotifierProvider<
          AiCoachStreamingReply,
          ({String conversationId, String text})?
        > {
  /// Holds the conversationId + accumulated text of an assistant reply that
  /// is still streaming in, or `null` when nothing is in progress.
  ///
  /// The presentation layer watches this to render a live-updating assistant
  /// bubble while [AiCoachController.sendMessage] is accumulating chunks from
  /// [AiService.sendMessage]. Once the stream completes, the final message
  /// has already been persisted via the repository and this is cleared, so
  /// [conversationMessagesProvider] takes over rendering it from then on.
  AiCoachStreamingReplyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCoachStreamingReplyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCoachStreamingReplyHash();

  @$internal
  @override
  AiCoachStreamingReply create() => AiCoachStreamingReply();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({String conversationId, String text})? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({String conversationId, String text})?>(value),
    );
  }
}

String _$aiCoachStreamingReplyHash() =>
    r'5031aade581480ab3b5f0d1747ef770b60e545ad';

/// Holds the conversationId + accumulated text of an assistant reply that
/// is still streaming in, or `null` when nothing is in progress.
///
/// The presentation layer watches this to render a live-updating assistant
/// bubble while [AiCoachController.sendMessage] is accumulating chunks from
/// [AiService.sendMessage]. Once the stream completes, the final message
/// has already been persisted via the repository and this is cleared, so
/// [conversationMessagesProvider] takes over rendering it from then on.

abstract class _$AiCoachStreamingReply
    extends $Notifier<({String conversationId, String text})?> {
  ({String conversationId, String text})? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({String conversationId, String text})?,
              ({String conversationId, String text})?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({String conversationId, String text})?,
                ({String conversationId, String text})?
              >,
              ({String conversationId, String text})?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AiCoachController)
final aiCoachControllerProvider = AiCoachControllerProvider._();

final class AiCoachControllerProvider
    extends $AsyncNotifierProvider<AiCoachController, void> {
  AiCoachControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCoachControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCoachControllerHash();

  @$internal
  @override
  AiCoachController create() => AiCoachController();
}

String _$aiCoachControllerHash() => r'9235e1caaeaeb410a5a23dfcfb49879cc550bf34';

abstract class _$AiCoachController extends $AsyncNotifier<void> {
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
