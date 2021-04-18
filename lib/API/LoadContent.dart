
import 'dart:io' as io;
import 'dart:io';
import 'package:english_dictionary_flutter/export.dart';
//https://stackoverflow.com/questions/58075432/how-to-get-files-from-external-storage-in-flutter
class LoadContent {
  Future loadContent(List<String> ids) async {

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final Directory d = Directory('/storage/emulated/0');

    final filesLawait = io.Directory("data/resume/").listSync();

    final List<Map<String, dynamic>> allContent = AllContent.allContent;

    List<ThemeWords> themes = [];
    await Future.forEach(allContent, (jsonThemes) async {
      final theme = ThemeWords.fromJson(jsonThemes, ids);
      themes.add(theme);
    });

    await DBProvider.db.newThemeList(themes);


  }

}
