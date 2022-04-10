import 'package:flutter/material.dart';
import 'package:recipe_demo/model/recipe.dart';

class SimilarItem extends StatelessWidget {
  final Recipe recipe;
  final String tag;
  const SimilarItem({
    required this.recipe,
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        margin: const EdgeInsets.only(right: 15),
        elevation: 3.0,
        shadowColor: Colors.black26.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: Hero(
                  tag: tag,
                  child: Image.asset(
                    recipe.imgs.first,
                    fit: BoxFit.cover,
                    height: 170,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(fontSize: 15),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.cookingTimeString,
                          style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.black38),
                        ),
                      ),
                      Text(
                        recipe.servingSizeString(withUnit: false),
                        style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.black38),
                      ),
                      const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
