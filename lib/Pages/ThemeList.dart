


import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';



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
    //
    Const.setSize(context);
    _context = context;

    _contentCubit = context.read();

    SingltonsCubit.shared.saveThemeCubit(_contentCubit);

    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      if (state is ThemeState) {

        _dataArray = state.listThemes ?? [];
        _selectedList = state.selectedTheme ?? [];
        _selectedAll = state.allSelected ?? false;
        _countWord = state.countWord ?? 0;

        if (_dataArray.isEmpty){
          return ScafoldLoad();
        } else {
          return _createScafold;
        }

      }
    });
  }



  Scaffold get _createScafold {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _allContent(),
      );
  }



  



  Widget _allContent(){

    List<Widget> baseList = [Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
      children: [
        _createTable(),

        _createButton()
      ],
    )
    )];


    if (_selectedList.isNotEmpty){
      baseList.add(_buttonClear);
    }


    return Stack(children: baseList);
  }


  Widget get _buttonClear{

      return  Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: Const.statusBarHeight + 5, left: 15, bottom: 0),
            child: Container(
              height: 50,
              width: 100,
              child: BBItem(shadow: true, text: 'Сброс', action: (){
                 _contentCubit.clearAll();
            }),
            ),

          ),
        );


  }





  Widget _createTable() {

    return Container(
      width: double.infinity,
      height: Const.hDevice - 64,
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
                _alert();
              },
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)))
      ),

    );
  }


  _alert(){
    final alert = AlertWay(context: _context,);

    List<String> listID = _selectedList.map((e) => e.id).toList();

    alert.lening = (){

      final cramming = Cramming(themesID: listID);

      Navigator.push(_context, MaterialPageRoute(
            builder: (context) => cramming),
      );
    };


    alert.rusEng = (){
      _showTestFirst(listID: listID, rusWay: true);
    };

    alert.engRus = (){
      _showTestFirst(listID: listID, rusWay: false);
    };


    showDialog(context: _context, builder: (BuildContext context) => alert);
  }

  _showTestFirst({List<String> listID, bool rusWay}){
      //     SingltonOrientation.shared.twoOrientation();
      // final first = MyHomePage();

      // Navigator.push(_context, MaterialPageRoute(
      //       builder: (context) => TestWidget()),
      // );
      
      SingltonOrientation.shared.twoOrientation();
      final first = SplitPage(rusWay: rusWay, themesID: listID);

      Navigator.push(_context, MaterialPageRoute(
            builder: (context) => first),
      );
  }



}