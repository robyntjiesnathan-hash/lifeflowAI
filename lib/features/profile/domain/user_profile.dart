import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum CoachingStyle { supportive, direct, analytical, playful }

@JsonEnum(fieldRename: FieldRename.none)
enum AuthProviderName { email, google, apple, guest }

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default(true) bool budgetTrackingEnabled,
    @Default(true) bool mealPlanningEnabled,
    @Default(true) bool habitRemindersEnabled,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);
}

@freezed
abstract class NotificationPrefs with _$NotificationPrefs {
  const factory NotificationPrefs({
    @Default(true) bool dailySummary,
    @Default(true) bool habitReminders,
    @Default(true) bool taskReminders,
    @Default('08:00') String reminderTime,
  }) = _NotificationPrefs;

  factory NotificationPrefs.fromJson(Map<String, dynamic> json) => _$NotificationPrefsFromJson(json);
}

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
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    @Default(AuthProviderName.guest) AuthProviderName authProvider,
    @_TimestampConverter() DateTime? createdAt,
    @_TimestampConverter() DateTime? updatedAt,
    @Default(false) bool onboardingComplete,
    String? timezone,
    String? ageRange,
    String? occupation,
    String? wakeTime,
    String? sleepTime,
    @Default(<String>[]) List<String> primaryGoals,
    @Default(CoachingStyle.supportive) CoachingStyle coachingStyle,
    @Default(UserPreferences()) UserPreferences preferences,
    @Default(NotificationPrefs()) NotificationPrefs notificationPrefs,
    @Default(false) bool isPremium,
    @_TimestampConverter() DateTime? premiumSince,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
