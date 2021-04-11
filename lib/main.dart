
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  await DBProvider.db.initDB();
  await DBProvider.db.initListFavoriteWord();

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
