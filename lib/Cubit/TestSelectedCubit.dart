import 'dart:core';
import 'dart:math';

import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

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

    selectedWord = newSelectedWord;
    
    return TestSelectedState(words: newWords ?? this.words ,
                            contentTwoList: newContentTwoList ?? this.contentTwoList,
                            selectedWord: selectedWord);

  }
  
}


class TestSelectedCubit extends Cubit<TestSelectedState>{

  final DBProvider cash = DBProvider.db;
  final TestSelectedState selectedState;

  List<Word> _words;

  Map<Word, dynamic> _listAll = {};
  Word _selectedWord;

  TestSelectedCubit(this.selectedState) : super(TestSelectedState());

  Future<void> fetchContent({@required List<String> themesID}) async {

    List<Word> listStart = await cash.getWordsSorted(themesID, null, text: "");

    _words = _randomMixWord(listStart, listStart.length, null);
    emit(selectedState.copyWith(newWords: _words, newContentTwoList: null));

  }

  List<Word> _randomMixWord(List<Word> inArray, int countFinalLeng, Word truhWord){

    inArray.shuffle();

    if (truhWord != null){
      inArray.retainWhere((item) => item.id != truhWord.id);
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

  //при тапе на конкретное слово
  //или при тапе назад
  bool tapedWordTest(Word word){
    _selectedWord = word;
    emit(selectedState.copyWith(newSelectedWord: _selectedWord));

    if (word != null){
      _reloadListAll(word: word);
    }

  }


  _reloadListAll({@required Word word}){
    final value = _listAll[word];

    if (value == null){
      final array = _randomMixWord(_words, 10, word);
      _listAll[word] = array;
      emit(selectedState.copyWith(newContentTwoList: array));
      return;
    }

    emit(selectedState.copyWith(newContentTwoList: value));
  }


  tapedWordAnsver(Word word){
    final newValue = word.id == _selectedWord.id;
    _listAll[word] = newValue;

    //добавить вибрацию в зависимости от ответа

    emit(selectedState.copyWith(newContentTwoList: _selectedWord));

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


