
import 'package:english_dictionary_flutter/Content/ALLCONTENT.dart';
import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Models/ThemeWords.dart';

class LoadContent {
  Future loadContent() async {

    final List<Map<String, dynamic>> allContent = AllContent.allContent;

    List<ThemeWords> themes = [];
    await Future.forEach(allContent, (jsonThemes) async {
      final theme = ThemeWords.fromJson(jsonThemes);
      themes.add(theme);
    });

    await DBProvider.db.newThemeList(themes);

  }

}
