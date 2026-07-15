// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Goal {

 String get id; String get title; String get description; GoalCategory get category;@_TimestampConverter() DateTime? get targetDate; GoalStatus get status; GoalProgressMode get progressMode; num? get manualProgressPercent; num get progressPercent;@_TimestampConverter() DateTime? get createdAt;@_TimestampConverter() DateTime? get updatedAt;@_TimestampConverter() DateTime? get completedAt;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.progressMode, progressMode) || other.progressMode == progressMode)&&(identical(other.manualProgressPercent, manualProgressPercent) || other.manualProgressPercent == manualProgressPercent)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,targetDate,status,progressMode,manualProgressPercent,progressPercent,createdAt,updatedAt,completedAt);

@override
String toString() {
  return 'Goal(id: $id, title: $title, description: $description, category: $category, targetDate: $targetDate, status: $status, progressMode: $progressMode, manualProgressPercent: $manualProgressPercent, progressPercent: $progressPercent, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, GoalCategory category,@_TimestampConverter() DateTime? targetDate, GoalStatus status, GoalProgressMode progressMode, num? manualProgressPercent, num progressPercent,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt,@_TimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? targetDate = freezed,Object? status = null,Object? progressMode = null,Object? manualProgressPercent = freezed,Object? progressPercent = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as GoalCategory,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,progressMode: null == progressMode ? _self.progressMode : progressMode // ignore: cast_nullable_to_non_nullable
as GoalProgressMode,manualProgressPercent: freezed == manualProgressPercent ? _self.manualProgressPercent : manualProgressPercent // ignore: cast_nullable_to_non_nullable
as num?,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as num,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  GoalCategory category, @_TimestampConverter()  DateTime? targetDate,  GoalStatus status,  GoalProgressMode progressMode,  num? manualProgressPercent,  num progressPercent, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.targetDate,_that.status,_that.progressMode,_that.manualProgressPercent,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  GoalCategory category, @_TimestampConverter()  DateTime? targetDate,  GoalStatus status,  GoalProgressMode progressMode,  num? manualProgressPercent,  num progressPercent, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.id,_that.title,_that.description,_that.category,_that.targetDate,_that.status,_that.progressMode,_that.manualProgressPercent,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  GoalCategory category, @_TimestampConverter()  DateTime? targetDate,  GoalStatus status,  GoalProgressMode progressMode,  num? manualProgressPercent,  num progressPercent, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.targetDate,_that.status,_that.progressMode,_that.manualProgressPercent,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Goal extends Goal {
  const _Goal({required this.id, required this.title, this.description = '', this.category = GoalCategory.other, @_TimestampConverter() this.targetDate, this.status = GoalStatus.active, this.progressMode = GoalProgressMode.milestoneBased, this.manualProgressPercent, this.progressPercent = 0, @_TimestampConverter() this.createdAt, @_TimestampConverter() this.updatedAt, @_TimestampConverter() this.completedAt}): super._();
  factory _Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  GoalCategory category;
@override@_TimestampConverter() final  DateTime? targetDate;
@override@JsonKey() final  GoalStatus status;
@override@JsonKey() final  GoalProgressMode progressMode;
@override final  num? manualProgressPercent;
@override@JsonKey() final  num progressPercent;
@override@_TimestampConverter() final  DateTime? createdAt;
@override@_TimestampConverter() final  DateTime? updatedAt;
@override@_TimestampConverter() final  DateTime? completedAt;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.progressMode, progressMode) || other.progressMode == progressMode)&&(identical(other.manualProgressPercent, manualProgressPercent) || other.manualProgressPercent == manualProgressPercent)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,targetDate,status,progressMode,manualProgressPercent,progressPercent,createdAt,updatedAt,completedAt);

@override
String toString() {
  return 'Goal(id: $id, title: $title, description: $description, category: $category, targetDate: $targetDate, status: $status, progressMode: $progressMode, manualProgressPercent: $manualProgressPercent, progressPercent: $progressPercent, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, GoalCategory category,@_TimestampConverter() DateTime? targetDate, GoalStatus status, GoalProgressMode progressMode, num? manualProgressPercent, num progressPercent,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt,@_TimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? targetDate = freezed,Object? status = null,Object? progressMode = null,Object? manualProgressPercent = freezed,Object? progressPercent = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as GoalCategory,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,progressMode: null == progressMode ? _self.progressMode : progressMode // ignore: cast_nullable_to_non_nullable
as GoalProgressMode,manualProgressPercent: freezed == manualProgressPercent ? _self.manualProgressPercent : manualProgressPercent // ignore: cast_nullable_to_non_nullable
as num?,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as num,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
