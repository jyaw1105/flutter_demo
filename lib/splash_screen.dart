import 'package:flutter/material.dart';
import 'package:recipe_demo/home_page.dart';
import 'package:simple_animations/simple_animations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
            future: _navTo(context),
            builder: (_, __) => Center(
                  child: PlayAnimation<Size?>(
                      tween: SizeTween(
                          begin: Size.zero,
                          end: Size.square(MediaQuery.of(context).size.width *
                              0.6)), // define tween
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      builder: (context, child, value) {
                        return SizedBox.fromSize(
                            size: value,
                            child: Image.asset('assets/logo/logo_white.png'));
                      }),
                )));
  }

  Future<void> _navTo(BuildContext context) =>
      Future.delayed(const Duration(milliseconds: 1800)).then((value) =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const HomePage(title: "Recipe Demo"))));
}
