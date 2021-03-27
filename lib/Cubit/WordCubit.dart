import 'package:english_dictionary_flutter/API/LoadContent.dart';
import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsState {

  List<Word> words;

  int indexSegment;
  bool hideTranslate;

  WordsState({this.words, this.indexSegment, this.hideTranslate});

  WordsState copyWith({List<Word> newWords, 
                       int newIndexSegment, 
                       bool newHideTranslate}){

    if (newWords != null){
      this.words = newWords;
    }

    if (newIndexSegment != null){
      this.indexSegment = newIndexSegment;
    }

    if (newHideTranslate != null){
      this.hideTranslate = newHideTranslate;
    }
    

    return WordsState(words: words,
                      indexSegment: indexSegment,
                      hideTranslate: hideTranslate);

  }
  
}


class WordCubit extends Cubit<WordsState>{

  List<String> themesID;
  
  List<Word> _listWord = [];
  List<Word> _sertchWords = [];

  bool _rusValue = true;
  bool _hideTranslate = true;

  final DBProvider cash = DBProvider.db;
  final WordsState userState;

  WordCubit(this.userState, {@required this.themesID}) : super(WordsState());


  Future<void> fetchContent() {

    final listThemes = 






    //показываем в начале пустой экран
    // emit(userState.copyWith(listThemes: [], selectedTheme: [], allSelected: false, countWord: 0));

    // await _themeProvider.loadContent();

    // //грузим темы из памяти
    // _listThemes = await cash.getAllThemes();

    // var allCount = 0;
    // for (var them in _listThemes){
    //   allCount += them.listWord.length;
    // }

    // emit(userState.copyWith(listThemes: _listThemes, selectedTheme: [], allSelected: false, countWord: allCount));
  }

  // clearAll(){
  //   _selectedTheme = [];
  //   _allSelected = false;

  //   emit(userState.copyWith(listThemes: _listThemes, selectedTheme: _selectedTheme, allSelected: _allSelected));
  // }

  // selectedAll(){
  //   _selectedTheme = _listThemes;
  //   _allSelected = true;

  //   emit(userState.copyWith(listThemes: _listThemes, selectedTheme: _selectedTheme, allSelected: _allSelected));
  // }

  // tapedHeder(){
  //   if (_allSelected){
  //     clearAll();
  //   } else {
  //     selectedAll();
  //   }
  // }

  // selectedTheme(ThemeWords theme){

  //   final isConteins = _selectedTheme.contains(theme);
  //   if (isConteins){
  //     _selectedTheme.remove(theme);
  //   } else {
  //     _selectedTheme.add(theme);
  //   }

  //   final all = _selectedTheme.length == _listThemes.length;

  //   emit(userState.copyWith(selectedTheme: _selectedTheme, allSelected: all));
  // }


  // Future<void> reloadUser() async {
  //   try {
  //     await _themeProvider.getThemes();
  //     _listThemes = await cash.getAllThemes();
  //     emit(userState.copyWith(listThemes: _listThemes, loadStatus: false));
  //   } catch(_) {
  //     emit(userState.copyWith(listThemes: _listThemes, loadStatus: false));
  //   }
  // }



}


