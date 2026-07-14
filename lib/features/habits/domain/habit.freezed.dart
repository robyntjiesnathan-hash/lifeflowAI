// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Habit {

 String get id; String get name; HabitIconKey get iconKey; String get colorHex; HabitFrequency get frequency; List<int> get customDays; int get targetPerPeriod; String? get reminderTime; String? get subtitle;@_TimestampConverter() DateTime? get createdAt;@_TimestampConverter() DateTime? get archivedAt; int get currentStreak; int get longestStreak;@_TimestampConverter() DateTime? get lastCompletedDate;
/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitCopyWith<Habit> get copyWith => _$HabitCopyWithImpl<Habit>(this as Habit, _$identity);

  /// Serializes this Habit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Habit&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&const DeepCollectionEquality().equals(other.customDays, customDays)&&(identical(other.targetPerPeriod, targetPerPeriod) || other.targetPerPeriod == targetPerPeriod)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastCompletedDate, lastCompletedDate) || other.lastCompletedDate == lastCompletedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconKey,colorHex,frequency,const DeepCollectionEquality().hash(customDays),targetPerPeriod,reminderTime,subtitle,createdAt,archivedAt,currentStreak,longestStreak,lastCompletedDate);

@override
String toString() {
  return 'Habit(id: $id, name: $name, iconKey: $iconKey, colorHex: $colorHex, frequency: $frequency, customDays: $customDays, targetPerPeriod: $targetPerPeriod, reminderTime: $reminderTime, subtitle: $subtitle, createdAt: $createdAt, archivedAt: $archivedAt, currentStreak: $currentStreak, longestStreak: $longestStreak, lastCompletedDate: $lastCompletedDate)';
}


}

/// @nodoc
abstract mixin class $HabitCopyWith<$Res>  {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) _then) = _$HabitCopyWithImpl;
@useResult
$Res call({
 String id, String name, HabitIconKey iconKey, String colorHex, HabitFrequency frequency, List<int> customDays, int targetPerPeriod, String? reminderTime, String? subtitle,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? archivedAt, int currentStreak, int longestStreak,@_TimestampConverter() DateTime? lastCompletedDate
});




}
/// @nodoc
class _$HabitCopyWithImpl<$Res>
    implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._self, this._then);

  final Habit _self;
  final $Res Function(Habit) _then;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconKey = null,Object? colorHex = null,Object? frequency = null,Object? customDays = null,Object? targetPerPeriod = null,Object? reminderTime = freezed,Object? subtitle = freezed,Object? createdAt = freezed,Object? archivedAt = freezed,Object? currentStreak = null,Object? longestStreak = null,Object? lastCompletedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as HabitIconKey,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as HabitFrequency,customDays: null == customDays ? _self.customDays : customDays // ignore: cast_nullable_to_non_nullable
as List<int>,targetPerPeriod: null == targetPerPeriod ? _self.targetPerPeriod : targetPerPeriod // ignore: cast_nullable_to_non_nullable
as int,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastCompletedDate: freezed == lastCompletedDate ? _self.lastCompletedDate : lastCompletedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Habit].
extension HabitPatterns on Habit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Habit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Habit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Habit value)  $default,){
final _that = this;
switch (_that) {
case _Habit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Habit value)?  $default,){
final _that = this;
switch (_that) {
case _Habit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  HabitIconKey iconKey,  String colorHex,  HabitFrequency frequency,  List<int> customDays,  int targetPerPeriod,  String? reminderTime,  String? subtitle, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? archivedAt,  int currentStreak,  int longestStreak, @_TimestampConverter()  DateTime? lastCompletedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Habit() when $default != null:
return $default(_that.id,_that.name,_that.iconKey,_that.colorHex,_that.frequency,_that.customDays,_that.targetPerPeriod,_that.reminderTime,_that.subtitle,_that.createdAt,_that.archivedAt,_that.currentStreak,_that.longestStreak,_that.lastCompletedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  HabitIconKey iconKey,  String colorHex,  HabitFrequency frequency,  List<int> customDays,  int targetPerPeriod,  String? reminderTime,  String? subtitle, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? archivedAt,  int currentStreak,  int longestStreak, @_TimestampConverter()  DateTime? lastCompletedDate)  $default,) {final _that = this;
switch (_that) {
case _Habit():
return $default(_that.id,_that.name,_that.iconKey,_that.colorHex,_that.frequency,_that.customDays,_that.targetPerPeriod,_that.reminderTime,_that.subtitle,_that.createdAt,_that.archivedAt,_that.currentStreak,_that.longestStreak,_that.lastCompletedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  HabitIconKey iconKey,  String colorHex,  HabitFrequency frequency,  List<int> customDays,  int targetPerPeriod,  String? reminderTime,  String? subtitle, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? archivedAt,  int currentStreak,  int longestStreak, @_TimestampConverter()  DateTime? lastCompletedDate)?  $default,) {final _that = this;
switch (_that) {
case _Habit() when $default != null:
return $default(_that.id,_that.name,_that.iconKey,_that.colorHex,_that.frequency,_that.customDays,_that.targetPerPeriod,_that.reminderTime,_that.subtitle,_that.createdAt,_that.archivedAt,_that.currentStreak,_that.longestStreak,_that.lastCompletedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Habit extends Habit {
  const _Habit({required this.id, required this.name, this.iconKey = HabitIconKey.custom, this.colorHex = '#8B5CF6', this.frequency = HabitFrequency.daily, final  List<int> customDays = const <int>[], this.targetPerPeriod = 1, this.reminderTime, this.subtitle, @_TimestampConverter() this.createdAt, @_TimestampConverter() this.archivedAt, this.currentStreak = 0, this.longestStreak = 0, @_TimestampConverter() this.lastCompletedDate}): _customDays = customDays,super._();
  factory _Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  HabitIconKey iconKey;
@override@JsonKey() final  String colorHex;
@override@JsonKey() final  HabitFrequency frequency;
 final  List<int> _customDays;
@override@JsonKey() List<int> get customDays {
  if (_customDays is EqualUnmodifiableListView) return _customDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customDays);
}

@override@JsonKey() final  int targetPerPeriod;
@override final  String? reminderTime;
@override final  String? subtitle;
@override@_TimestampConverter() final  DateTime? createdAt;
@override@_TimestampConverter() final  DateTime? archivedAt;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int longestStreak;
@override@_TimestampConverter() final  DateTime? lastCompletedDate;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitCopyWith<_Habit> get copyWith => __$HabitCopyWithImpl<_Habit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HabitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Habit&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&const DeepCollectionEquality().equals(other._customDays, _customDays)&&(identical(other.targetPerPeriod, targetPerPeriod) || other.targetPerPeriod == targetPerPeriod)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastCompletedDate, lastCompletedDate) || other.lastCompletedDate == lastCompletedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconKey,colorHex,frequency,const DeepCollectionEquality().hash(_customDays),targetPerPeriod,reminderTime,subtitle,createdAt,archivedAt,currentStreak,longestStreak,lastCompletedDate);

@override
String toString() {
  return 'Habit(id: $id, name: $name, iconKey: $iconKey, colorHex: $colorHex, frequency: $frequency, customDays: $customDays, targetPerPeriod: $targetPerPeriod, reminderTime: $reminderTime, subtitle: $subtitle, createdAt: $createdAt, archivedAt: $archivedAt, currentStreak: $currentStreak, longestStreak: $longestStreak, lastCompletedDate: $lastCompletedDate)';
}


}

/// @nodoc
abstract mixin class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) _then) = __$HabitCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, HabitIconKey iconKey, String colorHex, HabitFrequency frequency, List<int> customDays, int targetPerPeriod, String? reminderTime, String? subtitle,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? archivedAt, int currentStreak, int longestStreak,@_TimestampConverter() DateTime? lastCompletedDate
});




}
/// @nodoc
class __$HabitCopyWithImpl<$Res>
    implements _$HabitCopyWith<$Res> {
  __$HabitCopyWithImpl(this._self, this._then);

  final _Habit _self;
  final $Res Function(_Habit) _then;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconKey = null,Object? colorHex = null,Object? frequency = null,Object? customDays = null,Object? targetPerPeriod = null,Object? reminderTime = freezed,Object? subtitle = freezed,Object? createdAt = freezed,Object? archivedAt = freezed,Object? currentStreak = null,Object? longestStreak = null,Object? lastCompletedDate = freezed,}) {
  return _then(_Habit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as HabitIconKey,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as HabitFrequency,customDays: null == customDays ? _self._customDays : customDays // ignore: cast_nullable_to_non_nullable
as List<int>,targetPerPeriod: null == targetPerPeriod ? _self.targetPerPeriod : targetPerPeriod // ignore: cast_nullable_to_non_nullable
as int,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastCompletedDate: freezed == lastCompletedDate ? _self.lastCompletedDate : lastCompletedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
