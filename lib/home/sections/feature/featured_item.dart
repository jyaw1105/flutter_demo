import 'package:flutter/material.dart';
import 'package:recipe_demo/model/recipe.dart';

class FeaturedItem extends StatelessWidget {
  final Recipe recipe;
  final String tag;
  const FeaturedItem({required this.recipe, Key? key, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.black12;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: bgColor.withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(0, 1)),
            BoxShadow(
                color: bgColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, -.5))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned.fill(child: Hero(
                tag: tag,
                child: Image.asset(
                  recipe.imgs.first,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ))),
              Positioned.fill(
                child: Container(
                  color: Colors.black12,
                )
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.white10,
                )
              ),
              // AnimatedContainer(
              //   // scale: scale,
              //   height: MediaQuery.of(context).size.width * 0.7 * scale,
              //   width: MediaQuery.of(context).size.width * 0.7 * scale,
              //   duration: const Duration(milliseconds: 300),
              //   child: Image.asset(
              //     "assets/image/scramble_eggs.png",
              //     // height: MediaQuery.of(context).size.width * 0.7 * scale,
              //     // width: MediaQuery.of(context).size.width * 0.7 * scale,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.name,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
