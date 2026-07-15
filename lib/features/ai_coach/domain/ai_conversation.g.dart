// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiConversation _$AiConversationFromJson(Map<String, dynamic> json) =>
    _AiConversation(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'New chat',
      createdAt: const _TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const _TimestampConverter().fromJson(json['updatedAt']),
      lastMessagePreview: json['lastMessagePreview'] as String? ?? '',
    );

Map<String, dynamic> _$AiConversationToJson(_AiConversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': const _TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const _TimestampConverter().toJson(instance.updatedAt),
      'lastMessagePreview': instance.lastMessagePreview,
    };
