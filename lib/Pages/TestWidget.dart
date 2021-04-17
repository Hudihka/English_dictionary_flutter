
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestWidget extends StatefulWidget {

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool showTwo = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _listWidgets()
    );


  }

  List<Widget> _listWidgets(){
    if (showTwo){
      return [scafold1(), scafold2()];
    } else {
      return [scafold1()];
    }
  }


  Widget scafold1(){
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.red,
      resizeToAvoidBottomInset: false,
      body: RaisedButton(onPressed: (){
        showTwo = true;
        setState(() {});
      })
    );
  }

  Widget scafold2(){
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: RaisedButton(onPressed: (){
        showTwo = false;
        setState(() {});
      })
    );
  }

}

