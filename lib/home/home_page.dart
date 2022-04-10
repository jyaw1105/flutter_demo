import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_demo/home/home_appbar.dart';
import 'package:recipe_demo/home/sections/category/category_bar.dart';
import 'package:recipe_demo/home/sections/category/category_list.dart';
import 'package:recipe_demo/home/sections/feature/feature_section.dart';
import 'package:recipe_demo/model/recipe.dart';
import 'package:recipe_demo/provider/recipe_provider.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController controller = ScrollController();

  GlobalKey categoryBarKey = GlobalKey();

  bool categoryBarOnTop = false;

  TabController? tabController;

  List<Recipe>? recipes;
  List<Recipe>? featured;

  List<String>? tags;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: controller,
          slivers: [
            HomeAppBar(categoryBarOnTop: categoryBarOnTop),
            SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                sliver: SliverToBoxAdapter(
                  child: FeatureSection(featured: featured),
                )),
            CategoryBar(
                key: categoryBarKey,
                categoryBarOnTop: categoryBarOnTop,
                tags: tags,
                tabController: tabController),
            SliverFillRemaining(child: Builder(builder: (_) {
              if ((tags ?? []).isEmpty) return Container();
              return TabBarView(
                controller: tabController,
                children: tags!.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CategoryList(category: e),
                  );
                }).toList(),
              );
            }))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _getData();
    controller.addListener(() {
      try {
        RenderSliver? renderBox =
            categoryBarKey.currentContext?.findRenderObject() as RenderSliver;
        Offset offset = MatrixUtils.transformPoint(
            renderBox.getTransformTo(null), Offset.zero);
        bool _onTop = (offset.dy - MediaQuery.of(context).viewPadding.top) ==
            kToolbarHeight;
        if (categoryBarOnTop != _onTop) {
          setState(() => categoryBarOnTop = _onTop);
        }
      } catch (e) {}
    });
  }

  Future<void> _getData() async {
    setState(() {
      featured = [];
      tags = [];
    });
    featured = await RecipeProvider.getFeaturedRecipes();
    tags = await RecipeProvider.getAllCategoryTags();
    tabController = TabController(length: tags!.length, vsync: this);
    setState(() {});
  }
}
