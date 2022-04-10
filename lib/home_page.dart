import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_demo/home/home_appbar.dart';
import 'package:recipe_demo/home/recipe_item.dart';
import 'package:recipe_demo/home/search_bar.dart';
import 'package:recipe_demo/widgets/snapping_scroll_physic.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
// import 'package:vector_math/vector_math.dart' as vm;

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();

  GlobalKey searchBarKey = GlobalKey();

  bool searchBarOnTop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: controller,
        slivers: [
          HomeAppBar(
            searchBarOnTop: searchBarOnTop
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              sliver: SliverToBoxAdapter(
                child: FutureBuilder(
                    future: _getData(),
                    builder: (_, __) {
                      return CarouselSlider(
                          items: [RecipeItem(), RecipeItem()],
                          options: CarouselOptions(
                            height:
                                MediaQuery.of(context).size.width * 0.7 + 50,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            onPageChanged:
                                (int page, CarouselPageChangedReason reason) {},
                          ));
                    }),
              )),
          SearchBar(
            key: searchBarKey,
            searchBarOnTop: searchBarOnTop,
            categoryNotifer: categoryNotifer
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: categoryNotifer, 
              builder: (_, String cat, ___) {
                return Column(
                  children: [
                    Text(cat)
                  ],
                );
              }
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ValueListenableBuilder(
                  valueListenable: categoryNotifer, 
                  builder: (_, String cat, ___) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(cat)
                        ],
                      ),
                    );
                  }
                );
              },
              childCount: 1
            ),
          ),
          SliverFillRemaining(
            child: Container()
          )
        ],
      )
    );
  }

  ValueNotifier<String> categoryNotifer = ValueNotifier<String>("Breakfast");

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      try{
        RenderSliver? renderBox = searchBarKey.currentContext?.findRenderObject() as RenderSliver;
        Offset offset = MatrixUtils.transformPoint(renderBox.getTransformTo(null), Offset.zero);
        bool _onTop = offset.dy == kToolbarHeight;
        if(searchBarOnTop != _onTop) {
          setState(() => searchBarOnTop = _onTop);
        }
      }catch(e){}
    });
  }

  Future<void> _getData() async {}
}
