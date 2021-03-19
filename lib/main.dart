import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Pages/ThemeList.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  await DBProvider.db.initDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ThemeList(),
    );
  }
}
