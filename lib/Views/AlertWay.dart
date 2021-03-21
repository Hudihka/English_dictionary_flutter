import 'package:flutter/material.dart';

class AlertWay extends StatelessWidget {

  Function lening;
  Function rusEng;
  Function engRus;

  BuildContext context;

  AlertWay({@required this.context});

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
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        lening();
                      });
  }

  Widget _cancelButton() {
    return FlatButton(textColor: Colors.black,
                      child: Text("Rus -> Eng"),
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        rusEng();
                      });
  }

   Widget _launchButton() {
    return FlatButton(textColor: Colors.black,
                      child: Text("Eng -> Rus"),
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        engRus();
                      });
  }

}