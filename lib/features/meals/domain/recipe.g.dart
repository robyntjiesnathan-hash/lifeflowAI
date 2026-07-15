// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  name: json['name'] as String,
  quantity: (json['quantity'] as num?)?.toDouble() ?? 1,
  unit: json['unit'] as String? ?? '',
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
  id: json['id'] as String,
  title: json['title'] as String,
  prepMinutes: (json['prepMinutes'] as num?)?.toInt() ?? 15,
  servings: (json['servings'] as num?)?.toInt() ?? 2,
  category:
      $enumDecodeNullable(_$RecipeCategoryEnumMap, json['category']) ??
      RecipeCategory.general,
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Ingredient>[],
  instructions:
      (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  calories: (json['calories'] as num?)?.toInt(),
  proteinGrams: (json['proteinGrams'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'prepMinutes': instance.prepMinutes,
  'servings': instance.servings,
  'category': _$RecipeCategoryEnumMap[instance.category]!,
  'ingredients': instance.ingredients,
  'instructions': instance.instructions,
  'tags': instance.tags,
  'calories': instance.calories,
  'proteinGrams': instance.proteinGrams,
};

const _$RecipeCategoryEnumMap = {
  RecipeCategory.general: 'general',
  RecipeCategory.healthy: 'healthy',
  RecipeCategory.budget: 'budget',
  RecipeCategory.quick: 'quick',
};
