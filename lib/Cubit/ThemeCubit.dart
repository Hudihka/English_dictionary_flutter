import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {

  final List<ThemeWords> listThemes;
  final List<ThemeWords> selectedTheme;
  final bool allSelected;

  ThemeState({this.listThemes, this.selectedTheme, this.allSelected});

  ThemeState copyWith({List<ThemeWords> listThemes, List<ThemeWords> selectedTheme, bool allSelected}){

    return ThemeState(listThemes: listThemes ?? this.listThemes,
                      selectedTheme: selectedTheme ?? this.selectedTheme,
                      allSelected: allSelected ?? this.allSelected);

  }
  
}


class ThemeCubit extends Cubit<ThemeState>{
  
  // LoadContent _themeProvider = LoadContent();
  List<ThemeWords> _listThemes = [];
  List<ThemeWords> _selectedTheme = [];
  bool _allSelected = false;

  final DBProvider cash = DBProvider.db;
  final ThemeState userState;
  ThemeCubit(this.userState) : super(ThemeState());

  Future<void> fetchContent() async {
    //показываем в начале пустой экран
    emit(userState.copyWith(listThemes: _listThemes));

    //грузим темы из памяти
    _listThemes = await cash.getAllThemes();

    if (_listThemes.isEmpty){
      //если нет
    }

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

  selectedTheme(ThemeWords theme){
    _selectedTheme = _listThemes;
    _allSelected = true;

    final isConteins = _allSelected.where((item) => item.a  == "someString1");

    // if (_allSelected.conta)

    emit(userState.copyWith(selectedTheme: _selectedTheme, allSelected: _allSelected));
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


