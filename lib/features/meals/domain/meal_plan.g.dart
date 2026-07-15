// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MealPlan _$MealPlanFromJson(Map<String, dynamic> json) => _MealPlan(
  id: json['id'] as String,
  weekStartDate: const _TimestampConverter().fromJson(json['weekStartDate']),
  days:
      (json['days'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, String?>.from(e as Map)),
      ) ??
      const <String, Map<String, String?>>{},
);

Map<String, dynamic> _$MealPlanToJson(_MealPlan instance) => <String, dynamic>{
  'id': instance.id,
  'weekStartDate': const _TimestampConverter().toJson(instance.weekStartDate),
  'days': instance.days,
};
