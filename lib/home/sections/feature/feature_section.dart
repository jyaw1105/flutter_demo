import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_demo/home/sections/feature/featured_item.dart';
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/recipe_detail/recipe_detail_page.dart';

class FeatureSection extends StatelessWidget {
  final List<Recipe>? featured;
  const FeatureSection({Key? key, this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      if (featured != null) {
        if (featured!.isEmpty) {
          return const SizedBox();
        }
        return CarouselSlider(
            items: featured!.map((e) {
              String tag = 'feature-${e.id}';
              return InkWell(
                child: FeaturedItem(recipe: e, tag: tag),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(recipe: e, tag: tag))),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.7 + 50,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (int page, CarouselPageChangedReason reason) {},
            ));
      }
      return const CircularProgressIndicator();
    });
  }
}
