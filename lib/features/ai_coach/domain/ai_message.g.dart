// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiMessage _$AiMessageFromJson(Map<String, dynamic> json) => _AiMessage(
  id: json['id'] as String,
  role: $enumDecode(_$AiMessageRoleEnumMap, json['role']),
  content: json['content'] as String,
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$AiMessageToJson(_AiMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$AiMessageRoleEnumMap[instance.role]!,
      'content': instance.content,
      'createdAt': const _TimestampConverter().toJson(instance.createdAt),
    };

const _$AiMessageRoleEnumMap = {
  AiMessageRole.user: 'user',
  AiMessageRole.assistant: 'assistant',
};
