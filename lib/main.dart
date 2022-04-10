import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_demo/home/home_page.dart';
import 'package:recipe_demo/utils/material_color.dart';

void main() async {
  // await DBProvider.db.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(const Color(0xffD88F9A)),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Recipe Demo'), //const SplashScreen()//
    );
  }
}
