import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';

class CellWord extends StatelessWidget {
  Word word;
  bool rusWay;
  bool hideTarnslate;

  Function(Word) presedWord;

  CellWord({@required this.word, @required this.rusWay, @required this.hideTarnslate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideTarnslate ? () {
        //показываем перевод
      } : null,

      child: Container(
        width: double.infinity,
        color: Colors.white, 
        child: Column(
          children: [
            _hederCell,
            _containerFooter
          ]
        )
      ),
    );
  }


  Row get _hederCell {

    final imageName = word.favorit ? "assets/icons/favorit.png" : "assets/icons/not_favorit.png";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 5, right: 0, bottom: 0),
          child: Text(rusWay ? word.rusValue : word.engValue,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: () {
            presedWord(word);
          },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
          child: Center(
            child: Image.asset(imageName)
          )
      ),
    )
      ],
    );
  }

  Container get _containerFooter{

    String translate = rusWay ? word.engValue : word.rusValue;
    Color colorText = hideTarnslate ? Const.clearColor : Colors.black;

    final descr = word.descript;
    if (descr != ""){
      translate = translate + "/n/n$descr";
    }

    return Container(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.only(left: 20, top: 7, right: 16, bottom: 10),
          child: Text(translate,
            textAlign: TextAlign.left,
            style: TextStyle(color: colorText, fontSize: 23, fontWeight: FontWeight.w500),
          ),
        )
    );
  }

}