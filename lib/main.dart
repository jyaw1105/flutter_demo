import 'package:flutter/material.dart';
import 'package:recipe_demo/home_page.dart';
import 'package:recipe_demo/splash_screen.dart';
import 'package:recipe_demo/utils/material_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(const Color(0xffD88F9A)),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Recipe Demo'),//const SplashScreen()//
    );
  }
}
