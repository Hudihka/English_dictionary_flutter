import 'dart:core';
import 'dart:math';

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

    List<Word> listStart = await cash.getWordsSorted(themesID, null, text: "");

    _words = _randomMixWord(listStart, listStart.length, null);
    emit(selectedState.copyWith(newWords: _words, newListAll: listAll));

  }

  List<Word> _randomMixWord(List<Word> inArray, int countFinalLeng, Word truhWord){

    inArray.shuffle();

    if (truhWord != null){
      inArray.retainWhere((item) => item.id == truhWord.id);
    }
    
    if (countFinalLeng < inArray.length){
      inArray.sublist(0, countFinalLeng - 1);
    }

    if (truhWord != null){
      Random random = new Random();
      final index = random.nextInt(countFinalLeng);
      inArray[index] = truhWord;
    }

    return inArray;

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
    List<bool> listReturn = [];
    final listAnsver = listAll.values.toList();

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


