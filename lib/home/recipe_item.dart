import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).primaryColor;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: bgColor.withOpacity(0.3),
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(0, 1)),
            BoxShadow(
                color: bgColor.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, -.5))
          ],
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    "assets/image/scramble_eggs.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
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
              Row(
                children: const [
                  Expanded(
                    child: Text("Scrambled Egges",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
