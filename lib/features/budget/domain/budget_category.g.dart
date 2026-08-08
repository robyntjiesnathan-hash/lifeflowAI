// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetCategory _$BudgetCategoryFromJson(Map<String, dynamic> json) =>
    _BudgetCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      iconKey:
          $enumDecodeNullable(
            _$BudgetCategoryIconKeyEnumMap,
            json['iconKey'],
          ) ??
          BudgetCategoryIconKey.other,
      colorHex: json['colorHex'] as String? ?? '#8B5CF6',
      monthlyLimit: json['monthlyLimit'] as num? ?? 0,
    );

Map<String, dynamic> _$BudgetCategoryToJson(_BudgetCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconKey': _$BudgetCategoryIconKeyEnumMap[instance.iconKey]!,
      'colorHex': instance.colorHex,
      'monthlyLimit': instance.monthlyLimit,
    };

const _$BudgetCategoryIconKeyEnumMap = {
  BudgetCategoryIconKey.housing: 'housing',
  BudgetCategoryIconKey.food: 'food',
  BudgetCategoryIconKey.transport: 'transport',
  BudgetCategoryIconKey.entertainment: 'entertainment',
  BudgetCategoryIconKey.shopping: 'shopping',
  BudgetCategoryIconKey.health: 'health',
  BudgetCategoryIconKey.other: 'other',
};
