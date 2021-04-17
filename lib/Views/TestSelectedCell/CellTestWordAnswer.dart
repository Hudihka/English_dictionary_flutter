import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

class CellTestWordAnswer extends StatelessWidget {
  Word word;
  bool rusWay;

  CellTestWordAnswer({@required this.word, @required this.rusWay});

  TestSelectedCubit get _testCubit {
    return SingltonsCubit.shared.getTestSelectedCubit;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _testCubit.tapedWordAnsver(word);
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
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
          height: 25,
          child: Text(
            text, 
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
            ),
        ),
        SizedBox(height: 9,)];


    return Column(
      children: fondation,
    );


  }


}