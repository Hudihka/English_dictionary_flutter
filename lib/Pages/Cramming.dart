import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String textSertch = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navigBar(),
      ),
    );
  }


  //ТИТУЛЬНИК

  Row _navigBar(){
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          height: 35.0,
          width: Const.wDevice - 10 - 80,
          child: Container(
            decoration: new BoxDecoration(
              color: "F2F2F2".getColor(alpha: 0.75),
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
              style: TextStyle(color: _emptyText ? Const.lightGrey : Colors.black, ),),
            ),
          ),
          onTap: _emptyText ? null : () {
            textSertch = "";
            //очистить
          },
        )
      ]
    );
  }

  TextField _getTextField() {
    return TextField(
      // focusNode: _focusNode,
      // obscureText: !isName,
      style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Const.clearColor),
        ),
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
        textSertch = str;
        setState(() {});
        //запусекаем поиск
      },
      onSubmitted: (str) {
        //если пользователь нажал ВВод
        // if (isName) {
        //   FocusScope.of(context).previousFocus();
        // }
        
      },
    );
  }

  bool get _emptyText {
    return textSertch == "";
  }


}
