
import 'package:english_dictionary_flutter/Pages/TestSelectedTwo.dart';
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


class TestSelectedFirst extends StatelessWidget {

  bool rusWay;
  List<String> themesID;
  TestSelectedFirst({@required this.rusWay, @required this.themesID});

  BuildContext _context;
  TestSelectedCubit _contentCubit;

  List<Word> _dataArray;


  @override
  Widget build(BuildContext context) {

    _context = context;
    _contentCubit = context.read();
    _contentCubit.fetchContent(themesID: themesID);

    SingltonsCubit.shared.saveTestSelectedCubit(_contentCubit);

    return BlocBuilder<TestSelectedCubit, TestSelectedState>(builder: (context, state) {
      if (state is TestSelectedState) {

        _dataArray = state.words;

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

    return Scaffold(
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
      body: Column(
        children: [
          HrderTestTable(),
          _listTV
        ],
      )
    );
  }



  Widget get _listTV {


// TestSelectedTwo

    return Container(
      width: double.infinity,
      height: Const.fullHeightBody - 79,
      child:  ListView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _dataArray.length,
          itemBuilder: (context, index) {
            
            return _cell(index);
            
      })
    );
  }


  CellTestWord _cell(int index){

    final word = _dataArray[index];
    final cell = CellTestWord(word: word, rusWay: rusWay);

    cell.tapedWord = (value){

                _contentCubit.tapedWordTest(value);
                Navigator.push(_context, MaterialPageRoute(
                builder: (context) => TestSelectedTwo(rusWay: rusWay)),);

    };

    return cell;
  }


}

