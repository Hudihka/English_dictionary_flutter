import 'package:english_dictionary_flutter/API/LoadContent.dart';
import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {

  final List<ThemeWords> listThemes;
  final List<ThemeWords> selectedTheme;
  final bool allSelected;
  final int countWord;

  ThemeState({this.listThemes, this.selectedTheme, this.allSelected, this.countWord});

  ThemeState copyWith({List<ThemeWords> listThemes, List<ThemeWords> selectedTheme, 
                       bool allSelected, int countWord}){

    return ThemeState(listThemes: listThemes ?? this.listThemes,
                      selectedTheme: selectedTheme ?? this.selectedTheme,
                      allSelected: allSelected ?? this.allSelected,
                      countWord: countWord ?? this.countWord);

  }
  
}


class ThemeCubit extends Cubit<ThemeState>{
  
  LoadContent _themeProvider = LoadContent();
  
  List<ThemeWords> _listThemes = [];
  List<ThemeWords> _selectedTheme = [];
  bool _allSelected = false;

  final DBProvider cash = DBProvider.db;
  final ThemeState userState;

  ThemeCubit(this.userState) : super(ThemeState());


  Future<void> fetchContent() async {
    //показываем в начале пустой экран
    emit(userState.copyWith(listThemes: [], selectedTheme: [], allSelected: false, countWord: 0));

    await _themeProvider.loadContent();

    //грузим темы из памяти
    _listThemes = await cash.getAllThemes();

    var allCount = 0;
    for (var them in _listThemes){
      allCount += them.listWord.length;
    }

    emit(userState.copyWith(listThemes: _listThemes, selectedTheme: [], allSelected: false, countWord: allCount));
  }

  clearAll(){
    _selectedTheme = [];
    _allSelected = false;

    emit(userState.copyWith(selectedTheme: _selectedTheme, allSelected: _allSelected));
  }

  selectedAll(){
    _selectedTheme = _listThemes;
    _allSelected = true;

    emit(userState.copyWith(selectedTheme: _selectedTheme, allSelected: _allSelected));
  }

  tapedHeder(){
    if (_allSelected){
      clearAll();
    } else {
      selectedAll();
    }
  }

  selectedTheme(ThemeWords theme){

    final isConteins = _selectedTheme.contains(theme);
    if (isConteins){
      _selectedTheme.remove(theme);
    } else {
      _selectedTheme.add(theme);
    }

    final all = _selectedTheme.length == _listThemes.length;

    emit(userState.copyWith(selectedTheme: _selectedTheme, allSelected: all));
  }


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


