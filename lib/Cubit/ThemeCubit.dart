import 'package:english_dictionary_flutter/Data/DBProvider.dart';
import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {

  final List<ThemeWords> listThemes;

  ThemeState({this.listThemes});

  ThemeState copyWith({bool loadStatus, List<ThemeWords> listThemes}){

    return ThemeState(listThemes: listThemes ?? this.listThemes);

  }
  
}


class ThemeCubit extends Cubit<ThemeState>{
  
  // LoadContent _themeProvider = LoadContent();
  List<ThemeWords> _listThemes = [];
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


