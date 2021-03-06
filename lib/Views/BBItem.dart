import 'package:flutter/material.dart';

class BBItem extends StatelessWidget {
  String text;
  Function action;
  bool shadow = false;

  BBItem({@required this.shadow, @required this.text, @required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        // height: 30,
        child: Padding(
            padding: EdgeInsets.all(6),

            child: Container(
              width: 41,
              height: 26,
              // color: ,
              decoration: shadow ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 8,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
              ) : null,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _rectForBBItem,
              ),
            )
          ),
    );
  }

  Widget get _rectForBBItem {

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: TextButton(
          onPressed: action,
          child: Center(
              child: Text(text, style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
            ),
          )
    );
  }

}