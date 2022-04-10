import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_demo/home/recipe_item.dart';
import 'package:recipe_demo/widgets/snapping_scroll_physic.dart';
import 'package:simple_animations/simple_animations.dart';

class SearchBar extends StatefulWidget {
  final bool searchBarOnTop;
  final ValueNotifier<String> categoryNotifer;
  const SearchBar({Key? key, this.searchBarOnTop = false, required this.categoryNotifer}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: _SearchBarDelegate(context: context, searchBarOnTop: widget.searchBarOnTop, categoryNotifer: widget.categoryNotifer)
    );
  } 
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final bool searchBarOnTop;
  final ValueNotifier<String> categoryNotifer;
  _SearchBarDelegate({required this.context, this.searchBarOnTop = false, required this.categoryNotifer});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = (shrinkOffset > tempVal ? 1.0: shrinkOffset / tempVal);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: searchBarOnTop ? Theme.of(context).primaryColor: Colors.white,
        ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: SnappingListScrollPhysic(
                itemWidth: 100
              ),
              children: [
                _tabItem("Breakfast"),
                _tabItem("Lunch"),
                _tabItem("Dinner"),
                _tabItem("Egg"),
                _tabItem("Cheese"),
                _tabItem("Breakfast"),
                _tabItem("Breakfast"),
              ],
            ),
          )
        ],
      ),)
    );
  }

  Widget _tabItem(String title) => InkWell(
    child: SizedBox.fromSize(
      size: Size(100, 50),
      child: Text(title),
    ),
    onTap: () => categoryNotifer.value = title,
  );

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) => searchBarOnTop != oldDelegate.searchBarOnTop;
}