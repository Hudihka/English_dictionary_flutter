import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';


Future<void> main() async {
  await DBProvider.db.initDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
