// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingDraft {

 String get displayName; String? get ageRange; String? get occupation; String get wakeTime; String get sleepTime; List<String> get primaryGoals; CoachingStyle get coachingStyle; bool get budgetTrackingEnabled; bool get mealPlanningEnabled; bool get habitRemindersEnabled; bool get dailySummary; bool get habitReminders; bool get taskReminders; String get reminderTime;
/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingDraftCopyWith<OnboardingDraft> get copyWith => _$OnboardingDraftCopyWithImpl<OnboardingDraft>(this as OnboardingDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingDraft&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.ageRange, ageRange) || other.ageRange == ageRange)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepTime, sleepTime) || other.sleepTime == sleepTime)&&const DeepCollectionEquality().equals(other.primaryGoals, primaryGoals)&&(identical(other.coachingStyle, coachingStyle) || other.coachingStyle == coachingStyle)&&(identical(other.budgetTrackingEnabled, budgetTrackingEnabled) || other.budgetTrackingEnabled == budgetTrackingEnabled)&&(identical(other.mealPlanningEnabled, mealPlanningEnabled) || other.mealPlanningEnabled == mealPlanningEnabled)&&(identical(other.habitRemindersEnabled, habitRemindersEnabled) || other.habitRemindersEnabled == habitRemindersEnabled)&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.habitReminders, habitReminders) || other.habitReminders == habitReminders)&&(identical(other.taskReminders, taskReminders) || other.taskReminders == taskReminders)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,ageRange,occupation,wakeTime,sleepTime,const DeepCollectionEquality().hash(primaryGoals),coachingStyle,budgetTrackingEnabled,mealPlanningEnabled,habitRemindersEnabled,dailySummary,habitReminders,taskReminders,reminderTime);

@override
String toString() {
  return 'OnboardingDraft(displayName: $displayName, ageRange: $ageRange, occupation: $occupation, wakeTime: $wakeTime, sleepTime: $sleepTime, primaryGoals: $primaryGoals, coachingStyle: $coachingStyle, budgetTrackingEnabled: $budgetTrackingEnabled, mealPlanningEnabled: $mealPlanningEnabled, habitRemindersEnabled: $habitRemindersEnabled, dailySummary: $dailySummary, habitReminders: $habitReminders, taskReminders: $taskReminders, reminderTime: $reminderTime)';
}


}

/// @nodoc
abstract mixin class $OnboardingDraftCopyWith<$Res>  {
  factory $OnboardingDraftCopyWith(OnboardingDraft value, $Res Function(OnboardingDraft) _then) = _$OnboardingDraftCopyWithImpl;
@useResult
$Res call({
 String displayName, String? ageRange, String? occupation, String wakeTime, String sleepTime, List<String> primaryGoals, CoachingStyle coachingStyle, bool budgetTrackingEnabled, bool mealPlanningEnabled, bool habitRemindersEnabled, bool dailySummary, bool habitReminders, bool taskReminders, String reminderTime
});




}
/// @nodoc
class _$OnboardingDraftCopyWithImpl<$Res>
    implements $OnboardingDraftCopyWith<$Res> {
  _$OnboardingDraftCopyWithImpl(this._self, this._then);

  final OnboardingDraft _self;
  final $Res Function(OnboardingDraft) _then;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? ageRange = freezed,Object? occupation = freezed,Object? wakeTime = null,Object? sleepTime = null,Object? primaryGoals = null,Object? coachingStyle = null,Object? budgetTrackingEnabled = null,Object? mealPlanningEnabled = null,Object? habitRemindersEnabled = null,Object? dailySummary = null,Object? habitReminders = null,Object? taskReminders = null,Object? reminderTime = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,ageRange: freezed == ageRange ? _self.ageRange : ageRange // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,wakeTime: null == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as String,sleepTime: null == sleepTime ? _self.sleepTime : sleepTime // ignore: cast_nullable_to_non_nullable
as String,primaryGoals: null == primaryGoals ? _self.primaryGoals : primaryGoals // ignore: cast_nullable_to_non_nullable
as List<String>,coachingStyle: null == coachingStyle ? _self.coachingStyle : coachingStyle // ignore: cast_nullable_to_non_nullable
as CoachingStyle,budgetTrackingEnabled: null == budgetTrackingEnabled ? _self.budgetTrackingEnabled : budgetTrackingEnabled // ignore: cast_nullable_to_non_nullable
as bool,mealPlanningEnabled: null == mealPlanningEnabled ? _self.mealPlanningEnabled : mealPlanningEnabled // ignore: cast_nullable_to_non_nullable
as bool,habitRemindersEnabled: null == habitRemindersEnabled ? _self.habitRemindersEnabled : habitRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,habitReminders: null == habitReminders ? _self.habitReminders : habitReminders // ignore: cast_nullable_to_non_nullable
as bool,taskReminders: null == taskReminders ? _self.taskReminders : taskReminders // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingDraft].
extension OnboardingDraftPatterns on OnboardingDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingDraft value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingDraft value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? ageRange,  String? occupation,  String wakeTime,  String sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled,  bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
return $default(_that.displayName,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled,_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? ageRange,  String? occupation,  String wakeTime,  String sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled,  bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)  $default,) {final _that = this;
switch (_that) {
case _OnboardingDraft():
return $default(_that.displayName,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled,_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? ageRange,  String? occupation,  String wakeTime,  String sleepTime,  List<String> primaryGoals,  CoachingStyle coachingStyle,  bool budgetTrackingEnabled,  bool mealPlanningEnabled,  bool habitRemindersEnabled,  bool dailySummary,  bool habitReminders,  bool taskReminders,  String reminderTime)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
return $default(_that.displayName,_that.ageRange,_that.occupation,_that.wakeTime,_that.sleepTime,_that.primaryGoals,_that.coachingStyle,_that.budgetTrackingEnabled,_that.mealPlanningEnabled,_that.habitRemindersEnabled,_that.dailySummary,_that.habitReminders,_that.taskReminders,_that.reminderTime);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingDraft implements OnboardingDraft {
  const _OnboardingDraft({this.displayName = '', this.ageRange, this.occupation, this.wakeTime = '07:00', this.sleepTime = '22:30', final  List<String> primaryGoals = const <String>[], this.coachingStyle = CoachingStyle.supportive, this.budgetTrackingEnabled = true, this.mealPlanningEnabled = true, this.habitRemindersEnabled = true, this.dailySummary = true, this.habitReminders = true, this.taskReminders = true, this.reminderTime = '08:00'}): _primaryGoals = primaryGoals;
  

@override@JsonKey() final  String displayName;
@override final  String? ageRange;
@override final  String? occupation;
@override@JsonKey() final  String wakeTime;
@override@JsonKey() final  String sleepTime;
 final  List<String> _primaryGoals;
@override@JsonKey() List<String> get primaryGoals {
  if (_primaryGoals is EqualUnmodifiableListView) return _primaryGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryGoals);
}

@override@JsonKey() final  CoachingStyle coachingStyle;
@override@JsonKey() final  bool budgetTrackingEnabled;
@override@JsonKey() final  bool mealPlanningEnabled;
@override@JsonKey() final  bool habitRemindersEnabled;
@override@JsonKey() final  bool dailySummary;
@override@JsonKey() final  bool habitReminders;
@override@JsonKey() final  bool taskReminders;
@override@JsonKey() final  String reminderTime;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingDraftCopyWith<_OnboardingDraft> get copyWith => __$OnboardingDraftCopyWithImpl<_OnboardingDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingDraft&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.ageRange, ageRange) || other.ageRange == ageRange)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepTime, sleepTime) || other.sleepTime == sleepTime)&&const DeepCollectionEquality().equals(other._primaryGoals, _primaryGoals)&&(identical(other.coachingStyle, coachingStyle) || other.coachingStyle == coachingStyle)&&(identical(other.budgetTrackingEnabled, budgetTrackingEnabled) || other.budgetTrackingEnabled == budgetTrackingEnabled)&&(identical(other.mealPlanningEnabled, mealPlanningEnabled) || other.mealPlanningEnabled == mealPlanningEnabled)&&(identical(other.habitRemindersEnabled, habitRemindersEnabled) || other.habitRemindersEnabled == habitRemindersEnabled)&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.habitReminders, habitReminders) || other.habitReminders == habitReminders)&&(identical(other.taskReminders, taskReminders) || other.taskReminders == taskReminders)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,ageRange,occupation,wakeTime,sleepTime,const DeepCollectionEquality().hash(_primaryGoals),coachingStyle,budgetTrackingEnabled,mealPlanningEnabled,habitRemindersEnabled,dailySummary,habitReminders,taskReminders,reminderTime);

@override
String toString() {
  return 'OnboardingDraft(displayName: $displayName, ageRange: $ageRange, occupation: $occupation, wakeTime: $wakeTime, sleepTime: $sleepTime, primaryGoals: $primaryGoals, coachingStyle: $coachingStyle, budgetTrackingEnabled: $budgetTrackingEnabled, mealPlanningEnabled: $mealPlanningEnabled, habitRemindersEnabled: $habitRemindersEnabled, dailySummary: $dailySummary, habitReminders: $habitReminders, taskReminders: $taskReminders, reminderTime: $reminderTime)';
}


}

/// @nodoc
abstract mixin class _$OnboardingDraftCopyWith<$Res> implements $OnboardingDraftCopyWith<$Res> {
  factory _$OnboardingDraftCopyWith(_OnboardingDraft value, $Res Function(_OnboardingDraft) _then) = __$OnboardingDraftCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? ageRange, String? occupation, String wakeTime, String sleepTime, List<String> primaryGoals, CoachingStyle coachingStyle, bool budgetTrackingEnabled, bool mealPlanningEnabled, bool habitRemindersEnabled, bool dailySummary, bool habitReminders, bool taskReminders, String reminderTime
});




}
/// @nodoc
class __$OnboardingDraftCopyWithImpl<$Res>
    implements _$OnboardingDraftCopyWith<$Res> {
  __$OnboardingDraftCopyWithImpl(this._self, this._then);

  final _OnboardingDraft _self;
  final $Res Function(_OnboardingDraft) _then;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? ageRange = freezed,Object? occupation = freezed,Object? wakeTime = null,Object? sleepTime = null,Object? primaryGoals = null,Object? coachingStyle = null,Object? budgetTrackingEnabled = null,Object? mealPlanningEnabled = null,Object? habitRemindersEnabled = null,Object? dailySummary = null,Object? habitReminders = null,Object? taskReminders = null,Object? reminderTime = null,}) {
  return _then(_OnboardingDraft(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,ageRange: freezed == ageRange ? _self.ageRange : ageRange // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,wakeTime: null == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as String,sleepTime: null == sleepTime ? _self.sleepTime : sleepTime // ignore: cast_nullable_to_non_nullable
as String,primaryGoals: null == primaryGoals ? _self._primaryGoals : primaryGoals // ignore: cast_nullable_to_non_nullable
as List<String>,coachingStyle: null == coachingStyle ? _self.coachingStyle : coachingStyle // ignore: cast_nullable_to_non_nullable
as CoachingStyle,budgetTrackingEnabled: null == budgetTrackingEnabled ? _self.budgetTrackingEnabled : budgetTrackingEnabled // ignore: cast_nullable_to_non_nullable
as bool,mealPlanningEnabled: null == mealPlanningEnabled ? _self.mealPlanningEnabled : mealPlanningEnabled // ignore: cast_nullable_to_non_nullable
as bool,habitRemindersEnabled: null == habitRemindersEnabled ? _self.habitRemindersEnabled : habitRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,habitReminders: null == habitReminders ? _self.habitReminders : habitReminders // ignore: cast_nullable_to_non_nullable
as bool,taskReminders: null == taskReminders ? _self.taskReminders : taskReminders // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
