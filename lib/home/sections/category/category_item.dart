import 'package:flutter/material.dart';
import 'package:recipe_demo/model/recipe.dart';

class CategoryItem extends StatelessWidget {
  final Recipe recipe;
  final String tag;
  const CategoryItem({Key? key, required this.recipe, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _img = Hero(
      tag: tag,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
        child: Image.asset(
        recipe.imgs.first,
        width: 150,
      )),
    );

    const TextStyle titleTextStyle = TextStyle(fontSize: 15);
    const TextStyle timeTextStyle = TextStyle(
        fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38);
    const TextStyle sizeTextStyle = TextStyle(
        fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38);
    return Card(
      elevation: 3.0,
      shadowColor: Colors.black26.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _img,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: titleTextStyle,
                  ),
                  Text(
                    recipe.cookingTimeString,
                    style: timeTextStyle,
                  ),
                  Text(
                    recipe.servingSizeString(),
                    style: sizeTextStyle,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
