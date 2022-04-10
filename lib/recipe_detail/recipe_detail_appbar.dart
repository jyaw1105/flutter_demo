import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class RecipeAppBar extends StatefulWidget {
  final int id;
  final String name;
  final List<String> imgs;
  final String tag;
  const RecipeAppBar(
      {Key? key,
      required this.id,
      required this.name,
      required this.imgs,
      required this.tag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeAppBarState();
}

class _RecipeAppBarState extends State<RecipeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _RecipeAppBarStateDelegate(
            context: context,
            id: widget.id,
            name: widget.name,
            imgs: widget.imgs,
            tag: widget.tag));
  }
}

class _RecipeAppBarStateDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final int id;
  final String name;
  final List<String> imgs;
  final String tag;
  final _titleMarginTween = EdgeInsetsTween(
      begin: const EdgeInsets.only(left: 0),
      end: const EdgeInsets.only(left: 40.0));
  _RecipeAppBarStateDelegate(
      {required this.context,
      required this.id,
      required this.name,
      required this.imgs,
      required this.tag});
  @override
  double get maxExtent =>
      250 + kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  double get minExtent =>
      kToolbarHeight + MediaQuery.of(context).viewPadding.top;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = (shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal);
    final titleMargin = _titleMarginTween.lerp(progress);
    double tempVal1 = 95 * maxExtent / 100;
    final progress1 = (shrinkOffset > tempVal1 ? 1.0 : shrinkOffset / tempVal1);

    return ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Stack(
              children: [
                Opacity(
                  opacity: 1 - progress,
                  child: CarouselSlider(
                      items: imgs
                          .asMap()
                          .map<int, Widget>((index, String value) {
                            Widget _img = Container(
                              width: MediaQuery.of(context).size.width,
                              height: 250 +
                                  kToolbarHeight +
                                  MediaQuery.of(context).viewPadding.top,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(value),
                                      fit: BoxFit.contain)),
                            );
                            if (index == 0) {
                              _img = Hero(tag: tag, child: _img);
                            }
                            return MapEntry(index, _img);
                          })
                          .values
                          .toList(),
                      options: CarouselOptions(
                        height: maxExtent,
                        enableInfiniteScroll: false,
                      )),
                ),
                Positioned(
                    bottom: 10,
                    left: 20,
                    child: Padding(
                        padding: titleMargin,
                        child: PlayAnimation<double>(
                            tween: Tween<double>(
                                begin: 0, end: kToolbarHeight - 30),
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                            // curve: Curves.elasticOut,
                            builder: (context, child, double value) => Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )))),
                Positioned(
                    left: 40 - titleMargin.left,
                    bottom: 5,
                    child: Opacity(
                        opacity: progress1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )))
              ],
            )));
  }

  @override
  bool shouldRebuild(covariant _RecipeAppBarStateDelegate oldDelegate) =>
      tag != oldDelegate.tag;
}
