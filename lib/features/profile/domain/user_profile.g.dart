// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    _UserPreferences(
      budgetTrackingEnabled: json['budgetTrackingEnabled'] as bool? ?? true,
      mealPlanningEnabled: json['mealPlanningEnabled'] as bool? ?? true,
      habitRemindersEnabled: json['habitRemindersEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$UserPreferencesToJson(_UserPreferences instance) =>
    <String, dynamic>{
      'budgetTrackingEnabled': instance.budgetTrackingEnabled,
      'mealPlanningEnabled': instance.mealPlanningEnabled,
      'habitRemindersEnabled': instance.habitRemindersEnabled,
    };

_NotificationPrefs _$NotificationPrefsFromJson(Map<String, dynamic> json) =>
    _NotificationPrefs(
      dailySummary: json['dailySummary'] as bool? ?? true,
      habitReminders: json['habitReminders'] as bool? ?? true,
      taskReminders: json['taskReminders'] as bool? ?? true,
      reminderTime: json['reminderTime'] as String? ?? '08:00',
    );

Map<String, dynamic> _$NotificationPrefsToJson(_NotificationPrefs instance) =>
    <String, dynamic>{
      'dailySummary': instance.dailySummary,
      'habitReminders': instance.habitReminders,
      'taskReminders': instance.taskReminders,
      'reminderTime': instance.reminderTime,
    };

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  uid: json['uid'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  authProvider:
      $enumDecodeNullable(_$AuthProviderNameEnumMap, json['authProvider']) ??
      AuthProviderName.guest,
  createdAt: const _TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const _TimestampConverter().fromJson(json['updatedAt']),
  onboardingComplete: json['onboardingComplete'] as bool? ?? false,
  timezone: json['timezone'] as String?,
  ageRange: json['ageRange'] as String?,
  occupation: json['occupation'] as String?,
  wakeTime: json['wakeTime'] as String?,
  sleepTime: json['sleepTime'] as String?,
  primaryGoals:
      (json['primaryGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  coachingStyle:
      $enumDecodeNullable(_$CoachingStyleEnumMap, json['coachingStyle']) ??
      CoachingStyle.supportive,
  preferences: json['preferences'] == null
      ? const UserPreferences()
      : UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
  notificationPrefs: json['notificationPrefs'] == null
      ? const NotificationPrefs()
      : NotificationPrefs.fromJson(
          json['notificationPrefs'] as Map<String, dynamic>,
        ),
  isPremium: json['isPremium'] as bool? ?? false,
  premiumSince: const _TimestampConverter().fromJson(json['premiumSince']),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'authProvider': _$AuthProviderNameEnumMap[instance.authProvider]!,
      'createdAt': const _TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const _TimestampConverter().toJson(instance.updatedAt),
      'onboardingComplete': instance.onboardingComplete,
      'timezone': instance.timezone,
      'ageRange': instance.ageRange,
      'occupation': instance.occupation,
      'wakeTime': instance.wakeTime,
      'sleepTime': instance.sleepTime,
      'primaryGoals': instance.primaryGoals,
      'coachingStyle': _$CoachingStyleEnumMap[instance.coachingStyle]!,
      'preferences': instance.preferences,
      'notificationPrefs': instance.notificationPrefs,
      'isPremium': instance.isPremium,
      'premiumSince': const _TimestampConverter().toJson(instance.premiumSince),
    };

const _$AuthProviderNameEnumMap = {
  AuthProviderName.email: 'email',
  AuthProviderName.google: 'google',
  AuthProviderName.apple: 'apple',
  AuthProviderName.guest: 'guest',
};

const _$CoachingStyleEnumMap = {
  CoachingStyle.supportive: 'supportive',
  CoachingStyle.direct: 'direct',
  CoachingStyle.analytical: 'analytical',
  CoachingStyle.playful: 'playful',
};
