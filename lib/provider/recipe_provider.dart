import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/provider/constant.dart';

class RecipeProvider {
  static List<Recipe>? recipes;

  static Future<List<Recipe>> getAllRecipes() async {
    if (recipes == null) {
      List<dynamic> data =
          jsonDecode(await rootBundle.loadString(recipeJSON)) as List<dynamic>;
      recipes = data.map<Recipe>((e) => Recipe.fromJson(e)).toList();
    }
    return List.from(recipes!);
  }

  static Future<List<Recipe>> getFeaturedRecipes() async {
    List<Recipe> list = await getAllRecipes();
    list.removeWhere((element) => !element.featured);
    return list;
  }

  static Future<List<String>> getAllCategoryTags() async {
    List<Recipe> list = await getAllRecipes();
    return list
        .map((e) => e.category)
        .toList()
        .expand((x) => x)
        .toList()
        .toSet()
        .toList();
  }

  static Future<List<Recipe>> getRecipesByCategory(String category) async {
    List<Recipe> list = await getAllRecipes();
    list.removeWhere((element) => !element.category.contains(category));
    return list;
  }

  static Future<List<Recipe>> getSimilarRecipes(Recipe recipe) async {
    List<Recipe> list = await getAllRecipes();
    list.retainWhere((element) =>
        element.category.any((x) => recipe.category.contains(x)) &&
        element.id != recipe.id);
    list.shuffle();
    return list.take(defaultSimularCount).toList();
  }

  static Future<List<Recipe>> getSearchResults(String keyword) async {
    if (keyword.isEmpty) {
      return [];
    }
    List<Recipe> list = await getAllRecipes();
    list.retainWhere((element) =>
        element.name.toLowerCase().contains(keyword.toLowerCase()) ||
        element.category
            .map((e) => e.toLowerCase())
            .toList()
            .contains(keyword.toLowerCase()) ||
        element.utils
            .map((e) => e.toLowerCase())
            .toList()
            .contains(keyword.toLowerCase()) ||
        element.ingredients
            .map((e) => e.toLowerCase())
            .toList()
            .contains(keyword.toLowerCase()));
    return list;
  }
}
