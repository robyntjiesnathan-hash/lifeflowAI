// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiConversation {

 String get id; String get title;@_TimestampConverter() DateTime? get createdAt;@_TimestampConverter() DateTime? get updatedAt; String get lastMessagePreview;
/// Create a copy of AiConversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiConversationCopyWith<AiConversation> get copyWith => _$AiConversationCopyWithImpl<AiConversation>(this as AiConversation, _$identity);

  /// Serializes this AiConversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiConversation&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,updatedAt,lastMessagePreview);

@override
String toString() {
  return 'AiConversation(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, lastMessagePreview: $lastMessagePreview)';
}


}

/// @nodoc
abstract mixin class $AiConversationCopyWith<$Res>  {
  factory $AiConversationCopyWith(AiConversation value, $Res Function(AiConversation) _then) = _$AiConversationCopyWithImpl;
@useResult
$Res call({
 String id, String title,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt, String lastMessagePreview
});




}
/// @nodoc
class _$AiConversationCopyWithImpl<$Res>
    implements $AiConversationCopyWith<$Res> {
  _$AiConversationCopyWithImpl(this._self, this._then);

  final AiConversation _self;
  final $Res Function(AiConversation) _then;

/// Create a copy of AiConversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastMessagePreview = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiConversation].
extension AiConversationPatterns on AiConversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiConversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiConversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiConversation value)  $default,){
final _that = this;
switch (_that) {
case _AiConversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiConversation value)?  $default,){
final _that = this;
switch (_that) {
case _AiConversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  String lastMessagePreview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiConversation() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.lastMessagePreview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  String lastMessagePreview)  $default,) {final _that = this;
switch (_that) {
case _AiConversation():
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.lastMessagePreview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @_TimestampConverter()  DateTime? createdAt, @_TimestampConverter()  DateTime? updatedAt,  String lastMessagePreview)?  $default,) {final _that = this;
switch (_that) {
case _AiConversation() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.lastMessagePreview);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiConversation extends AiConversation {
  const _AiConversation({required this.id, this.title = 'New chat', @_TimestampConverter() this.createdAt, @_TimestampConverter() this.updatedAt, this.lastMessagePreview = ''}): super._();
  factory _AiConversation.fromJson(Map<String, dynamic> json) => _$AiConversationFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override@_TimestampConverter() final  DateTime? createdAt;
@override@_TimestampConverter() final  DateTime? updatedAt;
@override@JsonKey() final  String lastMessagePreview;

/// Create a copy of AiConversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiConversationCopyWith<_AiConversation> get copyWith => __$AiConversationCopyWithImpl<_AiConversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiConversationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiConversation&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,updatedAt,lastMessagePreview);

@override
String toString() {
  return 'AiConversation(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, lastMessagePreview: $lastMessagePreview)';
}


}

/// @nodoc
abstract mixin class _$AiConversationCopyWith<$Res> implements $AiConversationCopyWith<$Res> {
  factory _$AiConversationCopyWith(_AiConversation value, $Res Function(_AiConversation) _then) = __$AiConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@_TimestampConverter() DateTime? createdAt,@_TimestampConverter() DateTime? updatedAt, String lastMessagePreview
});




}
/// @nodoc
class __$AiConversationCopyWithImpl<$Res>
    implements _$AiConversationCopyWith<$Res> {
  __$AiConversationCopyWithImpl(this._self, this._then);

  final _AiConversation _self;
  final $Res Function(_AiConversation) _then;

/// Create a copy of AiConversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastMessagePreview = null,}) {
  return _then(_AiConversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
