import 'dart:core';

import 'package:english_dictionary_flutter/export.dart';

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

  tapedWordTest({@required Word wordTaped}){



  }

  bool _selectedWord({@required Word word}){
    
  }

  

}


