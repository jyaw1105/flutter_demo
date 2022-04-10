import 'package:flutter/material.dart';
import 'package:recipe_demo/home/sections/search/search_bar.dart';
import 'package:recipe_demo/home/sections/search/search_page.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeAppBar extends StatefulWidget {
  final bool categoryBarOnTop;
  const HomeAppBar({Key? key, this.categoryBarOnTop = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeAppBarState();
}

class _HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final bool categoryBarOnTop;
  _HomeAppBarDelegate({required this.context, this.categoryBarOnTop = false});
  @override
  double get maxExtent =>
      60 + kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  double get minExtent =>
      kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = (shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal);
    Widget _logo = SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: PlayAnimation<double>(
                tween: Tween<double>(begin: 0, end: kToolbarHeight - 30),
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
    );

    return ClipRRect(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(categoryBarOnTop ? 0.0 : 20)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Stack(
              children: [
                _logo,
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Opacity(
                      opacity: 1 - progress,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                        alignment: Alignment.center,
                        child: SearchBar(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => SearchPage()))),
                      )),
                )
              ],
            )));
  }

  @override
  bool shouldRebuild(covariant _HomeAppBarDelegate oldDelegate) =>
      categoryBarOnTop != oldDelegate.categoryBarOnTop;
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _HomeAppBarDelegate(
            context: context, categoryBarOnTop: widget.categoryBarOnTop));
  }
}
