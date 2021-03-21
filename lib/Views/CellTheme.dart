import 'package:english_dictionary_flutter/Models/ThemeWords.dart';
import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';

class CellTheme extends StatelessWidget {
  bool selected;
  ThemeWords theme;

  Function(ThemeWords) presedTheme;

  CellTheme({@required this.selected, @required this.theme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        presedTheme(theme);
      },
      child: Container(
        width: double.infinity,
        color: selected ? Colors.black : Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 17, right: 16, bottom: 13),
          child: _content,
        ),
      ),
    );
  }

  Widget get _content {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 19,
          child: Text(
            theme.name, 
            style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
            ),
        ),
        SizedBox(height: 9,),
        Container(
          height: 18,
          child: _childrenText,
        ),
      ],
    );


  }

  Row get _childrenText{

    int count = theme.listWord.length;
    int coutnFavorite = theme.countFavorit;

    List<Widget> listWidget = [
      Container(
        width: 85,
        child: Text(
            '$count слов', 
            style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
      ),
    ];

    if (coutnFavorite != 0){

      List<Widget> listWidget2 = [
      Container(
                width: 20,
                height: 19,
                decoration: BoxDecoration(
                  // shape: BoxShape.,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/icons/favorit.png"),
                  ),
                ),
              ),
      SizedBox(width: 8,),
      Container(
        width: 50,
        child: Text(
            '$coutnFavorite', 
            style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
      ),
    ];

    listWidget = listWidget + listWidget2;
    return Row(children: listWidget);
  }

}



}