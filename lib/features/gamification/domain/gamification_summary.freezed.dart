// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gamification_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GamificationSummary {

 int get xp; int get level; int get xpToNextLevel; int get currentStreakDays; int get longestStreakDays;@_TimestampConverter() DateTime? get lastActiveDate; int get habitsCompletedCount; int get tasksCompletedCount; int get goalsCompletedCount;
/// Create a copy of GamificationSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamificationSummaryCopyWith<GamificationSummary> get copyWith => _$GamificationSummaryCopyWithImpl<GamificationSummary>(this as GamificationSummary, _$identity);

  /// Serializes this GamificationSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamificationSummary&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.level, level) || other.level == level)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.currentStreakDays, currentStreakDays) || other.currentStreakDays == currentStreakDays)&&(identical(other.longestStreakDays, longestStreakDays) || other.longestStreakDays == longestStreakDays)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate)&&(identical(other.habitsCompletedCount, habitsCompletedCount) || other.habitsCompletedCount == habitsCompletedCount)&&(identical(other.tasksCompletedCount, tasksCompletedCount) || other.tasksCompletedCount == tasksCompletedCount)&&(identical(other.goalsCompletedCount, goalsCompletedCount) || other.goalsCompletedCount == goalsCompletedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,xp,level,xpToNextLevel,currentStreakDays,longestStreakDays,lastActiveDate,habitsCompletedCount,tasksCompletedCount,goalsCompletedCount);

@override
String toString() {
  return 'GamificationSummary(xp: $xp, level: $level, xpToNextLevel: $xpToNextLevel, currentStreakDays: $currentStreakDays, longestStreakDays: $longestStreakDays, lastActiveDate: $lastActiveDate, habitsCompletedCount: $habitsCompletedCount, tasksCompletedCount: $tasksCompletedCount, goalsCompletedCount: $goalsCompletedCount)';
}


}

/// @nodoc
abstract mixin class $GamificationSummaryCopyWith<$Res>  {
  factory $GamificationSummaryCopyWith(GamificationSummary value, $Res Function(GamificationSummary) _then) = _$GamificationSummaryCopyWithImpl;
@useResult
$Res call({
 int xp, int level, int xpToNextLevel, int currentStreakDays, int longestStreakDays,@_TimestampConverter() DateTime? lastActiveDate, int habitsCompletedCount, int tasksCompletedCount, int goalsCompletedCount
});




}
/// @nodoc
class _$GamificationSummaryCopyWithImpl<$Res>
    implements $GamificationSummaryCopyWith<$Res> {
  _$GamificationSummaryCopyWithImpl(this._self, this._then);

  final GamificationSummary _self;
  final $Res Function(GamificationSummary) _then;

/// Create a copy of GamificationSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? xp = null,Object? level = null,Object? xpToNextLevel = null,Object? currentStreakDays = null,Object? longestStreakDays = null,Object? lastActiveDate = freezed,Object? habitsCompletedCount = null,Object? tasksCompletedCount = null,Object? goalsCompletedCount = null,}) {
  return _then(_self.copyWith(
xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,currentStreakDays: null == currentStreakDays ? _self.currentStreakDays : currentStreakDays // ignore: cast_nullable_to_non_nullable
as int,longestStreakDays: null == longestStreakDays ? _self.longestStreakDays : longestStreakDays // ignore: cast_nullable_to_non_nullable
as int,lastActiveDate: freezed == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime?,habitsCompletedCount: null == habitsCompletedCount ? _self.habitsCompletedCount : habitsCompletedCount // ignore: cast_nullable_to_non_nullable
as int,tasksCompletedCount: null == tasksCompletedCount ? _self.tasksCompletedCount : tasksCompletedCount // ignore: cast_nullable_to_non_nullable
as int,goalsCompletedCount: null == goalsCompletedCount ? _self.goalsCompletedCount : goalsCompletedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GamificationSummary].
extension GamificationSummaryPatterns on GamificationSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GamificationSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GamificationSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GamificationSummary value)  $default,){
final _that = this;
switch (_that) {
case _GamificationSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GamificationSummary value)?  $default,){
final _that = this;
switch (_that) {
case _GamificationSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int xp,  int level,  int xpToNextLevel,  int currentStreakDays,  int longestStreakDays, @_TimestampConverter()  DateTime? lastActiveDate,  int habitsCompletedCount,  int tasksCompletedCount,  int goalsCompletedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GamificationSummary() when $default != null:
return $default(_that.xp,_that.level,_that.xpToNextLevel,_that.currentStreakDays,_that.longestStreakDays,_that.lastActiveDate,_that.habitsCompletedCount,_that.tasksCompletedCount,_that.goalsCompletedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int xp,  int level,  int xpToNextLevel,  int currentStreakDays,  int longestStreakDays, @_TimestampConverter()  DateTime? lastActiveDate,  int habitsCompletedCount,  int tasksCompletedCount,  int goalsCompletedCount)  $default,) {final _that = this;
switch (_that) {
case _GamificationSummary():
return $default(_that.xp,_that.level,_that.xpToNextLevel,_that.currentStreakDays,_that.longestStreakDays,_that.lastActiveDate,_that.habitsCompletedCount,_that.tasksCompletedCount,_that.goalsCompletedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int xp,  int level,  int xpToNextLevel,  int currentStreakDays,  int longestStreakDays, @_TimestampConverter()  DateTime? lastActiveDate,  int habitsCompletedCount,  int tasksCompletedCount,  int goalsCompletedCount)?  $default,) {final _that = this;
switch (_that) {
case _GamificationSummary() when $default != null:
return $default(_that.xp,_that.level,_that.xpToNextLevel,_that.currentStreakDays,_that.longestStreakDays,_that.lastActiveDate,_that.habitsCompletedCount,_that.tasksCompletedCount,_that.goalsCompletedCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GamificationSummary implements GamificationSummary {
  const _GamificationSummary({this.xp = 0, this.level = 1, this.xpToNextLevel = 100, this.currentStreakDays = 0, this.longestStreakDays = 0, @_TimestampConverter() this.lastActiveDate, this.habitsCompletedCount = 0, this.tasksCompletedCount = 0, this.goalsCompletedCount = 0});
  factory _GamificationSummary.fromJson(Map<String, dynamic> json) => _$GamificationSummaryFromJson(json);

@override@JsonKey() final  int xp;
@override@JsonKey() final  int level;
@override@JsonKey() final  int xpToNextLevel;
@override@JsonKey() final  int currentStreakDays;
@override@JsonKey() final  int longestStreakDays;
@override@_TimestampConverter() final  DateTime? lastActiveDate;
@override@JsonKey() final  int habitsCompletedCount;
@override@JsonKey() final  int tasksCompletedCount;
@override@JsonKey() final  int goalsCompletedCount;

/// Create a copy of GamificationSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GamificationSummaryCopyWith<_GamificationSummary> get copyWith => __$GamificationSummaryCopyWithImpl<_GamificationSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GamificationSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GamificationSummary&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.level, level) || other.level == level)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.currentStreakDays, currentStreakDays) || other.currentStreakDays == currentStreakDays)&&(identical(other.longestStreakDays, longestStreakDays) || other.longestStreakDays == longestStreakDays)&&(identical(other.lastActiveDate, lastActiveDate) || other.lastActiveDate == lastActiveDate)&&(identical(other.habitsCompletedCount, habitsCompletedCount) || other.habitsCompletedCount == habitsCompletedCount)&&(identical(other.tasksCompletedCount, tasksCompletedCount) || other.tasksCompletedCount == tasksCompletedCount)&&(identical(other.goalsCompletedCount, goalsCompletedCount) || other.goalsCompletedCount == goalsCompletedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,xp,level,xpToNextLevel,currentStreakDays,longestStreakDays,lastActiveDate,habitsCompletedCount,tasksCompletedCount,goalsCompletedCount);

@override
String toString() {
  return 'GamificationSummary(xp: $xp, level: $level, xpToNextLevel: $xpToNextLevel, currentStreakDays: $currentStreakDays, longestStreakDays: $longestStreakDays, lastActiveDate: $lastActiveDate, habitsCompletedCount: $habitsCompletedCount, tasksCompletedCount: $tasksCompletedCount, goalsCompletedCount: $goalsCompletedCount)';
}


}

/// @nodoc
abstract mixin class _$GamificationSummaryCopyWith<$Res> implements $GamificationSummaryCopyWith<$Res> {
  factory _$GamificationSummaryCopyWith(_GamificationSummary value, $Res Function(_GamificationSummary) _then) = __$GamificationSummaryCopyWithImpl;
@override @useResult
$Res call({
 int xp, int level, int xpToNextLevel, int currentStreakDays, int longestStreakDays,@_TimestampConverter() DateTime? lastActiveDate, int habitsCompletedCount, int tasksCompletedCount, int goalsCompletedCount
});




}
/// @nodoc
class __$GamificationSummaryCopyWithImpl<$Res>
    implements _$GamificationSummaryCopyWith<$Res> {
  __$GamificationSummaryCopyWithImpl(this._self, this._then);

  final _GamificationSummary _self;
  final $Res Function(_GamificationSummary) _then;

/// Create a copy of GamificationSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? xp = null,Object? level = null,Object? xpToNextLevel = null,Object? currentStreakDays = null,Object? longestStreakDays = null,Object? lastActiveDate = freezed,Object? habitsCompletedCount = null,Object? tasksCompletedCount = null,Object? goalsCompletedCount = null,}) {
  return _then(_GamificationSummary(
xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,currentStreakDays: null == currentStreakDays ? _self.currentStreakDays : currentStreakDays // ignore: cast_nullable_to_non_nullable
as int,longestStreakDays: null == longestStreakDays ? _self.longestStreakDays : longestStreakDays // ignore: cast_nullable_to_non_nullable
as int,lastActiveDate: freezed == lastActiveDate ? _self.lastActiveDate : lastActiveDate // ignore: cast_nullable_to_non_nullable
as DateTime?,habitsCompletedCount: null == habitsCompletedCount ? _self.habitsCompletedCount : habitsCompletedCount // ignore: cast_nullable_to_non_nullable
as int,tasksCompletedCount: null == tasksCompletedCount ? _self.tasksCompletedCount : tasksCompletedCount // ignore: cast_nullable_to_non_nullable
as int,goalsCompletedCount: null == goalsCompletedCount ? _self.goalsCompletedCount : goalsCompletedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
