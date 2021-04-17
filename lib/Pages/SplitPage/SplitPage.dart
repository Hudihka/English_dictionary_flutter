
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/export.dart';


class SplitPage extends StatelessWidget {

  bool rusWay;
  List<String> themesID;
  SplitPage({@required this.rusWay, @required this.themesID});

  BuildContext _context;
  TestSelectedCubit _contentCubit;

  @override
  Widget build(BuildContext context) {

    _contentCubit = context.read();
    _contentCubit.fetchContent(themesID: themesID, rusWay: rusWay);

    SingltonsCubit.shared.saveTestSelectedCubit(_contentCubit);

    return LayoutBuilder(
      builder: (context, constraints) {
        Widget child = Const.hDevice < Const.wDevice ? _TabletHomePage() : _MobileHomePage();
        return child;
      },
    );
  }

  // Widget _content(){

  //   Widget child = Const.hDevice < Const.wDevice ? _TabletHomePage() : _MobileHomePage();

  //   return WillPopScope(
  //     onWillPop: () { 
  //       SingltonsCubit.shared.getTestSelectedCubit.clearSelectedWord();
  //       Navigator.of(_context).pop();
  //      },
  //      child: child,
  //   );
  // }
}

class _MobileHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestSelectedFirst();
  }
}

class _TabletHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 280, child: TestSelectedFirst()),
        Expanded(child: TestSelectedTwo())
      ],
    );
  }
}



