import 'dart:core';

import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

class TestSelectedState {

  List<Word> words;
  Map<Word, dynamic> listAll = {};



  TestSelectedState({this.words, this.listAll});

  TestSelectedState copyWith({List<Word> newWords, 
                       Map<Word, dynamic> newListAll}){

    if (newWords != null){
      this.words = newWords;
    }

    if (newListAll != null){
      this.listAll = newListAll;
    }
    
    return TestSelectedState(words: newWords ?? this.words ,
                            listAll: newListAll ?? this.listAll);

  }
  
}


class TestSelectedCubit extends Cubit<TestSelectedState>{

  final DBProvider cash = DBProvider.db;
  final TestSelectedState selectedState;

  List<Word> _words;

  Map<Word, dynamic> listAll = {};
  Word selectedWord;

  TestSelectedCubit(this.selectedState) : super(TestSelectedState());

  Future<void> fetchContent({@required List<String> themesID}) async {

    _words = await cash.getWordsSorted(themesID, null, text: "");
    emit(selectedState.copyWith(newWords: _words, newListAll: listAll));

  }

  // tapedWordTest({@required Word wordTaped}){
    


  // }

  bool _selectedWord({@required Word word}){
    selectedWord = word;




  }

  //цвет ячейки
  //
  
  bool _isSelected({@required Word word}){
    if (selectedWord == null){
      return false;
    }

    return Word.isEqu(selectedWord, word);
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

    final value = listAll[word];

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
  //
  //
  //
  List<bool> get _listAnsver {
    return listAll.values.toList().where((element) => element is bool).toList();
  }
  
  int get getCountTrue {
    return _listAnsver.where((element) => element == true).length;
  }

  int get getCountFalse {
    return _listAnsver.where((element) => element == false).length;
  }

  

}


