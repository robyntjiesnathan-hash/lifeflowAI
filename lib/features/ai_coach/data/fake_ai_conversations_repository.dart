import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/ai_conversation.dart';
import '../domain/ai_conversations_repository.dart';
import '../domain/ai_message.dart';

/// In-memory AI Coach store for fake-auth mode, keyed by uid (and by
/// `uid/conversationId` for message threads) so each fake session is
/// isolated but persists for the app's lifetime. Mirrors
/// `FakeHabitsRepository`'s broadcast-StreamController pattern so watchers
/// re-emit reactively on every mutation.
class FakeAiConversationsRepository implements AiConversationsRepository {
  static final Map<String, List<AiConversation>> _conversations = {};
  static final Map<String, Map<String, List<AiMessage>>> _messages = {};
  static final Map<String, StreamController<List<AiConversation>>> _conversationControllers = {};
  static final Map<String, StreamController<List<AiMessage>>> _messageControllers = {};
  final _uuid = const Uuid();

  StreamController<List<AiConversation>> _conversationControllerFor(String uid) =>
      _conversationControllers.putIfAbsent(uid, () => StreamController<List<AiConversation>>.broadcast());

  void _emitConversations(String uid) {
    final all = List<AiConversation>.of(_conversations[uid] ?? const [])
      ..sort((a, b) => (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
    _conversationControllerFor(uid).add(List.unmodifiable(all));
  }

  StreamController<List<AiMessage>> _messageControllerFor(String uid, String conversationId) =>
      _messageControllers.putIfAbsent(
        '$uid/$conversationId',
        () => StreamController<List<AiMessage>>.broadcast(),
      );

  void _emitMessages(String uid, String conversationId) {
    final all = _messages[uid]?[conversationId] ?? const <AiMessage>[];
    _messageControllerFor(uid, conversationId).add(List.unmodifiable(all));
  }

  @override
  Stream<List<AiConversation>> watchConversations(String uid) {
    final controller = _conversationControllerFor(uid);
    Future.microtask(() => _emitConversations(uid));
    return controller.stream;
  }

  @override
  Stream<List<AiMessage>> watchMessages(String uid, String conversationId) {
    final controller = _messageControllerFor(uid, conversationId);
    Future.microtask(() => _emitMessages(uid, conversationId));
    return controller.stream;
  }

  @override
  Future<AiConversation> createConversation(String uid, String title) async {
    final now = DateTime.now();
    final conversation = AiConversation(id: _uuid.v4(), title: title, createdAt: now, updatedAt: now);
    _conversations.putIfAbsent(uid, () => []).add(conversation);
    _emitConversations(uid);
    return conversation;
  }

  @override
  Future<void> appendMessage(String uid, String conversationId, AiMessage message) async {
    _messages.putIfAbsent(uid, () => {}).putIfAbsent(conversationId, () => []).add(message);
    _emitMessages(uid, conversationId);

    final list = _conversations[uid];
    if (list != null) {
      final index = list.indexWhere((c) => c.id == conversationId);
      if (index != -1) {
        list[index] = list[index].copyWith(updatedAt: DateTime.now(), lastMessagePreview: _preview(message.content));
        _emitConversations(uid);
      }
    }
  }

  @override
  Future<void> deleteConversation(String uid, String conversationId) async {
    _conversations[uid]?.removeWhere((c) => c.id == conversationId);
    _messages[uid]?.remove(conversationId);
    _emitConversations(uid);
    _emitMessages(uid, conversationId);
  }

  String _preview(String content) {
    final singleLine = content.replaceAll('\n', ' ').trim();
    return singleLine.length > 120 ? '${singleLine.substring(0, 120)}…' : singleLine;
  }
}
