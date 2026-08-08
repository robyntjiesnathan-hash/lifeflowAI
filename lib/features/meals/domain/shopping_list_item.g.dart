// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShoppingListItem _$ShoppingListItemFromJson(Map<String, dynamic> json) =>
    _ShoppingListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1,
      unit: json['unit'] as String? ?? '',
      isChecked: json['isChecked'] as bool? ?? false,
      sourceMealPlanId: json['sourceMealPlanId'] as String?,
      addedAt: const _TimestampConverter().fromJson(json['addedAt']),
    );

Map<String, dynamic> _$ShoppingListItemToJson(_ShoppingListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'isChecked': instance.isChecked,
      'sourceMealPlanId': instance.sourceMealPlanId,
      'addedAt': const _TimestampConverter().toJson(instance.addedAt),
    };
