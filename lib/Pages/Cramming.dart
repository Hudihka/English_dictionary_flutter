import 'package:english_dictionary_flutter/Cubit/WordCubit.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:english_dictionary_flutter/Views/CellWord.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';
import 'package:material_segmented_control/material_segmented_control.dart';


class HomePage extends StatelessWidget {

  BuildContext _context;
  WordCubit _contentCubit;

  List<Word> _dataArray = [];
  
  bool _rusEngTranslate = true;
  bool _hideTranslate = true;

  String textSertch = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allContent,
    );
  }

  Widget get _allContent {
    return Column(
      children: [
        SizedBox(height: Const.statusBarHeight.toDouble(),),
        _navigBar,
        SizedBox(height: 10),
        _segmentControll,
        SizedBox(height: 5),
        _switchContent,

      ],
    );
  }


  //ТИТУЛЬНИК

  Row get _navigBar {
    return Row(
      children: [
        SizedBox(width: 15),
        Container(
          height: 35.0,
          width: Const.wDevice - 10 - 85,
          child: Container(
            decoration: new BoxDecoration(
              color: "F2F2F2".getColor(alpha: 0.75),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _getTextField()
         ),
        ),
        GestureDetector( //кнопка Очистить
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 35,
            width: 80,
            child: Center(
              child: Text('  Очистить  ', 
              style: TextStyle(color: _emptyText ? Const.lightGrey : Colors.black, ),),
            ),
          ),
          onTap: _emptyText ? null : () {
            // textSertch = "";
            //очистить
          },
        )
      ]
    );
  }

  TextField _getTextField() {
    return TextField(
      // focusNode: _focusNode,
      // obscureText: !isName,
      style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
        hintText: "Поиск",
        hintStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
      ),
      textAlign: TextAlign.left,
      onChanged: (str) {
        textSertch = str;
        // setState(() {});
        //запусекаем поиск
      },
      onSubmitted: (str) {
        //если пользователь нажал ВВод
        // if (isName) {
        //   FocusScope.of(context).previousFocus();
        // }
        
      },
    );
  }

  bool get _emptyText {
    return textSertch == "";
  }

  //SEGMENT CONTROL

  Widget get _segmentControll{
    return Container(
      width: double.infinity,
      child: _segment,
    );
  }

  Widget get _segment {

    Map<int, Widget> _children = {
  0: Text('Rus -> Eng'),
  1: Text('Eng -> Rus'),
};

    return MaterialSegmentedControl(
          children: _children,
          selectionIndex: 0,
          borderColor: Colors.white,
          selectedColor: Colors.black,
          unselectedColor: Colors.white,
          borderRadius: 10.0,
          // disabledChildren: [
          //   3,
          // ],
          onSegmentChosen: (index) {
            // setState(() {
            //   _currentSelection = index;
            // });
          },
         );

  }

  //SWITCH

  Widget get _switchContent{
    return Row(
      children: [
        SizedBox(width: 10),
        Switch(
            value: false,
            onChanged: (value) {
              // setState(() {});
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.black,
          ),
        SizedBox(width: 5),
        Container(
          child: Text('Показывать перевод', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        )

      ]
    );
  }



  Widget get _listTV {



    // final contentArray = _emptyText ?  

    if (_dataArray.isEmpty){
      return Center(
        child: Text("Очисти поиск.\n\nНет слов.",
          style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w400),
        )
      );
    }


    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: double.infinity,),
      child: ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _dataArray.length,
          itemBuilder: (context, index) {
            Word word = _dataArray[index];
            
            return CellWord(word: word, rusWay: _rusEngTranslate, hideTarnslate: _hideTranslate);

      }),
    );
  }


}

