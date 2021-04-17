import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

class CellTestWord extends StatelessWidget {
  Word word;
  bool rusWay;
  Function(Word) tapedWord;

  CellTestWord({@required this.word, @required this.rusWay});

  TestSelectedCubit get _testCubit {
    return SingltonsCubit.shared.getTestSelectedCubit;
  }

  Color get _colorBacgr {
    return _testCubit.colorCellBacground(word: word);
  }

  Color get _colorText {
    return _testCubit.colorCellText(word: word);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapedWord(word);
      },
      child: Container(
        width: double.infinity,
        color: _colorBacgr,
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 17, right: 16, bottom: 13),
          child: _content,
        ),
      ),
    );
  }

  Widget get _content {
    final text = rusWay ? word.rusValue : word.engValue;

    List<Widget> fondation = [Container(
          width: double.infinity,
          height: 19,
          child: Text(
            text, 
            style: TextStyle(color: _colorText, fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
            ),
        ),
        SizedBox(height: 9,)];

    if (word.descript == ""){
      fondation.add(SizedBox(height: 10,));
    } else {
      fondation.add(Container(
          height: 18,
          child: _childrenText,
        ),);
    }


    return Column(
      children: fondation,
    );


  }

  Row get _childrenText{

    List<Widget> listWidget = [
      Container(
        width: 85,
        child: Text(
            word.descript, 
            style: TextStyle(color: _colorText, fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
      ),
    ];

  return Row(children: listWidget);
}



}