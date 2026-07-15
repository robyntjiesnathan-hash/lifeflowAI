// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earned_badge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarnedBadge {

 String get badgeDefinitionId;@_TimestampConverter() DateTime? get earnedAt;
/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnedBadgeCopyWith<EarnedBadge> get copyWith => _$EarnedBadgeCopyWithImpl<EarnedBadge>(this as EarnedBadge, _$identity);

  /// Serializes this EarnedBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnedBadge&&(identical(other.badgeDefinitionId, badgeDefinitionId) || other.badgeDefinitionId == badgeDefinitionId)&&(identical(other.earnedAt, earnedAt) || other.earnedAt == earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,badgeDefinitionId,earnedAt);

@override
String toString() {
  return 'EarnedBadge(badgeDefinitionId: $badgeDefinitionId, earnedAt: $earnedAt)';
}


}

/// @nodoc
abstract mixin class $EarnedBadgeCopyWith<$Res>  {
  factory $EarnedBadgeCopyWith(EarnedBadge value, $Res Function(EarnedBadge) _then) = _$EarnedBadgeCopyWithImpl;
@useResult
$Res call({
 String badgeDefinitionId,@_TimestampConverter() DateTime? earnedAt
});




}
/// @nodoc
class _$EarnedBadgeCopyWithImpl<$Res>
    implements $EarnedBadgeCopyWith<$Res> {
  _$EarnedBadgeCopyWithImpl(this._self, this._then);

  final EarnedBadge _self;
  final $Res Function(EarnedBadge) _then;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? badgeDefinitionId = null,Object? earnedAt = freezed,}) {
  return _then(_self.copyWith(
badgeDefinitionId: null == badgeDefinitionId ? _self.badgeDefinitionId : badgeDefinitionId // ignore: cast_nullable_to_non_nullable
as String,earnedAt: freezed == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnedBadge].
extension EarnedBadgePatterns on EarnedBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnedBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnedBadge value)  $default,){
final _that = this;
switch (_that) {
case _EarnedBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnedBadge value)?  $default,){
final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String badgeDefinitionId, @_TimestampConverter()  DateTime? earnedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
return $default(_that.badgeDefinitionId,_that.earnedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String badgeDefinitionId, @_TimestampConverter()  DateTime? earnedAt)  $default,) {final _that = this;
switch (_that) {
case _EarnedBadge():
return $default(_that.badgeDefinitionId,_that.earnedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String badgeDefinitionId, @_TimestampConverter()  DateTime? earnedAt)?  $default,) {final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
return $default(_that.badgeDefinitionId,_that.earnedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarnedBadge implements EarnedBadge {
  const _EarnedBadge({required this.badgeDefinitionId, @_TimestampConverter() this.earnedAt});
  factory _EarnedBadge.fromJson(Map<String, dynamic> json) => _$EarnedBadgeFromJson(json);

@override final  String badgeDefinitionId;
@override@_TimestampConverter() final  DateTime? earnedAt;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnedBadgeCopyWith<_EarnedBadge> get copyWith => __$EarnedBadgeCopyWithImpl<_EarnedBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarnedBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnedBadge&&(identical(other.badgeDefinitionId, badgeDefinitionId) || other.badgeDefinitionId == badgeDefinitionId)&&(identical(other.earnedAt, earnedAt) || other.earnedAt == earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,badgeDefinitionId,earnedAt);

@override
String toString() {
  return 'EarnedBadge(badgeDefinitionId: $badgeDefinitionId, earnedAt: $earnedAt)';
}


}

/// @nodoc
abstract mixin class _$EarnedBadgeCopyWith<$Res> implements $EarnedBadgeCopyWith<$Res> {
  factory _$EarnedBadgeCopyWith(_EarnedBadge value, $Res Function(_EarnedBadge) _then) = __$EarnedBadgeCopyWithImpl;
@override @useResult
$Res call({
 String badgeDefinitionId,@_TimestampConverter() DateTime? earnedAt
});




}
/// @nodoc
class __$EarnedBadgeCopyWithImpl<$Res>
    implements _$EarnedBadgeCopyWith<$Res> {
  __$EarnedBadgeCopyWithImpl(this._self, this._then);

  final _EarnedBadge _self;
  final $Res Function(_EarnedBadge) _then;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? badgeDefinitionId = null,Object? earnedAt = freezed,}) {
  return _then(_EarnedBadge(
badgeDefinitionId: null == badgeDefinitionId ? _self.badgeDefinitionId : badgeDefinitionId // ignore: cast_nullable_to_non_nullable
as String,earnedAt: freezed == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
