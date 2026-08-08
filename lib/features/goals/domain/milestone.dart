import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'milestone.freezed.dart';
part 'milestone.g.dart';

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

/// A single checklist step under a [Goal] (`goals/{goalId}/milestones/{id}`).
/// Toggling a milestone recomputes its parent goal's denormalized
/// `progressPercent` — see [GoalsRepository.toggleMilestone].
@freezed
abstract class Milestone with _$Milestone {
  const factory Milestone({
    required String id,
    required String title,
    @Default(false) bool isDone,
    @Default(0) int order,
    @_TimestampConverter() DateTime? dueDate,
    @_TimestampConverter() DateTime? completedAt,
  }) = _Milestone;

  factory Milestone.fromJson(Map<String, dynamic> json) => _$MilestoneFromJson(json);
}
