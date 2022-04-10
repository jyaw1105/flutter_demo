// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'cooking_time',
      'cooking_time_unit',
      'imgs',
      'serving_min_size',
      'created_by',
      'created_date'
    ],
  );
  return Recipe(
    id: json['id'] as int,
    name: json['name'] as String,
    desc: json['desc'] as String,
    cookingTime: json['cooking_time'] as String? ?? '',
    cookingTimeUnit: json['cooking_time_unit'] as String? ?? '',
    imgs: (json['imgs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
        [],
    servingMinSize: json['serving_min_size'] as int? ?? 1,
    servingMaxSize: json['serving_max_size'] as int?,
    createdBy: json['created_by'] as int,
    createdDate: DateTime.parse(json['created_date'] as String),
    featured: json['featured'] as bool,
    category:
        (json['category'] as List<dynamic>).map((e) => e as String).toList(),
    utils: (json['utils'] as List<dynamic>).map((e) => e as String).toList(),
    ingredients:
        (json['ingredients'] as List<dynamic>).map((e) => e as String).toList(),
    steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
    tips: (json['tips'] as List<dynamic>?)
        ?.map((e) => Tip.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'cooking_time': instance.cookingTime,
      'cooking_time_unit': instance.cookingTimeUnit,
      'imgs': instance.imgs,
      'serving_min_size': instance.servingMinSize,
      'serving_max_size': instance.servingMaxSize,
      'created_by': instance.createdBy,
      'created_date': instance.createdDate.toIso8601String(),
      'featured': instance.featured,
      'category': instance.category,
      'utils': instance.utils,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'tips': instance.tips,
    };
