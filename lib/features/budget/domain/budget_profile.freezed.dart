// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BudgetProfile {

 String get currency; num get monthlyIncomeTarget; num get monthlyBudgetTarget; List<BudgetCategory> get categories;
/// Create a copy of BudgetProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetProfileCopyWith<BudgetProfile> get copyWith => _$BudgetProfileCopyWithImpl<BudgetProfile>(this as BudgetProfile, _$identity);

  /// Serializes this BudgetProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetProfile&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.monthlyIncomeTarget, monthlyIncomeTarget) || other.monthlyIncomeTarget == monthlyIncomeTarget)&&(identical(other.monthlyBudgetTarget, monthlyBudgetTarget) || other.monthlyBudgetTarget == monthlyBudgetTarget)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,monthlyIncomeTarget,monthlyBudgetTarget,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'BudgetProfile(currency: $currency, monthlyIncomeTarget: $monthlyIncomeTarget, monthlyBudgetTarget: $monthlyBudgetTarget, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $BudgetProfileCopyWith<$Res>  {
  factory $BudgetProfileCopyWith(BudgetProfile value, $Res Function(BudgetProfile) _then) = _$BudgetProfileCopyWithImpl;
@useResult
$Res call({
 String currency, num monthlyIncomeTarget, num monthlyBudgetTarget, List<BudgetCategory> categories
});




}
/// @nodoc
class _$BudgetProfileCopyWithImpl<$Res>
    implements $BudgetProfileCopyWith<$Res> {
  _$BudgetProfileCopyWithImpl(this._self, this._then);

  final BudgetProfile _self;
  final $Res Function(BudgetProfile) _then;

/// Create a copy of BudgetProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? monthlyIncomeTarget = null,Object? monthlyBudgetTarget = null,Object? categories = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,monthlyIncomeTarget: null == monthlyIncomeTarget ? _self.monthlyIncomeTarget : monthlyIncomeTarget // ignore: cast_nullable_to_non_nullable
as num,monthlyBudgetTarget: null == monthlyBudgetTarget ? _self.monthlyBudgetTarget : monthlyBudgetTarget // ignore: cast_nullable_to_non_nullable
as num,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<BudgetCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetProfile].
extension BudgetProfilePatterns on BudgetProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetProfile value)  $default,){
final _that = this;
switch (_that) {
case _BudgetProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency,  num monthlyIncomeTarget,  num monthlyBudgetTarget,  List<BudgetCategory> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetProfile() when $default != null:
return $default(_that.currency,_that.monthlyIncomeTarget,_that.monthlyBudgetTarget,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency,  num monthlyIncomeTarget,  num monthlyBudgetTarget,  List<BudgetCategory> categories)  $default,) {final _that = this;
switch (_that) {
case _BudgetProfile():
return $default(_that.currency,_that.monthlyIncomeTarget,_that.monthlyBudgetTarget,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency,  num monthlyIncomeTarget,  num monthlyBudgetTarget,  List<BudgetCategory> categories)?  $default,) {final _that = this;
switch (_that) {
case _BudgetProfile() when $default != null:
return $default(_that.currency,_that.monthlyIncomeTarget,_that.monthlyBudgetTarget,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetProfile extends BudgetProfile {
  const _BudgetProfile({this.currency = 'USD', this.monthlyIncomeTarget = 0, this.monthlyBudgetTarget = 2000, final  List<BudgetCategory> categories = const <BudgetCategory>[]}): _categories = categories,super._();
  factory _BudgetProfile.fromJson(Map<String, dynamic> json) => _$BudgetProfileFromJson(json);

@override@JsonKey() final  String currency;
@override@JsonKey() final  num monthlyIncomeTarget;
@override@JsonKey() final  num monthlyBudgetTarget;
 final  List<BudgetCategory> _categories;
@override@JsonKey() List<BudgetCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of BudgetProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetProfileCopyWith<_BudgetProfile> get copyWith => __$BudgetProfileCopyWithImpl<_BudgetProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetProfile&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.monthlyIncomeTarget, monthlyIncomeTarget) || other.monthlyIncomeTarget == monthlyIncomeTarget)&&(identical(other.monthlyBudgetTarget, monthlyBudgetTarget) || other.monthlyBudgetTarget == monthlyBudgetTarget)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,monthlyIncomeTarget,monthlyBudgetTarget,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'BudgetProfile(currency: $currency, monthlyIncomeTarget: $monthlyIncomeTarget, monthlyBudgetTarget: $monthlyBudgetTarget, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$BudgetProfileCopyWith<$Res> implements $BudgetProfileCopyWith<$Res> {
  factory _$BudgetProfileCopyWith(_BudgetProfile value, $Res Function(_BudgetProfile) _then) = __$BudgetProfileCopyWithImpl;
@override @useResult
$Res call({
 String currency, num monthlyIncomeTarget, num monthlyBudgetTarget, List<BudgetCategory> categories
});




}
/// @nodoc
class __$BudgetProfileCopyWithImpl<$Res>
    implements _$BudgetProfileCopyWith<$Res> {
  __$BudgetProfileCopyWithImpl(this._self, this._then);

  final _BudgetProfile _self;
  final $Res Function(_BudgetProfile) _then;

/// Create a copy of BudgetProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? monthlyIncomeTarget = null,Object? monthlyBudgetTarget = null,Object? categories = null,}) {
  return _then(_BudgetProfile(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,monthlyIncomeTarget: null == monthlyIncomeTarget ? _self.monthlyIncomeTarget : monthlyIncomeTarget // ignore: cast_nullable_to_non_nullable
as num,monthlyBudgetTarget: null == monthlyBudgetTarget ? _self.monthlyBudgetTarget : monthlyBudgetTarget // ignore: cast_nullable_to_non_nullable
as num,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<BudgetCategory>,
  ));
}


}

// dart format on
