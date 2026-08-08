// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earned_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarnedBadge _$EarnedBadgeFromJson(Map<String, dynamic> json) => _EarnedBadge(
  badgeDefinitionId: json['badgeDefinitionId'] as String,
  earnedAt: const _TimestampConverter().fromJson(json['earnedAt']),
);

Map<String, dynamic> _$EarnedBadgeToJson(_EarnedBadge instance) =>
    <String, dynamic>{
      'badgeDefinitionId': instance.badgeDefinitionId,
      'earnedAt': const _TimestampConverter().toJson(instance.earnedAt),
    };
