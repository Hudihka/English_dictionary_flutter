
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


class TestSelectedTwo extends StatelessWidget {

  bool _rusWay;

  BuildContext _context;
  Function tapedBack;

  dynamic _content;
  Word _selectedWord;

  Color get _colorAll {
    if (_content is List<Word>){
      return Colors.white;
    }

    if (_content == null){
      return "FCFCFC".getColor();
    }

    return _content ? Colors.green[200] : Colors.red[200];
  }


  @override
  Widget build(BuildContext context) {

    _context = context;

    return BlocBuilder<TestSelectedCubit, TestSelectedState>(builder: (context, state) {
      if (state is TestSelectedState) {

        _content = state.contentTwoList;
        _selectedWord = state.selectedWord;
        _rusWay = !state.rusWay;



        return _allContent;

      }
    });
  }

  


  Widget get _allContent {

    return WillPopScope(
      onWillPop: () { 
        _content = null;
        _selectedWord = null;

        if (tapedBack != null){
          tapedBack();
        }

       },
      child: Scaffold(
      appBar: _appBar,
      backgroundColor: _colorAll,
      // resizeToAvoidBottomInset: false,
      body: _body
    )
    );
  }

  AppBar get _appBar {

    String text = "";

    if (_content is List<Word>){
      if (_selectedWord != null){
        text = !_rusWay ? _selectedWord.rusValue : _selectedWord.engValue;
      }
    }

    return AppBar(
        backgroundColor: _colorAll,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)
        ),
        centerTitle: true,
      );



  }

  Widget get _body {

    if (_content is List<Word>){
      return _listTV(_content);
    }

    if (_selectedWord == null){
      return _textCenter;
    }

    return _textCenter;
  }


  Widget get _textCenter {


    final textTop = _content == null ? 'НЕТ ВЫБРАННОГО СЛОВА' : 
                                        _rusWay ? _selectedWord.rusValue : _selectedWord.engValue;

    final textDown = _content == null ? 'выбери слово' : 
                                        !_rusWay ? _selectedWord.rusValue : _selectedWord.engValue;

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textTop, 
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
        SizedBox(height: 20,),
        Text(
            textDown,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            ),
        ],
    ),
    );

  }




  Widget _listTV(List<Word> dataArray) {


    return Container(
      width: double.infinity,
      height: Const.fullHeightBody,
      child:  ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: dataArray.length,
          itemBuilder: (context, index) {
            
              final word = dataArray[index];
              return CellTestWordAnswer(word: word, rusWay: _rusWay);
            
      })
    );
  }


}

