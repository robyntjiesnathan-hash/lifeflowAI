import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/ai_conversation.dart';
import '../domain/ai_conversations_repository.dart';
import '../domain/ai_message.dart';

class FirestoreAiConversationsRepository implements AiConversationsRepository {
  FirestoreAiConversationsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _conversationsCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.aiConversations);

  @override
  Stream<List<AiConversation>> watchConversations(String uid) {
    return _conversationsCol(uid).orderBy('updatedAt', descending: true).snapshots().map(
          (snap) => snap.docs.map((d) => AiConversation.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Stream<List<AiMessage>> watchMessages(String uid, String conversationId) {
    return _conversationsCol(uid)
        .doc(conversationId)
        .collection(FirestorePaths.messages)
        .orderBy('createdAt')
        .snapshots()
        .map((snap) => snap.docs.map((d) => AiMessage.fromJson({...d.data(), 'id': d.id})).toList());
  }

  @override
  Future<AiConversation> createConversation(String uid, String title) async {
    final doc = _conversationsCol(uid).doc();
    final now = DateTime.now();
    final conversation = AiConversation(id: doc.id, title: title, createdAt: now, updatedAt: now);
    await doc.set(conversation.toJson()..remove('id'));
    return conversation;
  }

  @override
  Future<void> appendMessage(String uid, String conversationId, AiMessage message) async {
    final conversationRef = _conversationsCol(uid).doc(conversationId);
    final messageRef = conversationRef.collection(FirestorePaths.messages).doc(message.id);
    final batch = _firestore.batch()
      ..set(messageRef, message.toJson()..remove('id'))
      ..set(
        conversationRef,
        {
          'updatedAt': Timestamp.now(),
          'lastMessagePreview': _preview(message.content),
        },
        SetOptions(merge: true),
      );
    await batch.commit();
  }

  @override
  Future<void> deleteConversation(String uid, String conversationId) async {
    final conversationRef = _conversationsCol(uid).doc(conversationId);
    final messages = await conversationRef.collection(FirestorePaths.messages).get();
    final batch = _firestore.batch();
    for (final doc in messages.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(conversationRef);
    await batch.commit();
  }

  String _preview(String content) {
    final singleLine = content.replaceAll('\n', ' ').trim();
    return singleLine.length > 120 ? '${singleLine.substring(0, 120)}…' : singleLine;
  }
}
