import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_demo/model/tip.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final int id;
  final String name, desc;
  @JsonKey(name: 'cooking_time', defaultValue: '', required: true)
  final String cookingTime;
  @JsonKey(name: 'cooking_time_unit', defaultValue: '', required: true)
  final String cookingTimeUnit;

  @JsonKey(name: 'imgs', defaultValue: [], required: true)
  final List<String> imgs;
  @JsonKey(name: 'serving_min_size', defaultValue: 1, required: true)
  final int servingMinSize;
  @JsonKey(name: 'serving_max_size')
  final int? servingMaxSize;
  @JsonKey(name: 'created_by', required: true)
  final int createdBy;
  @JsonKey(name: 'created_date', required: true)
  final DateTime createdDate;
  final bool featured;
  final List<String> category;
  final List<String> utils, ingredients, steps;
  final List<Tip>? tips;

  Recipe(
      {required this.id,
      required this.name,
      required this.desc,
      required this.cookingTime,
      required this.cookingTimeUnit,
      required this.imgs,
      required this.servingMinSize,
      this.servingMaxSize,
      required this.createdBy,
      required this.createdDate,
      required this.featured,
      required this.category,
      required this.utils,
      required this.ingredients,
      required this.steps,
      this.tips});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  String get cookingTimeString {
    return "$cookingTime $cookingTimeUnit";
  }

  String servingSizeString({bool withUnit = true}) {
    String _unit = withUnit ? 'person(s)' : '';
    if (servingMinSize == (servingMaxSize ?? servingMinSize)) {
      return "$servingMinSize $_unit";
    }
    return "$servingMinSize - $servingMaxSize $_unit";
  }

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
