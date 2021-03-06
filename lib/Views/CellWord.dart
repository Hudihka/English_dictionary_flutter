import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

class CellWord extends StatelessWidget {
  Word word;
  bool rusWay;

  Function(Word) presedWord;

  CellWord({@required this.word, @required this.rusWay});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white, 
        child: Column(
          children: [
            _hederCell,
            _containerFooter
          ]
        )
      );
  }


  Row get _hederCell {

    final favorit = word.favorit ?? false;

    final imageName = favorit ? "assets/icons/favorit.png" : "assets/icons/not_favorit.png";

    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Container(
          color: Colors.white,
          width: Const.wDevice - 50,
          child: Padding(
          padding: EdgeInsets.only(left: 20, top: 0, right: 0, bottom: 0),
          child: Text(rusWay ? word.rusValue : word.engValue,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        ),



        GestureDetector(
          onTap: () {
            SingltonsCubit.shared.getWodrCubit.pressLikeButton(word);
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

  Container get _containerFooter{

    String translate = rusWay ? word.engValue : word.rusValue;

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
            style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
          ),
        )
    );
  }

}