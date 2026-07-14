// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get title; String? get notes;@_TimestampConverter() DateTime? get dueDate; String? get dueTime; bool get isAllDay; TaskStatus get status; TaskPriority get priority; List<String> get tags; String? get goalId;@_TimestampConverter() DateTime? get createdAt;@_TimestampConverter() DateTime? get updatedAt;@_TimestampConverter() DateTime? get completedAt; String? get reminderId;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.dueTime, dueTime) || other.dueTime == dueTime)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.reminderId, reminderId) || other.reminderId == reminderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,dueDate,dueTime,isAllDay,status,priority,const DeepCollectionEquality().hash(tags),goalId,createdAt,updatedAt,completedAt,reminderId);

@override
String toString() {
  return 'Task(id: $id, title: $title, notes: $notes, dueDate: $dueDate, dueTime: $dueTime, isAllDay: $isAllDay, status: $status, priority: $priority, tags: $tags, goalId: $goalId, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, reminderId: $reminderId)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? notes,@_TimestampConverter() DateTime? dueDate, String? dueTime, bool isAllDay, TaskStatus status, TaskPriority priority, List<String> tags, String? goalId,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt,@_TimestampConverter() DateTime? completedAt, String? reminderId
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? dueDate = freezed,Object? dueTime = freezed,Object? isAllDay = null,Object? status = null,Object? priority = null,Object? tags = null,Object? goalId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? reminderId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTime: freezed == dueTime ? _self.dueTime : dueTime // ignore: cast_nullable_to_non_nullable
as String?,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderId: freezed == reminderId ? _self.reminderId : reminderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? notes, @_TimestampConverter()  DateTime? dueDate,  String? dueTime,  bool isAllDay,  TaskStatus status,  TaskPriority priority,  List<String> tags,  String? goalId, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt,  String? reminderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.dueDate,_that.dueTime,_that.isAllDay,_that.status,_that.priority,_that.tags,_that.goalId,_that.createdAt,_that.updatedAt,_that.completedAt,_that.reminderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? notes, @_TimestampConverter()  DateTime? dueDate,  String? dueTime,  bool isAllDay,  TaskStatus status,  TaskPriority priority,  List<String> tags,  String? goalId, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt,  String? reminderId)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.title,_that.notes,_that.dueDate,_that.dueTime,_that.isAllDay,_that.status,_that.priority,_that.tags,_that.goalId,_that.createdAt,_that.updatedAt,_that.completedAt,_that.reminderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? notes, @_TimestampConverter()  DateTime? dueDate,  String? dueTime,  bool isAllDay,  TaskStatus status,  TaskPriority priority,  List<String> tags,  String? goalId, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt, @_TimestampConverter()  DateTime? completedAt,  String? reminderId)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.dueDate,_that.dueTime,_that.isAllDay,_that.status,_that.priority,_that.tags,_that.goalId,_that.createdAt,_that.updatedAt,_that.completedAt,_that.reminderId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, required this.title, this.notes, @_TimestampConverter() this.dueDate, this.dueTime, this.isAllDay = false, this.status = TaskStatus.todo, this.priority = TaskPriority.medium, final  List<String> tags = const <String>[], this.goalId, @_TimestampConverter() this.createdAt, @_TimestampConverter() this.updatedAt, @_TimestampConverter() this.completedAt, this.reminderId}): _tags = tags,super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? notes;
@override@_TimestampConverter() final  DateTime? dueDate;
@override final  String? dueTime;
@override@JsonKey() final  bool isAllDay;
@override@JsonKey() final  TaskStatus status;
@override@JsonKey() final  TaskPriority priority;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? goalId;
@override@_TimestampConverter() final  DateTime? createdAt;
@override@_TimestampConverter() final  DateTime? updatedAt;
@override@_TimestampConverter() final  DateTime? completedAt;
@override final  String? reminderId;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.dueTime, dueTime) || other.dueTime == dueTime)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.reminderId, reminderId) || other.reminderId == reminderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,notes,dueDate,dueTime,isAllDay,status,priority,const DeepCollectionEquality().hash(_tags),goalId,createdAt,updatedAt,completedAt,reminderId);

@override
String toString() {
  return 'Task(id: $id, title: $title, notes: $notes, dueDate: $dueDate, dueTime: $dueTime, isAllDay: $isAllDay, status: $status, priority: $priority, tags: $tags, goalId: $goalId, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, reminderId: $reminderId)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? notes,@_TimestampConverter() DateTime? dueDate, String? dueTime, bool isAllDay, TaskStatus status, TaskPriority priority, List<String> tags, String? goalId,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt,@_TimestampConverter() DateTime? completedAt, String? reminderId
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? dueDate = freezed,Object? dueTime = freezed,Object? isAllDay = null,Object? status = null,Object? priority = null,Object? tags = null,Object? goalId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? reminderId = freezed,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTime: freezed == dueTime ? _self.dueTime : dueTime // ignore: cast_nullable_to_non_nullable
as String?,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderId: freezed == reminderId ? _self.reminderId : reminderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
