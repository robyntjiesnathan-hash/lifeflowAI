import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earned_badge.freezed.dart';
part 'earned_badge.g.dart';

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

/// A badge the user has earned. Doc id under `users/{uid}/badges/{id}` is
/// [badgeDefinitionId], matching the corresponding [BadgeDefinition.id] in
/// the static catalog.
@freezed
abstract class EarnedBadge with _$EarnedBadge {
  const factory EarnedBadge({
    required String badgeDefinitionId,
    @_TimestampConverter() DateTime? earnedAt,
  }) = _EarnedBadge;

  factory EarnedBadge.fromJson(Map<String, dynamic> json) => _$EarnedBadgeFromJson(json);
}
