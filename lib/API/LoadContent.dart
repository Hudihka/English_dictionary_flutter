
import 'package:english_dictionary_flutter/export.dart';
import 'dart:io' as io;

class LoadContent {
  Future loadContent(List<String> ids) async {

    // _localPath;

    final List<Map<String, dynamic>> allContent = AllContent.allContent;

    List<ThemeWords> themes = [];
    await Future.forEach(allContent, (jsonThemes) async {
      final theme = ThemeWords.fromJson(jsonThemes, ids);
      themes.add(theme);
    });

    await DBProvider.db.newThemeList(themes);


  }


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

}
