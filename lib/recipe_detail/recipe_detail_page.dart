import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/provider/recipe_provider.dart';
import 'package:recipe_demo/recipe_detail/recipe_detail_appbar.dart';
import 'package:recipe_demo/recipe_detail/recipe_similar_item.dart';
import 'package:recipe_demo/widgets/snapping_scroll_physic.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final String tag;
  const RecipeDetailPage({Key? key, required this.recipe, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle detailTextStyle =
        const TextStyle(fontSize: 15, color: Colors.black54);
    TextStyle hintTextStyle = const TextStyle(fontSize: 12);
    const String collapsedHint = 'Show More';
    const String expandedHint = 'ShowLess';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RecipeAppBar(
            id: recipe.id,
            name: recipe.name,
            imgs: recipe.imgs,
            tag: tag,
          ),
          SliverSafeArea(
              top: false,
              sliver: SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  _label("Cooking Time"),
                  Text(recipe.cookingTimeString, style: detailTextStyle),
                  _label("Serving Size"),
                  Text(recipe.servingSizeString(), style: detailTextStyle),
                  _label("Description"),
                  ExpandText(
                    recipe.desc,
                    textAlign: TextAlign.justify,
                    collapsedHint: collapsedHint,
                    expandedHint: expandedHint,
                    expandArrowStyle: ExpandArrowStyle.text,
                    hintTextStyle: hintTextStyle,
                    hideArrowOnExpanded: true,
                    style: detailTextStyle,
                  ),
                  _label("Category"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: recipe.category
                            .map((e) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Text(
                                    e,
                                    style: detailTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ))
                            .toList()),
                  ),
                  _label("Utensils"),
                  ExpandText(
                    recipe.utils.join("\n"),
                    textAlign: TextAlign.justify,
                    collapsedHint: collapsedHint,
                    expandedHint: expandedHint,
                    expandArrowStyle: ExpandArrowStyle.text,
                    hintTextStyle: hintTextStyle,
                    maxLines: 4,
                    hideArrowOnExpanded: true,
                    style: detailTextStyle,
                  ),
                  _label("Ingredients"),
                  ExpandText(
                    recipe.ingredients.join("\n"),
                    textAlign: TextAlign.justify,
                    collapsedHint: collapsedHint,
                    expandedHint: expandedHint,
                    expandArrowStyle: ExpandArrowStyle.text,
                    hintTextStyle: hintTextStyle,
                    maxLines: 4,
                    hideArrowOnExpanded: true,
                    style: detailTextStyle,
                  ),
                  _label("Steps"),
                  ExpandText(
                    recipe.steps
                        .asMap()
                        .map(
                            (key, value) => MapEntry(key, "${key + 1}. $value"))
                        .values
                        .toList()
                        .join("\n"),
                    textAlign: TextAlign.justify,
                    collapsedHint: collapsedHint,
                    expandedHint: expandedHint,
                    expandArrowStyle: ExpandArrowStyle.text,
                    hintTextStyle: hintTextStyle,
                    maxLines: 8,
                    hideArrowOnExpanded: true,
                    style: detailTextStyle,
                  ),
                  if ((recipe.tips ?? []).isNotEmpty)
                    Builder(
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("Tips"),
                            ...recipe.tips!
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(e.title,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Text(
                                          e.desc,
                                          style: detailTextStyle,
                                        )
                                      ],
                                    ))
                                .toList(),
                          ],
                        );
                      },
                    ),
                  FutureBuilder(
                      future: RecipeProvider.getSimilarRecipes(recipe),
                      builder: (_, __) {
                        if (((__.data ?? []) as List<Recipe>).isNotEmpty) {
                          List<Recipe> similars = __.data as List<Recipe>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("Similars"),
                              IntrinsicHeight(
                                child: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: similars.map((e) {
                                      String _tag = 'similar-${recipe.id}';
                                      return InkWell(
                                        child: SimilarItem(
                                            recipe: recipe, tag: _tag),
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RecipeDetailPage(
                                                        recipe: e, tag: _tag))),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return const SizedBox();
                      })
                ])),
              )),
        ],
      ),
    );
  }

  Widget _label(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 20),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
}
