import 'package:flutter/material.dart';
import 'package:recipe_demo/home/sections/category/category_item.dart';
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/provider/recipe_provider.dart';
import 'package:recipe_demo/recipe_detail/recipe_detail_page.dart';

class CategoryList extends StatefulWidget {
  final String category;
  const CategoryList({Key? key, required this.category}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Recipe>? recipes;
  int page = 1;
  _CategoryListState() : super();

  String get category => widget.category;

  @override
  Widget build(BuildContext context) {
    return recipes == null
        ? const CircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              children: recipes!.map((recipe) {
                String tag = 'recipe-$category-${recipe.id}';
                return InkWell(
                  child: CategoryItem(
                    recipe: recipe,
                    tag: tag,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          RecipeDetailPage(recipe: recipe, tag: tag))),
                );
              }).toList(),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    recipes = await RecipeProvider.getRecipesByCategory(category);
    setState(() {});
  }
}
