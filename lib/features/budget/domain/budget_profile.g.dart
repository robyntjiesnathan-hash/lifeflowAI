// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetProfile _$BudgetProfileFromJson(Map<String, dynamic> json) =>
    _BudgetProfile(
      currency: json['currency'] as String? ?? 'USD',
      monthlyIncomeTarget: json['monthlyIncomeTarget'] as num? ?? 0,
      monthlyBudgetTarget: json['monthlyBudgetTarget'] as num? ?? 2000,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => BudgetCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BudgetCategory>[],
    );

Map<String, dynamic> _$BudgetProfileToJson(_BudgetProfile instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'monthlyIncomeTarget': instance.monthlyIncomeTarget,
      'monthlyBudgetTarget': instance.monthlyBudgetTarget,
      'categories': instance.categories,
    };
