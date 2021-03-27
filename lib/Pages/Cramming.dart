import 'package:english_dictionary_flutter/Cubit/WordCubit.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:english_dictionary_flutter/Support/ScafoldLoad.dart';
import 'package:english_dictionary_flutter/Views/CellWord.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_segmented_control/material_segmented_control.dart';


class Cramming extends StatelessWidget {
  final state = WordsState();
  List<String> themesID;

  Cramming({@required this.themesID});

  @override
  Widget build(BuildContext context) {
    Const.setSize(context);

    return BlocProvider<WordCubit>(
      create: (context) => WordCubit(state, themesID: themesID),
      child: CrammingContent()
    );
  }
}

class CrammingContent extends StatelessWidget {

  BuildContext _context;
  WordCubit _contentCubit;

  List<Word> _dataArray;
  int _selectedIndexWay = 0;
  bool _hideWord = true;

  String textSertch = "";

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    _contentCubit = context.read();
    _contentCubit.fetchContent();

    return BlocBuilder<WordCubit, WordsState>(builder: (context, state) {
      if (state is WordsState) {

        _dataArray = state.words;
        _selectedIndexWay = state.indexSegment ?? 0;
        _hideWord = state.hideTranslate ?? true;

        if (_dataArray == null){
          return ScafoldLoad();
        } else {
          return _allContent;
        }

      }
    });
  }


  Widget get _allContent {
    return Scaffold(
      body: Container(
      color: Colors.white,
      child: Column(
      children: [
        SizedBox(height: 10 + Const.statusBarHeight.toDouble(),),
        _navigBar,
        SizedBox(height: 10),
        _segmentControll,
        SizedBox(height: 5),
        _switchContent,
        _listTV
      ],
    )
    ),
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
          selectionIndex: _selectedIndexWay,
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
            value: _hideWord,
            onChanged: (value) {
              // setState(() {});
            },
            activeTrackColor: "F2F2F2".getColor(alpha: 0.75),
            activeColor: Colors.black,
          ),
        SizedBox(width: 5),
        Container(
          child: Text('Скрыть перевод', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        )

      ]
    );
  }



  Widget get _listTV {


    return Container(
      width: double.infinity,
      // constraints: BoxConstraints(maxHeight: double.infinity,),
      height: Const.hDevice - 148 - Const.statusBarHeight.toDouble(),
      child: _dataArray.isEmpty ? 

      Center(
        child: Text("Очисти поиск.\n\nНет слов.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w400),
        )
      ) : 
      ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _dataArray.length,
          itemBuilder: (context, index) {
            Word word = _dataArray[index];
            
            return CellWord(word: word, rusWay: _selectedIndexWay == 0, hideTarnslate: _hideWord);

      })
    );
  }


}

