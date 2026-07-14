// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BudgetTransaction {

 String get id; TransactionType get type; num get amount; String get currency; String? get categoryId; String? get note;@_TimestampConverter() DateTime? get date; bool get isRecurring; RecurrenceRule get recurrenceRule;@_TimestampConverter() DateTime? get createdAt;
/// Create a copy of BudgetTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetTransactionCopyWith<BudgetTransaction> get copyWith => _$BudgetTransactionCopyWithImpl<BudgetTransaction>(this as BudgetTransaction, _$identity);

  /// Serializes this BudgetTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,currency,categoryId,note,date,isRecurring,recurrenceRule,createdAt);

@override
String toString() {
  return 'BudgetTransaction(id: $id, type: $type, amount: $amount, currency: $currency, categoryId: $categoryId, note: $note, date: $date, isRecurring: $isRecurring, recurrenceRule: $recurrenceRule, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BudgetTransactionCopyWith<$Res>  {
  factory $BudgetTransactionCopyWith(BudgetTransaction value, $Res Function(BudgetTransaction) _then) = _$BudgetTransactionCopyWithImpl;
@useResult
$Res call({
 String id, TransactionType type, num amount, String currency, String? categoryId, String? note,@_TimestampConverter() DateTime? date, bool isRecurring, RecurrenceRule recurrenceRule,@_TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$BudgetTransactionCopyWithImpl<$Res>
    implements $BudgetTransactionCopyWith<$Res> {
  _$BudgetTransactionCopyWithImpl(this._self, this._then);

  final BudgetTransaction _self;
  final $Res Function(BudgetTransaction) _then;

/// Create a copy of BudgetTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? currency = null,Object? categoryId = freezed,Object? note = freezed,Object? date = freezed,Object? isRecurring = null,Object? recurrenceRule = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrenceRule: null == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetTransaction].
extension BudgetTransactionPatterns on BudgetTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetTransaction value)  $default,){
final _that = this;
switch (_that) {
case _BudgetTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TransactionType type,  num amount,  String currency,  String? categoryId,  String? note, @_TimestampConverter()  DateTime? date,  bool isRecurring,  RecurrenceRule recurrenceRule, @_TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetTransaction() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.categoryId,_that.note,_that.date,_that.isRecurring,_that.recurrenceRule,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TransactionType type,  num amount,  String currency,  String? categoryId,  String? note, @_TimestampConverter()  DateTime? date,  bool isRecurring,  RecurrenceRule recurrenceRule, @_TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BudgetTransaction():
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.categoryId,_that.note,_that.date,_that.isRecurring,_that.recurrenceRule,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TransactionType type,  num amount,  String currency,  String? categoryId,  String? note, @_TimestampConverter()  DateTime? date,  bool isRecurring,  RecurrenceRule recurrenceRule, @_TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BudgetTransaction() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.categoryId,_that.note,_that.date,_that.isRecurring,_that.recurrenceRule,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetTransaction extends BudgetTransaction {
  const _BudgetTransaction({required this.id, this.type = TransactionType.expense, required this.amount, this.currency = 'USD', this.categoryId, this.note, @_TimestampConverter() this.date, this.isRecurring = false, this.recurrenceRule = RecurrenceRule.none, @_TimestampConverter() this.createdAt}): super._();
  factory _BudgetTransaction.fromJson(Map<String, dynamic> json) => _$BudgetTransactionFromJson(json);

@override final  String id;
@override@JsonKey() final  TransactionType type;
@override final  num amount;
@override@JsonKey() final  String currency;
@override final  String? categoryId;
@override final  String? note;
@override@_TimestampConverter() final  DateTime? date;
@override@JsonKey() final  bool isRecurring;
@override@JsonKey() final  RecurrenceRule recurrenceRule;
@override@_TimestampConverter() final  DateTime? createdAt;

/// Create a copy of BudgetTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetTransactionCopyWith<_BudgetTransaction> get copyWith => __$BudgetTransactionCopyWithImpl<_BudgetTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,currency,categoryId,note,date,isRecurring,recurrenceRule,createdAt);

@override
String toString() {
  return 'BudgetTransaction(id: $id, type: $type, amount: $amount, currency: $currency, categoryId: $categoryId, note: $note, date: $date, isRecurring: $isRecurring, recurrenceRule: $recurrenceRule, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BudgetTransactionCopyWith<$Res> implements $BudgetTransactionCopyWith<$Res> {
  factory _$BudgetTransactionCopyWith(_BudgetTransaction value, $Res Function(_BudgetTransaction) _then) = __$BudgetTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, TransactionType type, num amount, String currency, String? categoryId, String? note,@_TimestampConverter() DateTime? date, bool isRecurring, RecurrenceRule recurrenceRule,@_TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$BudgetTransactionCopyWithImpl<$Res>
    implements _$BudgetTransactionCopyWith<$Res> {
  __$BudgetTransactionCopyWithImpl(this._self, this._then);

  final _BudgetTransaction _self;
  final $Res Function(_BudgetTransaction) _then;

/// Create a copy of BudgetTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? currency = null,Object? categoryId = freezed,Object? note = freezed,Object? date = freezed,Object? isRecurring = null,Object? recurrenceRule = null,Object? createdAt = freezed,}) {
  return _then(_BudgetTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrenceRule: null == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
