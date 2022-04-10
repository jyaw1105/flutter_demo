import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_demo/home/recipe_item.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeAppBar extends StatefulWidget {
  final bool searchBarOnTop;
  const HomeAppBar({Key? key, this.searchBarOnTop = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _HomeAppBarDelegate(context: context, searchBarOnTop: widget.searchBarOnTop)
    );
  } 
}

class _HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final bool searchBarOnTop;
  _HomeAppBarDelegate({required this.context, this.searchBarOnTop = false});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = (shrinkOffset > tempVal ? 1.0: shrinkOffset / tempVal);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(searchBarOnTop ? 0.0: 20)),
      child: Container(
        width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor
      ),
      child: Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: PlayAnimation<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: kToolbarHeight - 30
                ),
                duration: const Duration(milliseconds: 500),
                // curve: Curves.elasticOut,
                builder: (context, child, double value) {
                  return Image.asset(
                    'assets/logo/logo_white.png',
                    height: value,
                  );
                }),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Opacity(
            opacity: 1 - progress,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: (MediaQuery.of(context).size.width - 30) * (1 - progress),
              alignment: Alignment.center,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.white, width: 3.0)
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  isDense: true
                ),
                style: TextStyle(fontSize: 15),
            ),
          ))
        )
      ],
    )));
  }

  @override
  double get maxExtent => 45 + kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  double get minExtent => kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  bool shouldRebuild(covariant _HomeAppBarDelegate oldDelegate) => searchBarOnTop != oldDelegate.searchBarOnTop;
}