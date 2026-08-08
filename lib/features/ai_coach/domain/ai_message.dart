import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message.freezed.dart';
part 'ai_message.g.dart';

/// Who authored a given [AiMessage] in a conversation.
enum AiMessageRole { user, assistant }

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

/// A single structured chat turn. Kept as a real model (role + content)
/// rather than a flattened prompt string so a future real-LLM integration
/// can replay `history` as proper role-tagged messages (and later add
/// tool/function-calling fields here without breaking callers).
@freezed
abstract class AiMessage with _$AiMessage {
  const factory AiMessage({
    required String id,
    required AiMessageRole role,
    required String content,
    @_TimestampConverter() DateTime? createdAt,
  }) = _AiMessage;

  const AiMessage._();

  factory AiMessage.fromJson(Map<String, dynamic> json) => _$AiMessageFromJson(json);

  bool get isUser => role == AiMessageRole.user;
  bool get isAssistant => role == AiMessageRole.assistant;
}
