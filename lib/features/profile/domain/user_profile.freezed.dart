// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferences {

 bool get budgetTrackingEnabled; bool get mealPlanningEnabled; bool get habitRemindersEnabled;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.budgetTrackingEnabled, budgetTrackingEnabled) || other.budgetTrackingEnabled == budgetTrackingEnabled)&&(identical(other.mealPlanningEnabled, mealPlanningEnabled) || other.mealPlanningEnabled == mealPlanningEnabled)&&(identical(other.habitRemindersEnabled, habitRemindersEnabled) || other.habitRemindersEnabled == habitRemindersEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budgetTrackingEnabled,mealPlanningEnabled,habitRemindersEnabled);

@override
String toString() {
  return 'UserPreferences(budgetTrackingEnabled: $budgetTrackingEnabled, mealPlanningEnabled: $mealPlanningEnabled, habitRemindersEnabled: $habitRemindersEnabled)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
 bool budgetTrackingEnabled, bool mealPlanningEnabled, bool habitRemindersEnabled
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? budgetTrackingEnabled = null,Object? mealPlanningEnabled = null,Object? habitRemindersEnabled = null,}) {
  return _then(_self.copyWith(
budgetTrackingEnabled: null == budgetTrackingEnabled ? _self.budgetTrackingEnabled : budgetTrackingEnabled // ignore: cast_nullable_to_non_nullable
as bool,mealPlanningEnabled: null == mealPlanningEnabled ? _self.mealPlanningEnabled : mealPlanningEnabled // ignore: cast_nullable_to_non_nullable
as bool,habitRemindersEnabled: null == habitRemindersEnabled ? _self.habitRemindersEnabled : habitRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreferences implements UserPreferences {
  const _UserPreferences({this.budgetTrackingEnabled = true, this.mealPlanningEnabled = true, this.habitRemindersEnabled = true});
  factory _UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);

@override@JsonKey() final  bool budgetTrackingEnabled;
@override@JsonKey() final  bool mealPlanningEnabled;
@override@JsonKey() final  bool habitRemindersEnabled;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.budgetTrackingEnabled, budgetTrackingEnabled) || other.budgetTrackingEnabled == budgetTrackingEnabled)&&(identical(other.mealPlanningEnabled, mealPlanningEnabled) || other.mealPlanningEnabled == mealPlanningEnabled)&&(identical(other.habitRemindersEnabled, habitRemindersEnabled) || other.habitRemindersEnabled == habitRemindersEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budgetTrackingEnabled,mealPlanningEnabled,habitRemindersEnabled);

@override
String toString() {
  return 'UserPreferences(budgetTrackingEnabled: $budgetTrackingEnabled, mealPlanningEnabled: $mealPlanningEnabled, habitRemindersEnabled: $habitRemindersEnabled)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool budgetTrackingEnabled, bool mealPlanningEnabled, bool habitRemindersEnabled
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? budgetTrackingEnabled = null,Object? mealPlanningEnabled = null,Object? habitRemindersEnabled = null,}) {
  return _then(_UserPreferences(
budgetTrackingEnabled: null == budgetTrackingEnabled ? _self.budgetTrackingEnabled : budgetTrackingEnabled // ignore: cast_nullable_to_non_nullable
as bool,mealPlanningEnabled: null == mealPlanningEnabled ? _self.mealPlanningEnabled : mealPlanningEnabled // ignore: cast_nullable_to_non_nullable
as bool,habitRemindersEnabled: null == habitRemindersEnabled ? _self.habitRemindersEnabled : habitRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationPrefs {

 bool get dailySummary; bool get habitReminders; bool get taskReminders; String get reminderTime;
/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<NotificationPrefs> get copyWith => _$NotificationPrefsCopyWithImpl<NotificationPrefs>(this as NotificationPrefs, _$identity);

  /// Serializes this NotificationPrefs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefs&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.habitReminders, habitReminders) || other.habitReminders == habitReminders)&&(identical(other.taskReminders, taskReminders) || other.taskReminders == taskReminders)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailySummary,habitReminders,taskReminders,reminderTime);

@override
String toString() {
  return 'NotificationPrefs(dailySummary: $dailySummary, habitReminders: $habitReminders, taskReminders: $taskReminders, reminderTime: $reminderTime)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsCopyWith<$Res>  {
  factory $NotificationPrefsCopyWith(NotificationPrefs value, $Res Function(NotificationPrefs) _then) = _$NotificationPrefsCopyWithImpl;
@useResult
$Res call({
 bool dailySummary, bool habitReminders, bool taskReminders, String reminderTime
});




}
/// @nodoc
class _$NotificationPrefsCopyWithImpl<$Res>
    implements $NotificationPrefsCopyWith<$Res> {
  _$NotificationPrefsCopyWithImpl(this._self, this._then);

  final NotificationPrefs _self;
  final $Res Function(NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailySummary = null,Object? habitReminders = null,Object? taskReminders = null,Object? reminderTime = null,}) {
  return _then(_self.copyWith(
dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,habitReminders: null == habitReminders ? _self.habitReminders : habitReminders // ignore: cast_nullable_to_non_nullable
as bool,taskReminders: null == taskReminders ? _self.taskReminders : taskReminders // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPrefs].
extension NotificationPrefsPatterns on NotificationPrefs {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPrefs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPrefs value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPrefs value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs():
return $default(_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPrefs implements NotificationPrefs {
  const _NotificationPrefs({this.dailySummary = true, this.habitReminders = true, this.taskReminders = true, this.reminderTime = '08:00'});
  factory _NotificationPrefs.fromJson(Map<String, dynamic> json) => _$NotificationPrefsFromJson(json);

@override@JsonKey() final  bool dailySummary;
@override@JsonKey() final  bool habitReminders;
@override@JsonKey() final  bool taskReminders;
@override@JsonKey() final  String reminderTime;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsCopyWith<_NotificationPrefs> get copyWith => __$NotificationPrefsCopyWithImpl<_NotificationPrefs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPrefsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefs&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.habitReminders, habitReminders) || other.habitReminders == habitReminders)&&(identical(other.taskReminders, taskReminders) || other.taskReminders == taskReminders)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailySummary,habitReminders,taskReminders,reminderTime);

@override
String toString() {
  return 'NotificationPrefs(dailySummary: $dailySummary, habitReminders: $habitReminders, taskReminders: $taskReminders, reminderTime: $reminderTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsCopyWith<$Res> implements $NotificationPrefsCopyWith<$Res> {
  factory _$NotificationPrefsCopyWith(_NotificationPrefs value, $Res Function(_NotificationPrefs) _then) = __$NotificationPrefsCopyWithImpl;
@override @useResult
$Res call({
 bool dailySummary, bool habitReminders, bool taskReminders, String reminderTime
});




}
/// @nodoc
class __$NotificationPrefsCopyWithImpl<$Res>
    implements _$NotificationPrefsCopyWith<$Res> {
  __$NotificationPrefsCopyWithImpl(this._self, this._then);

  final _NotificationPrefs _self;
  final $Res Function(_NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailySummary = null,Object? habitReminders = null,Object? taskReminders = null,Object? reminderTime = null,}) {
  return _then(_NotificationPrefs(
dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,habitReminders: null == habitReminders ? _self.habitReminders : habitReminders // ignore: cast_nullable_to_non_nullable
as bool,taskReminders: null == taskReminders ? _self.taskReminders : taskReminders // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserProfile {

 String get uid; String? get email; String? get displayName; String? get photoUrl; AuthProviderName get authProvider;@_TimestampConverter() DateTime? get createdAt;@_TimestampConverter() DateTime? get updatedAt; bool get onboardingComplete; String? get timezone; String? get ageRange; String? get occupation; String? get wakeTime; String? get sleepTime; List<String> get primaryGoals; CoachingStyle get coachingStyle; UserPreferences get preferences; NotificationPrefs get notificationPrefs; bool get isPremium;@_TimestampConverter() DateTime? get premiumSince;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.ageRange, ageRange) || other.ageRange == ageRange)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepTime, sleepTime) || other.sleepTime == sleepTime)&&const DeepCollectionEquality().equals(other.primaryGoals, primaryGoals)&&(identical(other.coachingStyle, coachingStyle) || other.coachingStyle == coachingStyle)&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumSince, premiumSince) || other.premiumSince == premiumSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,authProvider,createdAt,updatedAt,onboardingComplete,timezone,ageRange,occupation,wakeTime,sleepTime,const DeepCollectionEquality().hash(primaryGoals),coachingStyle,preferences,notificationPrefs,isPremium,premiumSince]);

@override
String toString() {
  return 'UserProfile(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, authProvider: $authProvider, createdAt: $createdAt, updatedAt: $updatedAt, onboardingComplete: $onboardingComplete, timezone: $timezone, ageRange: $ageRange, occupation: $occupation, wakeTime: $wakeTime, sleepTime: $sleepTime, primaryGoals: $primaryGoals, coachingStyle: $coachingStyle, preferences: $preferences, notificationPrefs: $notificationPrefs, isPremium: $isPremium, premiumSince: $premiumSince)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String uid, String? email, String? displayName, String? photoUrl, AuthProviderName authProvider,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt, bool onboardingComplete, String? timezone, String? ageRange, String? occupation, String? wakeTime, String? sleepTime, List<String> primaryGoals, CoachingStyle coachingStyle, UserPreferences preferences, NotificationPrefs notificationPrefs, bool isPremium,@_TimestampConverter() DateTime? premiumSince
});


$UserPreferencesCopyWith<$Res> get preferences;$NotificationPrefsCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = freezed,Object? displayName = freezed,Object? photoUrl = freezed,Object? authProvider = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? onboardingComplete = null,Object? timezone = freezed,Object? ageRange = freezed,Object? occupation = freezed,Object? wakeTime = freezed,Object? sleepTime = freezed,Object? primaryGoals = null,Object? coachingStyle = null,Object? preferences = null,Object? notificationPrefs = null,Object? isPremium = null,Object? premiumSince = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,authProvider: null == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as AuthProviderName,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,ageRange: freezed == ageRange ? _self.ageRange : ageRange // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as String?,sleepTime: freezed == sleepTime ? _self.sleepTime : sleepTime // ignore: cast_nullable_to_non_nullable
as String?,primaryGoals: null == primaryGoals ? _self.primaryGoals : primaryGoals // ignore: cast_nullable_to_non_nullable
as List<String>,coachingStyle: null == coachingStyle ? _self.coachingStyle : coachingStyle // ignore: cast_nullable_to_non_nullable
as CoachingStyle,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as UserPreferences,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumSince: freezed == premiumSince ? _self.premiumSince : premiumSince // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<$Res> get preferences {
  
  return $UserPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String? email,  String? displayName,  String? photoUrl,  AuthProviderName authProvider, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  bool onboardingComplete,  String? timezone,  String? ageRange,  String? occupation,  String? wakeTime,  String? sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  UserPreferences preferences,  NotificationPrefs notificationPrefs,  bool isPremium, @_TimestampConverter()  DateTime? premiumSince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.authProvider,_that.createdAt,_that.updatedAt,_that.onboardingComplete,_that.timezone,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.preferences,_that.notificationPrefs,_that.isPremium,_that.premiumSince);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String? email,  String? displayName,  String? photoUrl,  AuthProviderName authProvider, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  bool onboardingComplete,  String? timezone,  String? ageRange,  String? occupation,  String? wakeTime,  String? sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  UserPreferences preferences,  NotificationPrefs notificationPrefs,  bool isPremium, @_TimestampConverter()  DateTime? premiumSince)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.authProvider,_that.createdAt,_that.updatedAt,_that.onboardingComplete,_that.timezone,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.preferences,_that.notificationPrefs,_that.isPremium,_that.premiumSince);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String? email,  String? displayName,  String? photoUrl,  AuthProviderName authProvider, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  bool onboardingComplete,  String? timezone,  String? ageRange,  String? occupation,  String? wakeTime,  String? sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  UserPreferences preferences,  NotificationPrefs notificationPrefs,  bool isPremium, @_TimestampConverter()  DateTime? premiumSince)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.authProvider,_that.createdAt,_that.updatedAt,_that.onboardingComplete,_that.timezone,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.preferences,_that.notificationPrefs,_that.isPremium,_that.premiumSince);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.uid, this.email, this.displayName, this.photoUrl, this.authProvider = AuthProviderName.guest, @_TimestampConverter() this.createdAt, @_TimestampConverter() this.updatedAt, this.onboardingComplete = false, this.timezone, this.ageRange, this.occupation, this.wakeTime, this.sleepTime, final  List<String> primaryGoals = const <String>[], this.coachingStyle = CoachingStyle.supportive, this.preferences = const UserPreferences(), this.notificationPrefs = const NotificationPrefs(), this.isPremium = false, @_TimestampConverter() this.premiumSince}): _primaryGoals = primaryGoals;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String uid;
@override final  String? email;
@override final  String? displayName;
@override final  String? photoUrl;
@override@JsonKey() final  AuthProviderName authProvider;
@override@_TimestampConverter() final  DateTime? createdAt;
@override@_TimestampConverter() final  DateTime? updatedAt;
@override@JsonKey() final  bool onboardingComplete;
@override final  String? timezone;
@override final  String? ageRange;
@override final  String? occupation;
@override final  String? wakeTime;
@override final  String? sleepTime;
 final  List<String> _primaryGoals;
@override@JsonKey() List<String> get primaryGoals {
  if (_primaryGoals is EqualUnmodifiableListView) return _primaryGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryGoals);
}

@override@JsonKey() final  CoachingStyle coachingStyle;
@override@JsonKey() final  UserPreferences preferences;
@override@JsonKey() final  NotificationPrefs notificationPrefs;
@override@JsonKey() final  bool isPremium;
@override@_TimestampConverter() final  DateTime? premiumSince;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.ageRange, ageRange) || other.ageRange == ageRange)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepTime, sleepTime) || other.sleepTime == sleepTime)&&const DeepCollectionEquality().equals(other._primaryGoals, _primaryGoals)&&(identical(other.coachingStyle, coachingStyle) || other.coachingStyle == coachingStyle)&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumSince, premiumSince) || other.premiumSince == premiumSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,authProvider,createdAt,updatedAt,onboardingComplete,timezone,ageRange,occupation,wakeTime,sleepTime,const DeepCollectionEquality().hash(_primaryGoals),coachingStyle,preferences,notificationPrefs,isPremium,premiumSince]);

@override
String toString() {
  return 'UserProfile(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, authProvider: $authProvider, createdAt: $createdAt, updatedAt: $updatedAt, onboardingComplete: $onboardingComplete, timezone: $timezone, ageRange: $ageRange, occupation: $occupation, wakeTime: $wakeTime, sleepTime: $sleepTime, primaryGoals: $primaryGoals, coachingStyle: $coachingStyle, preferences: $preferences, notificationPrefs: $notificationPrefs, isPremium: $isPremium, premiumSince: $premiumSince)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String uid, String? email, String? displayName, String? photoUrl, AuthProviderName authProvider,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt, bool onboardingComplete, String? timezone, String? ageRange, String? occupation, String? wakeTime, String? sleepTime, List<String> primaryGoals, CoachingStyle coachingStyle, UserPreferences preferences, NotificationPrefs notificationPrefs, bool isPremium,@_TimestampConverter() DateTime? premiumSince
});


@override $UserPreferencesCopyWith<$Res> get preferences;@override $NotificationPrefsCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = freezed,Object? displayName = freezed,Object? photoUrl = freezed,Object? authProvider = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? onboardingComplete = null,Object? timezone = freezed,Object? ageRange = freezed,Object? occupation = freezed,Object? wakeTime = freezed,Object? sleepTime = freezed,Object? primaryGoals = null,Object? coachingStyle = null,Object? preferences = null,Object? notificationPrefs = null,Object? isPremium = null,Object? premiumSince = freezed,}) {
  return _then(_UserProfile(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,authProvider: null == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as AuthProviderName,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,ageRange: freezed == ageRange ? _self.ageRange : ageRange // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,wakeTime: freezed == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as String?,sleepTime: freezed == sleepTime ? _self.sleepTime : sleepTime // ignore: cast_nullable_to_non_nullable
as String?,primaryGoals: null == primaryGoals ? _self._primaryGoals : primaryGoals // ignore: cast_nullable_to_non_nullable
as List<String>,coachingStyle: null == coachingStyle ? _self.coachingStyle : coachingStyle // ignore: cast_nullable_to_non_nullable
as CoachingStyle,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as UserPreferences,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumSince: freezed == premiumSince ? _self.premiumSince : premiumSince // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<$Res> get preferences {
  
  return $UserPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}

// dart format on
