

import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';

class HederTheme extends StatelessWidget {
  bool selected;
  int countThemes;
  int countWord;

  Function presedAllTheme;

  HederTheme({@required this.selected, @required this.countThemes, @required this.countWord});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      // height: 100,
      child: Column(
        children: [
          _getWidgetHEderAndFooter('Всего слов: $countWord'),
          Container(
            height: 80,
            child: _getButton(),
          ),
          _getWidgetHEderAndFooter('Всего тем: $countThemes')
        ],
      ),

    );
  }


  Widget _getWidgetHEderAndFooter(String text){
    return Container(
            color: Colors.white,
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, right: 20, top: 10),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(text, style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
              ),
            );
     
  }

    Widget _getButton(){
    return RaisedButton(
        color: selected ? Colors.black : Const.lightGrey,
        child: Center(
          child: Text('ВЫБРАТЬ ВСЕ', 
          style: TextStyle(
            color: selected ? Colors.white : Colors.black, 
            fontSize: 48, fontWeight: FontWeight.bold)),
        ),
        onPressed: () {
                presedAllTheme();
              },
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0)));
     
  }


}