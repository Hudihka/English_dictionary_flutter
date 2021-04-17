import 'dart:core';
import 'dart:math';

import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class TestSelectedState {

  List<Word> words;
  dynamic contentTwoList;
  Word selectedWord;


  TestSelectedState({this.words, this.contentTwoList, this.selectedWord});

  TestSelectedState copyWith({List<Word> newWords, 
                              dynamic newContentTwoList,
                              Word newSelectedWord}){

    if (newWords != null){
      this.words = newWords;
    }

    if (newContentTwoList != null){
      this.contentTwoList = newContentTwoList;
    }

    if (newSelectedWord != null){
      this.selectedWord = newSelectedWord;
    }
    
    return TestSelectedState(words: newWords ?? this.words ,
                            contentTwoList: newContentTwoList ?? this.contentTwoList,
                            selectedWord: selectedWord);

  }
  
}


class TestSelectedCubit extends Cubit<TestSelectedState>{

  final DBProvider cash = DBProvider.db;
  final TestSelectedState selectedState;

  List<Word> _words;
  List<String> _themesID;

  Map<Word, dynamic> _listAll = {};
  Word _selectedWord;

  TestSelectedCubit(this.selectedState) : super(TestSelectedState());

  Future<void> fetchContent({@required List<String> themesID}) async {

    _themesID = themesID;

    await _randomMixWordStart();

    emit(selectedState.copyWith(newWords: _words, newContentTwoList: null));
  }

  _randomMixWordStart() async {
    
    List<Word> listStart = await cash.getWordsSorted(_themesID, null, text: "");

    listStart.shuffle();
    _words = listStart;
  }


  Future<List<Word>> _randomMixWord({@required Word truhWord}) async {
    
    List<Word> inArray = await cash.getWordsSorted(_themesID, null, text: "");
    inArray.shuffle();

    inArray.retainWhere((item) => item.id != truhWord.id);
    
    inArray = inArray.sublist(0, 10);

    Random random = new Random();
    final index = random.nextInt(10);
    inArray[index] = truhWord;

    return inArray;

  }

  //при тапе на конкретное слово
  //или при тапе назад
  //
  //
  bool tapedWordTest(Word word){
    _selectedWord = word;

    emit(selectedState.copyWith(newSelectedWord: _selectedWord));

    _reloadListAll(word: word);
  }

  clearSelectedWord(){
    _selectedWord = null;
    selectedState.selectedWord = null;
    emit(selectedState.copyWith(newSelectedWord: null));

  }


  _reloadListAll({@required Word word}) async {
    final value = _listAll[word];

    if (value == null){
      final array =  await _randomMixWord(truhWord: word);
      _listAll[word] = array;
      //добавляем
      emit(selectedState.copyWith(newContentTwoList: array));
      return;
    }

    emit(selectedState.copyWith(newContentTwoList: value));
  }


  tapedWordAnsver(Word word){
    final newValue = word.id == _selectedWord.id;
    _listAll[_selectedWord] = newValue;

    //добавить вибрацию в зависимости от ответа
    //
    if (newValue){
      Vibration.vibrate(duration: 500, amplitude: 64);
    } else {
      Vibration.vibrate(duration: 750, amplitude: 256);
    }

    emit(selectedState.copyWith(newContentTwoList: newValue, ));

  }



  //цвет ячейки
  //
  
  bool _isSelected({@required Word word}){
    if (_selectedWord == null){
      return false;
    }

    return Word.isEqu(_selectedWord, word);
  }

  Color colorCellText({@required Word word}){
    
    if (_isSelected(word: word)){
      return Colors.white;
    }

    return Colors.black;
  }


  Color colorCellBacground({@required Word word}){
    
    if (_isSelected(word: word)){
      return Colors.black;
    }

    final value = _listAll[word];

    if (value == null){
      return Colors.white;
    }

    if (value is List<Word>){
      return Colors.white;
    }

    if (value is bool){
      return value ? Colors.green[200] : Colors.red[200];
    }

  }

  //подсчет правильно/не правильно


  List<bool> get _listAnsver {
    List<bool> listReturn = [];
    final listAnsver = _listAll.values.toList();

    for (var obj in listAnsver){
      if (obj is bool){
        listReturn.add(obj);
      }
    }

    return listReturn;
  }
  
  int get getCountTrue {
    if (_listAnsver is List<bool>){
      return _listAnsver.where((element) => element == true).length;
    }
    
    return 0;
  }

  int get getCountFalse {
    if (_listAnsver is List<bool>){
      return _listAnsver.where((element) => element == false).length;
    }
    
    return 0;
  }

  

}


