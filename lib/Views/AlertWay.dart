import 'package:flutter/material.dart';

class AlertWay extends StatelessWidget {

  Function lening;
  Function rusEng;
  Function engRus;

  // AlertWay(Function lening, ){
  //   this._title = title;
  //   this._content = content;
  //   this._yesOnPressed = yesOnPressed;
  //   this._yes = yes;
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Выберите направление'),
      // content: Text(this._content),
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
      _remindButton(),
      _cancelButton(),
      _launchButton(),
    ],
    );
  }


  Widget _remindButton() {
    return FlatButton(textColor: Colors.black,
                      child: Text("Учить"),
                      onPressed: lening);
  }

  Widget _cancelButton() {
    return FlatButton(textColor: Colors.black,
                      child: Text("Rus -> Eng"),
                      onPressed: rusEng);
  }

   Widget _launchButton() {
    return FlatButton(textColor: Colors.black,
                      child: Text("Eng -> Rus"),
                      onPressed: engRus);
  }


}