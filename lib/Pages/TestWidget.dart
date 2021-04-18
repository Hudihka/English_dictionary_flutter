
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// https://stackoverflow.com/questions/48043908/pageview-disable-the-default-scrolling-and-replace-it-with-tap-event
//https://medium.com/flutter-community/a-deep-dive-into-pageview-in-flutter-with-custom-transitions-581d9ea6dded
class TestWidget extends StatefulWidget {

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool showTwo = false;
  PageController controller = PageController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return PageView(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        scafold1(),
        scafold2(),
      ],
  );
  }



  // List<Widget> _listWidgets(){
  //   if (showTwo){
  //     return [scafold1(), scafold2()];
  //   } else {
  //     return [scafold1()];
  //   }
  // }


  Widget scafold1(){
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.red,
      resizeToAvoidBottomInset: false,
      body: RaisedButton(onPressed: (){
        // controller.jumpToPage(1);
        controller.animateToPage(1, curve: Curves.decelerate, duration: Duration(milliseconds: 300));

        // setState(() {});
      })
    );
  }

  Widget scafold2(){
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: RaisedButton(onPressed: (){
        // controller.jumpToPage(0);
        controller.animateToPage(0, curve: Curves.decelerate, duration: Duration(milliseconds: 300));
      })
    );
  }



}

