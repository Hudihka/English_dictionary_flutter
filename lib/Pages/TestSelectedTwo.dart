
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


class TestSelectedTwo extends StatelessWidget {

  bool rusWay;

  TestSelectedTwo({@required this.rusWay});

  BuildContext _context;
  TestSelectedCubit _contentCubit;

  List<Word> _dataArray;
  Word _selectedWord;


  @override
  Widget build(BuildContext context) {

    _context = context;
    _contentCubit = context.read();

    return BlocBuilder<TestSelectedCubit, TestSelectedState>(builder: (context, state) {
      if (state is TestSelectedState) {

        // _dataArray = state.words;
        // _selectedWord = state.

        if (_dataArray == null){
          return ScafoldLoad();
        } else {
          return _allContent;
        }

      }
    });
  }

  


  Widget get _allContent {
    String text = rusWay ? "Rus -> Eng" : "Eng -> Rus";

    return WillPopScope(
      onWillPop: () { 
        // _tabBarCubit.openMiniMedia();
       },
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: _listTV
    )
    );
  }

  Widget get _text {

    return Center(
      child: Column(
        children: [
          Text(
            theme.name, 
            style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
        SizedBox(height: 20,),
        Text(
            theme.name, 
            style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            ),
        ],
      )
    );
  }



  Widget get _listTV {

    return Container(
      width: double.infinity,
      height: Const.fullHeightBody,
      child:  ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _dataArray.length,
          itemBuilder: (context, index) {
            
              final word = _dataArray[index];
              return CellTestWord(word: word, rusWay: rusWay);
            
      })
    );
  }


}

