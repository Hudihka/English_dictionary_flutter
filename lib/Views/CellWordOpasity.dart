import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:english_dictionary_flutter/Models/Word.dart';
import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';


class CellWordOpasity extends StatefulWidget {

  Word word;
  bool rusWay;

  Function(Word) presedWord;

  CellWordOpasity({@required this.word, @required this.rusWay});



  @override
  _CellWordOpasityState createState() => _CellWordOpasityState();
}



class _CellWordOpasityState extends State<CellWordOpasity> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: hideTarnslate ? () {
      //   //показываем перевод
      // } : null,
      onTap: () {
        print('--------------');
        //показываем перевод
      },

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

    final favorit = widget.word.favorit ?? false;

    final imageName = favorit ? "assets/icons/favorit.png" : "assets/icons/not_favorit.png";

    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Container(
          color: Colors.white,
          width: Const.wDevice - 50,
          child: Padding(
          padding: EdgeInsets.only(left: 20, top: 0, right: 0, bottom: 0),
          child: Text(widget.rusWay ? widget.word.rusValue : widget.word.engValue,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        ),



        GestureDetector(
          onTap: () {
            print('--------------1111111');
            // presedWord(word);
          },
        child: Container(
          alignment: Alignment.topRight,
          width: 50,
          height: 50,
          color: Colors.white,
          child: Center(
            child: Container(
              height: 25,
              width: 25,
              child: Image.asset(imageName)
            )
          )
          
          
        
      ),
    )
      ],
    );
  }

  Widget get animatedContainer {

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: _containerFooter,
      onEnd: (){
        
      },
    );

  }



  Container get _containerFooter {

    String translate = widget.rusWay ? widget.word.engValue : widget.word.rusValue;
    Color colorText = widget.hideTarnslate ? Const.clearColor : Colors.black;

    final descr = widget.word.descript;
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