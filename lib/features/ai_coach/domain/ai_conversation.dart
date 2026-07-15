import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_conversation.freezed.dart';
part 'ai_conversation.g.dart';

class _TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const _TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) => object == null ? null : Timestamp.fromDate(object);
}

/// A single AI Coach chat thread. `lastMessagePreview`/`updatedAt` let a
/// future conversation-list UI show a summary without fetching the full
/// `messages` subcollection.
@freezed
abstract class AiConversation with _$AiConversation {
  const factory AiConversation({
    required String id,
    @Default('New chat') String title,
    @_TimestampConverter() DateTime? createdAt,
    @_TimestampConverter() DateTime? updatedAt,
    @Default('') String lastMessagePreview,
  }) = _AiConversation;

  const AiConversation._();

  factory AiConversation.fromJson(Map<String, dynamic> json) => _$AiConversationFromJson(json);
}
