
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


class Cramming extends StatelessWidget {

  List<String> themesID;
  Cramming({@required this.themesID});

  BuildContext _context;
  WordCubit _contentCubit;

  List<Word> _dataArray;
  int _selectedIndexWay = 0;
  bool _hideWord = true;

  String _textSertch = "";

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    _contentCubit = context.read();
    _contentCubit.themesID = themesID;


    _contentCubit.fetchContent();

    SingltonsCubit.shared.saveWordCubit(_contentCubit);

    return BlocBuilder<WordCubit, WordsState>(builder: (context, state) {
      if (state is WordsState) {

        _dataArray = state.words;
        _selectedIndexWay = state.indexSegment ?? 0;
        _hideWord = state.hideTranslate ?? true;
        _textSertch = state.textSertch;

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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
        SizedBox(height: 10 + Const.statusBarHeight.toDouble(),),
        _navigBar,
        SizedBox(height: 9),
        _segmentControll,
        SizedBox(height: 5),
        _switchContent,
        _listTV]
            )
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
              color: "F2F2F2".getColor(alpha: 0.5),
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
              style: TextStyle(color: _emptyText ? "F2F2F2".getColor(alpha: 0.7) : Colors.black, ),),
            ),
          ),
          onTap: _emptyText ? null : () {
            _hideKey();
            _contentCubit.textSertch("");
          },
        )
      ]
    );
  }

  TextField _getTextField() {

    final controller = _emptyText ? TextEditingController(text: _textSertch) : null;

    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
        // labelText: "vhvghvghvghv",
        // counterText: "njknjjnn",
        // semanticCounterText: 'hhjjjjbj',
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
        _textSertch = str;
        _contentCubit.textSertch(str);
      },
      onSubmitted: (str) {
        _contentCubit.textSertch(str);
        //если пользователь нажал ВВод
        
      },
    );
  }

    _hideKey(){
      FocusScopeNode currentFocus = FocusScope.of(_context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
  }

  bool get _emptyText {
    return _textSertch == "";
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
          borderColor: "F2F2F2".getColor(alpha: 0.5),
          selectedColor: Colors.black,
          unselectedColor: Colors.white,
          borderRadius: 10.0,
          onSegmentChosen: (index) {
            _contentCubit.newWayTranslate(index);
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
              _contentCubit.switchAction(value);
            },
            activeTrackColor: Colors.black.withAlpha(80),
            activeColor: Colors.black,
            inactiveTrackColor: Colors.black.withAlpha(20),
            inactiveThumbColor: Colors.black,
            // focusColor: Colors.red,
            // hoverColor: Colors.green,
            // thumbColor: Colors.yellow,
            
          
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

            if (_hideWord){
              return CellWordOpasity(word: word, rusWay: _selectedIndexWay == 0);
            } else {
              return CellWord(word: word, rusWay: _selectedIndexWay == 0);
            }
            

      })
    );
  }


}

