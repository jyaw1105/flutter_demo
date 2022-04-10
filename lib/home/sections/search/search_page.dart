import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_demo/home/sections/category/category_item.dart';
import 'package:recipe_demo/home/sections/search/search_bar.dart';
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/provider/recipe_provider.dart';
import 'package:recipe_demo/recipe_detail/recipe_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget _appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text("Search"),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: SearchBar(controller: controller),
        ),
      ),
    );

    Widget _empty = Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "No Recipes found",
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ));

    return Scaffold(
      appBar: _appBar,
      body: FutureBuilder(
        future: RecipeProvider.getSearchResults(controller.text),
        builder: (_, __) {
          if (__.connectionState == ConnectionState.done) {
            List<Recipe> recipes = __.data as List<Recipe>;
            if (controller.text.isEmpty) {
              return const SizedBox();
            }
            if (recipes.isEmpty) {
              return _empty;
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: recipes.map((recipe) {
                  String tag = 'recipe-search-${recipe.id}';
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
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }
}
