
import 'package:english_dictionary_flutter/Pages/SplitPage/TestSelectedTwo.dart';
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


class TestSelectedFirst extends StatelessWidget {

  bool _rusWay;
  // List<String> themesID;
  // TestSelectedFirst({@required this.rusWay, @required this.themesID});

  BuildContext _context;
  TestSelectedCubit get _contentCubit{
    return SingltonsCubit.shared.getTestSelectedCubit;
  }

  List<Word> _dataArray;


  @override
  Widget build(BuildContext context) {

    _context = context;

    return BlocBuilder<TestSelectedCubit, TestSelectedState>(builder: (context, state) {
      if (state is TestSelectedState) {

        _dataArray = state.words;
        _rusWay = state.rusWay;

        if (_dataArray == null){
          return ScafoldLoad();
        } else {
          return _allContent;
        }

      }
    });
  }


  Widget get _allContent {

    return WillPopScope(
      onWillPop: () { 
        SingltonOrientation.shared.oneOrientation();
        Navigator.of(_context).pop();
       },
      child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: HrderTestTable(),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: _listTV
    )
    );
  }



  Widget get _listTV {


// TestSelectedTwo

    return Container(
      width: double.infinity,
      height: Const.fullHeightBody,
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
    final cell = CellTestWord(word: word, rusWay: _rusWay);

    cell.tapedWord = (value){

                _contentCubit.tapedWordTest(value);

                Navigator.push(_context, MaterialPageRoute(
                builder: (context) => TestSelectedTwo()),);

    };

    return cell;
  }


}
