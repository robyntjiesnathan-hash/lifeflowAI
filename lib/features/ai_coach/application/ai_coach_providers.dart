import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../profile/application/user_profile_providers.dart';
import '../data/fake_ai_conversations_repository.dart';
import '../data/firestore_ai_conversations_repository.dart';
import '../domain/ai_conversation.dart';
import '../domain/ai_conversations_repository.dart';
import '../domain/ai_message.dart';
import 'ai_service_provider.dart';

part 'ai_coach_providers.g.dart';

const _uuid = Uuid();

@Riverpod(keepAlive: true)
AiConversationsRepository aiConversationsRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeAiConversationsRepository();
  return FirestoreAiConversationsRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<List<AiConversation>> conversations(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(aiConversationsRepositoryProvider).watchConversations(uid);
}

@riverpod
Stream<List<AiMessage>> conversationMessages(Ref ref, String conversationId) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(aiConversationsRepositoryProvider).watchMessages(uid, conversationId);
}

/// Holds the conversationId + accumulated text of an assistant reply that
/// is still streaming in, or `null` when nothing is in progress.
///
/// The presentation layer watches this to render a live-updating assistant
/// bubble while [AiCoachController.sendMessage] is accumulating chunks from
/// [AiService.sendMessage]. Once the stream completes, the final message
/// has already been persisted via the repository and this is cleared, so
/// [conversationMessagesProvider] takes over rendering it from then on.
@Riverpod(keepAlive: true)
class AiCoachStreamingReply extends _$AiCoachStreamingReply {
  @override
  ({String conversationId, String text})? build() => null;

  void update(String conversationId, String text) => state = (conversationId: conversationId, text: text);

  void clear() => state = null;
}

// keepAlive: sendMessage() is a multi-second streaming operation reached
// only via `ref.read(...).notifier` (the screen never `ref.watch`s this
// controller directly) — with the default autoDispose behavior the
// provider was being torn down mid-stream, throwing "Cannot use the Ref
// ... after it has been disposed" the moment the async gap resumed.
@Riverpod(keepAlive: true)
class AiCoachController extends _$AiCoachController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Future<AiConversation> createConversation({String title = 'New chat'}) {
    return ref.read(aiConversationsRepositoryProvider).createConversation(_uid, title);
  }

  Future<void> deleteConversation(String conversationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(aiConversationsRepositoryProvider).deleteConversation(_uid, conversationId),
    );
  }

  /// Persists [text] as a user message (optimistic — happens immediately),
  /// then streams Flow's reply via [aiServiceProvider], accumulating chunks
  /// into [aiCoachStreamingReplyProvider] for a live-updating bubble, and
  /// finally persists the completed assistant message. Creates a new
  /// conversation first when [conversationId] is null. Returns the
  /// conversation id the message landed in (the newly created one, or the
  /// one passed in).
  Future<String> sendMessage(String? conversationId, String text) async {
    final uid = _uid;
    final repo = ref.read(aiConversationsRepositoryProvider);
    String id = conversationId ?? '';

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (conversationId != null) {
        id = conversationId;
      } else {
        final trimmed = text.trim();
        final title = trimmed.isEmpty
            ? 'New chat'
            : (trimmed.length > 40 ? '${trimmed.substring(0, 40)}…' : trimmed);
        final created = await repo.createConversation(uid, title);
        id = created.id;
      }

      // Snapshot history *before* this turn is appended, so it matches
      // AiService.sendMessage's contract of "prior conversation" +
      // "this message" as separate arguments.
      final history = await repo.watchMessages(uid, id).first;

      final userMessage = AiMessage(
        id: _uuid.v4(),
        role: AiMessageRole.user,
        content: text,
        createdAt: DateTime.now(),
      );
      await repo.appendMessage(uid, id, userMessage);

      final coachingStyle = ref.read(currentUserProfileProvider).value?.coachingStyle;
      final streamingNotifier = ref.read(aiCoachStreamingReplyProvider.notifier);
      final buffer = StringBuffer();

      await for (final chunk in ref.read(aiServiceProvider).sendMessage(
            conversationId: id,
            history: history,
            userMessage: text,
            coachingStyle: coachingStyle,
          )) {
        buffer.write(chunk);
        streamingNotifier.update(id, buffer.toString());
      }

      final assistantMessage = AiMessage(
        id: _uuid.v4(),
        role: AiMessageRole.assistant,
        content: buffer.toString(),
        createdAt: DateTime.now(),
      );
      await repo.appendMessage(uid, id, assistantMessage);
      streamingNotifier.clear();
    });

    return id;
  }
}
