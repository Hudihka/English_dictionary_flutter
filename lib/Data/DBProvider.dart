

import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DBProvider {

  DBProvider._();

  static final DBProvider db = DBProvider._();

Future<void> initDB() async {
  await Hive.initFlutter();
  Hive.openBox('name_box');
  Hive.registerAdapter(ThemeWordsAdapter()); 
  Hive.registerAdapter(WordAdapter()); 


  // await Hive.initFlutter();
  // Hive.registerAdapter(UserAdapter());
  // await Hive.openBox<Todo>(HiveBoxes.todo);
}


Future<void> newThemeList(List<ThemeWords> themes) async {
  var box = await Hive.openBox<ThemeWords>('ThemeWords');

  Map<String, ThemeWords> allThemes = {};

  await Future.forEach(themes, (e) async {
    allThemes[e.id] = e;
    _newWordList(e.listWord);
    // newId.add(e.id);
  });

  // for (var e in themes){
  //   allThemes[e.id] = e;
  //   // _newWordList(e.listWord);
  // }

  box.putAll(allThemes);

}


_newWordList(List<Word> words) async {
  var box = await Hive.openBox<Word>('Word');

  Map<String, Word> allWord = {};
  Set<String> newId = {};

  for (var e in words){
    allWord[e.id] = e;
    newId.add(e.id);
  }

  box.putAll(allWord);

  Set<dynamic> oldID = box.keys.toSet();
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
