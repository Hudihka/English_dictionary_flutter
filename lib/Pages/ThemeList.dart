import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:english_dictionary_flutter/Views/CellTheme.dart';
import 'package:english_dictionary_flutter/Views/HederThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/ThemeCubit.dart';
import '../Models/ThemeWords.dart';


class ThemeList extends StatelessWidget {
  final state = ThemeState();

  @override
  Widget build(BuildContext context) {
    Const.setSize(context);

    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(state),
      child: Lenta()
    );
  }
}

class Lenta extends StatelessWidget {

  BuildContext _context;
  ThemeCubit _contentCubit;

  List<ThemeWords> _dataArray = [];
  List<ThemeWords> _selectedList = [];
  bool _selectedAll = false;
  int _countWord = 0;

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    _contentCubit = context.read();
    _contentCubit.fetchContent();

    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      if (state is ThemeState) {

        _dataArray = state.listThemes ?? [];
        _selectedList = state.selectedTheme ?? [];
        _selectedAll = state.allSelected ?? false;
        _countWord = state.countWord ?? 0;

        if (_dataArray.isEmpty){
          return _scafoldEmptu;
        } else {
          return _createScafold;
        }

      }
    });
  }

    Scaffold get _scafoldEmptu {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
        ),
      );
  }

  Scaffold get _createScafold {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body: _allContent(),
      );
  }

    Widget get _appBar {

      final empty = _selectedList.isEmpty;


    return AppBar(
          shadowColor: Const.clearColor,
          backgroundColor: Colors.white,
          leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 25,
            width: 60,
            child: Center(
              child: Text('   Сброс', 
              style: TextStyle(color: empty? Const.lightGrey : Colors.black, ),),
            ),
          ),
          onTap: empty ? null : () {
            _contentCubit.clearAll();
          },
        ),
    );
  }



  Widget _allContent(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
      children: [
        _createTable(),

        _createButton()
      ],
    )
    );
  }




  Widget _createTable() {

    return Container(
      width: double.infinity,
      height: Const.hDevice - 64 - 83,
      child: ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _dataArray.length + 1,
          itemBuilder: (context, index) {

            if (index == 0){
              final cell = HederTheme(selected: _selectedAll, 
                                      countThemes: _dataArray.length, 
                                      countWord: _countWord);

              cell.presedAllTheme = (){
                _contentCubit.tapedHeder();
              };

              return cell;
            } else {
              final theme = _dataArray[index - 1];
              final selected = _selectedList.contains(theme);
              final cell = CellTheme(selected: selected, theme: theme);

              cell.presedTheme = (value){
                _contentCubit.selectedTheme(value);
              };

              return cell;
            }

      }),
    );
  }

    Widget _createButton() {
    
    return Container(
      width: double.infinity,
      height: 64,
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: RaisedButton(
        color: _selectedList.isEmpty ? Colors.white : Colors.black,
        child: Center(
          child: Text('НАЧАТЬ', 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        onPressed: _selectedList.isEmpty ? null : () {
                print("jbijhhhhbhhbhbhb");
              },
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)))
      ),

    );
  }

}