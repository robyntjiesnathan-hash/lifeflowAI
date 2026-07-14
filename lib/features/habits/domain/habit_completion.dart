import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_completion.freezed.dart';
part 'habit_completion.g.dart';

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

/// Doc id is the `yyyy-MM-dd` date string, so "did I complete habit X on
/// date Y" is a direct doc lookup rather than a query.
@freezed
abstract class HabitCompletion with _$HabitCompletion {
  const factory HabitCompletion({
    required String date,
    @Default(true) bool completed,
    @_TimestampConverter() DateTime? completedAt,
    String? note,
  }) = _HabitCompletion;

  factory HabitCompletion.fromJson(Map<String, dynamic> json) => _$HabitCompletionFromJson(json);
}
