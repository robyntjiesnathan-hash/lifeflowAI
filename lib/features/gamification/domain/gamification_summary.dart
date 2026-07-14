import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamification_summary.freezed.dart';
part 'gamification_summary.g.dart';

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

@freezed
abstract class GamificationSummary with _$GamificationSummary {
  const factory GamificationSummary({
    @Default(0) int xp,
    @Default(1) int level,
    @Default(100) int xpToNextLevel,
    @Default(0) int currentStreakDays,
    @Default(0) int longestStreakDays,
    @_TimestampConverter() DateTime? lastActiveDate,
  }) = _GamificationSummary;

  factory GamificationSummary.fromJson(Map<String, dynamic> json) => _$GamificationSummaryFromJson(json);
}
