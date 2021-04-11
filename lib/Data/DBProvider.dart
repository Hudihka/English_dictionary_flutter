
import 'package:english_dictionary_flutter/export.dart';

class DBProvider {

  DBProvider._();

  static final DBProvider db = DBProvider._();

  List<String> listFavorit = []; //при инициализации мы выковыриваем те слова, что фаворит

Future<void> initDB() async {
  await Hive.initFlutter();
  Hive.openBox('name_box');
  Hive.registerAdapter(ThemeWordsAdapter()); 
  Hive.registerAdapter(WordAdapter()); 

}

Future<void> initListFavoriteWord() async {
  var boxWord = await Hive.openBox<Word>('Word');


  listFavorit = boxWord.values.toList().map((element){
    if (element.favorit){
      return element.id;
    }
  }).toList();

}



Future<void> newThemeList(List<ThemeWords> themes) async {
  var box = await Hive.openBox<ThemeWords>('ThemeWords');

  Map<String, ThemeWords> allThemes = {};

  await Future.forEach(themes, (e) async {
    allThemes[e.id] = e;
    _newWordList(e.listWord);
  });

  box.putAll(allThemes);

}


_newWordList(List<Word> words) async {
  var box = await Hive.openBox<Word>('Word');

  Map<String, Word> allWord = {};

  Set<String> newId = {};

  Set<dynamic> oldID = box.keys.toSet();

  // await favoriteCheck(index: 0);

  for (var e in words){
    ///если Уже есть обьект с 
    ///таким ид то мы не добавляем его
    ///
    final IDword = e.id;
    e.favorit = listFavorit.contains(IDword);

    allWord[IDword] = e;
    newId.add(IDword);
    
  }

  // await favoriteCheck(index: 1);


  box.putAll(allWord);

  Set<dynamic> deleteID = oldID.difference(newId);//те что надо удалить

  if (deleteID.isNotEmpty) {
    box.deleteAll(deleteID);
  }

}


Future<List<ThemeWords>> getAllThemes() async {
  var box = await Hive.openBox<ThemeWords>('ThemeWords');
  return box.values.toList();
}

Future<int> getCountWords() async {
  var box = await Hive.openBox<ThemeWords>('ThemeWords');
  return box.length;
}

//получение тем по id

Future<List<ThemeWords>> getThemes(List<String> listID) async {
  var box = await Hive.openBox<ThemeWords>('ThemeWords');
  List<ThemeWords> listThemes = box.values.toList();

  return listThemes.where((element) => listID.contains(element.id)).toList();
}

//получение слов тем по id

Future<List<Word>> getWordsSorted(List<String> listIDThemes, bool rusSorted, {@required String text}) async {
  List<Word> listWord = await _getWords(listIDThemes);

  if (rusSorted){

    listWord.sort((a, b){
      return a.rusValue.toLowerCase().compareTo(b.rusValue.toLowerCase());
    });

  } else {

    listWord.sort((a, b){
      return a.engValue.toLowerCase().compareTo(b.engValue.toLowerCase());
    });

  }

    if (text != ""){
      if (rusSorted){
        listWord.where((element) => element.rusValue.contains(text)).toList();
      } else {
        listWord.where((element) => element.engValue.contains(text)).toList();
      }
    }


  return listWord;
}

Future<List<Word>> _getWords(List<String> listIDThemes) async {
  List<ThemeWords> listThemes = await getThemes(listIDThemes);
  List<Word> listWord = [];

  for (var obj in listThemes){
    listWord += obj.listWord;
  }

  return listWord;
}

/////// Лайк/дизлайк
///

likeButton(Word word) async {


  if (word.favorit == null){
    word.favorit = true;
  } else {
    word.favorit = !word.favorit;
  }

  var box = await Hive.openBox<Word>('Word');

  final index = box.values.toList().indexWhere((element) => element.id == word.id);

  if (index == -1){

    Map<String, Word> wordsMap = {word.id : word};
    box.putAll(wordsMap);
  } else {
    box.putAt(index, word);
  }
  

  // favoriteCheck(index: 0);




}


// void favoriteCheck({@required int index}) async {

//   print('start -------------------------- $index');

//   var box = await Hive.openBox<Word>('Word');
//   final idTest = '56276b744191c78b9f7e0eb3cea20308';
//   final word = box.values.toList().indexWhere((element) => element.id == idTest);

//   print('-------------------------- $index');
//   // print(word.favorit);

// }



/////////////////////////////  USER


// newUsersList(List<User> users) async {
//   var box = await Hive.openBox<User>('User');

//   Map<int, User> allUser = {};
//   // Set<int> newId = {};
//   await Future.forEach(users, (e) async {
//     allUser[e.id] = e;
//     // newId.add(e.id);
//   });

//   box.putAll(allUser);
// 
  //если надо удалять те, что не пришли
  // Set<int> oldID = box.keys;
  // Set<int> deleteID = oldID.difference(newId);//те что надо удалить

  // if (deleteID.isNotEmpty) {
  //   box.deleteAll(deleteID);
  // }
// 
// }
  
// addUser(User user) async {
//   var box = await Hive.openBox<User>('User');

//   final int key = user.id;
//   box.put(key, user);

  // final int key = user.id;
  //индекс в коробке срекди ключей
  //если индекс -1 то такого ключа нет
  // int index = box.keys.toList().indexWhere((e) => e == key); 

  // if (index != -1) {
  //   //такой юзер уже есть, надо обновить
  //   user.email = 'rabotaiSuka@mail.ru';
  //   box.putAt(index, user);
  // } else {
  //   box.put(key, user);
  // }

  // box.add(user);
// }  

// Future<List<User>> getAllUsers() async {
//   var box = await Hive.openBox<User>('User');

//   return box.values.toList();
// }

// Future<bool> conteinsUser(User user) async {
//   var box = await Hive.openBox<User>('User');
//   return box.keys.contains(user.id);
// }
  


}
