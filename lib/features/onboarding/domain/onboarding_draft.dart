import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/domain/user_profile.dart';

part 'onboarding_draft.freezed.dart';

/// Accumulates answers across the onboarding PageView so the profile is
/// written to Firestore exactly once on completion (avoids partial-profile
/// writes if the user abandons onboarding partway through).
@freezed
abstract class OnboardingDraft with _$OnboardingDraft {
  const factory OnboardingDraft({
    @Default('') String displayName,
    String? ageRange,
    String? occupation,
    @Default('07:00') String wakeTime,
    @Default('22:30') String sleepTime,
    @Default(<String>[]) List<String> primaryGoals,
    @Default(CoachingStyle.supportive) CoachingStyle coachingStyle,
    @Default(true) bool budgetTrackingEnabled,
    @Default(true) bool mealPlanningEnabled,
    @Default(true) bool habitRemindersEnabled,
    @Default(true) bool dailySummary,
    @Default(true) bool habitReminders,
    @Default(true) bool taskReminders,
    @Default('08:00') String reminderTime,
  }) = _OnboardingDraft;
}
