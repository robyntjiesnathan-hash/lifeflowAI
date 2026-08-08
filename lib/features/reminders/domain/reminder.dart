import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

enum ReminderRepeat { none, daily, weekly, monthly }

enum ReminderRelatedType { task, habit, goal, custom }

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
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String title,
    @_TimestampConverter() required DateTime scheduledAt,
    @Default(ReminderRepeat.none) ReminderRepeat repeat,
    @Default(ReminderRelatedType.custom) ReminderRelatedType relatedType,
    String? relatedId,
    @Default(true) bool isEnabled,
    int? localNotificationId,
    @_TimestampConverter() DateTime? createdAt,
  }) = _Reminder;

  const Reminder._();

  factory Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);
}
