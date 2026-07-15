import 'ai_conversation.dart';
import 'ai_message.dart';

abstract class AiConversationsRepository {
  Stream<List<AiConversation>> watchConversations(String uid);

  Stream<List<AiMessage>> watchMessages(String uid, String conversationId);

  Future<AiConversation> createConversation(String uid, String title);

  /// Appends [message] to `conversationId`'s `messages` subcollection and
  /// also updates the parent conversation's `updatedAt`/`lastMessagePreview`
  /// so the (future) conversation-list UI stays in sync without a second
  /// write from the caller.
  Future<void> appendMessage(String uid, String conversationId, AiMessage message);

  Future<void> deleteConversation(String uid, String conversationId);
}
