// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetTransaction _$BudgetTransactionFromJson(Map<String, dynamic> json) =>
    _BudgetTransaction(
      id: json['id'] as String,
      type:
          $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
          TransactionType.expense,
      amount: json['amount'] as num,
      currency: json['currency'] as String? ?? 'USD',
      categoryId: json['categoryId'] as String?,
      note: json['note'] as String?,
      date: const _TimestampConverter().fromJson(json['date']),
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurrenceRule:
          $enumDecodeNullable(
            _$RecurrenceRuleEnumMap,
            json['recurrenceRule'],
          ) ??
          RecurrenceRule.none,
      createdAt: const _TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$BudgetTransactionToJson(_BudgetTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'categoryId': instance.categoryId,
      'note': instance.note,
      'date': const _TimestampConverter().toJson(instance.date),
      'isRecurring': instance.isRecurring,
      'recurrenceRule': _$RecurrenceRuleEnumMap[instance.recurrenceRule]!,
      'createdAt': const _TimestampConverter().toJson(instance.createdAt),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};

const _$RecurrenceRuleEnumMap = {
  RecurrenceRule.none: 'none',
  RecurrenceRule.weekly: 'weekly',
  RecurrenceRule.monthly: 'monthly',
};
