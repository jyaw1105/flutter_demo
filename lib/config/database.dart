// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:convert';

// // import 'package:aes_crypt/aes_crypt.dart';
// import 'package:collection/collection.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:recipe_demo/provider/recipe_provider.dart';
// // import 'package:random_password_generator/random_password_generator.dart';
// import 'package:sqflite/sqflite.dart';

// class DBProvider {
//   // DBProvider._();
//   static final DBProvider db = DBProvider._privateConstructor();
//   DBProvider._privateConstructor();

//   // static final DBProvider db;
//   //DBProvider._();//
//   static Database? _database;

//   static const initScripts = [
//     "CREATE TABLE RECIPE (id integer primary key, name TEXT, desc TEXT, cookingTime TEXT, cookingTimeUnit TEXT, imgs TEXT, servingMinSize INTEGER, servingMaxSize INTERGER, createdBy INTEGER, createdDate TEXT, featured BOOLEAN, category TEXT, utils TEXT, ingredients TEXT, steps TEXT, tips TEXT);",
//   ];

//   Future<Database> get database async {
//     if (_database != null && _database!.isOpen){
//       return _database!;
//     }
//     await initDB();
//     return _database!;
//   }



//   late String path;
//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "recipe_demo.db");
//     _database = await openDatabase(path, version: 20,
//       onCreate: (Database db, int version) async {
//         for (var script in initScripts) {
//           await db.execute(script);
//         }
//       }, 
//       onUpgrade: _onUpgrade
//     );
//   }

//   void closeDB() async {
//     if (_database != null){
//       _database!.close();
//     }
//   }

//   void _onUpgrade(Database db, int oldVersion, int newVersion) {
//     if (oldVersion < newVersion) {
      
//     }
//   }

//   clearDB() async {
//     final db = await database;
//     if(db != null){
//       // await db.delete("AGENT");
//     }    
//   }

// }
