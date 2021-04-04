
import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:hive/hive.dart';
import 'Word.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';
part 'ThemeWords.g.dart';

@HiveType(typeId: 0)
class ThemeWords extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final List<Word> listWord;

  ThemeWords({this.id, this.name, this.listWord});

  factory ThemeWords.fromJson(Map<String, dynamic> json, List<String> ids) {
    String name = json['theme'];
    String id = name.generateMd5;

    List<dynamic> data = json['allWords'];
    List<Word> wordLists = [];

    data.forEach((element) {
      final id = element['id'];

      if (ids.contains(id) == false){
        wordLists.add(Word.fromJson(element, name));
      }

    });

    // List<Word> listWord = Word.fromListOfMap(data, name);

    return ThemeWords(id: id,
                      name: name,
                      listWord: wordLists);
  }

  int get countFavorit{
    final listFavor = listWord.where((element) => element.favorit == true);
    return listFavor.length;
  }

}

//запуск hive
//flutter packages pub run build_runner build --delete-conflicting-outputs