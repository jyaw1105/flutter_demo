import 'package:flutter/material.dart';

class CategoryBar extends StatefulWidget {
  final bool categoryBarOnTop;
  final List<String>? tags;
  final TabController? tabController;
  const CategoryBar(
      {Key? key, this.categoryBarOnTop = false, this.tags, this.tabController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryBarState();
}

class _CategoryBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final bool categoryBarOnTop;
  final List<String>? tags;
  final TabController? tabController;
  _CategoryBarDelegate(
      {required this.context,
      this.categoryBarOnTop = false,
      this.tags,
      this.tabController});

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // double tempVal = 34 * maxExtent / 100;
    // final progress = (shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal);
    return ClipRRect(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(categoryBarOnTop ? 20 : 0)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            color: categoryBarOnTop
                ? Theme.of(context).primaryColor
                : Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Builder(builder: (_) {
                  if (tags != null) {
                    if (tags!.isEmpty) {
                      return Container();
                    }
                    return TabBar(
                      isScrollable: true,
                      controller: tabController,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      tabs: tags!.map((e) => _tabItem(e)).toList(),
                      indicatorColor: categoryBarOnTop
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      labelColor:
                          categoryBarOnTop ? Colors.white : Colors.black,
                      unselectedLabelColor:
                          categoryBarOnTop ? Colors.black38 : Colors.black54,
                    );
                  }
                  return const CircularProgressIndicator();
                }),
              )
            ],
          ),
        ));
  }

  @override
  bool shouldRebuild(covariant _CategoryBarDelegate oldDelegate) =>
      tags != oldDelegate.tags ||
      categoryBarOnTop != oldDelegate.categoryBarOnTop;

  Widget _tabItem(String title) {
    // Color fontColor = categoryBarOnTop ? Colors.white : Colors.black45;
    return Text(title, style: const TextStyle(fontSize: 14));
  }
}

class _CategoryBarState extends State<CategoryBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: _CategoryBarDelegate(
            context: context,
            categoryBarOnTop: widget.categoryBarOnTop,
            tags: widget.tags,
            tabController: widget.tabController));
  }
}
