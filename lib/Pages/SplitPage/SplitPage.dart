
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
        bool horizontalOrient = Const.hDevice < Const.wDevice;

        Widget child = horizontalOrient ? _TabletHomePage(horizontalOrient: horizontalOrient,) : TestSelectedFirst();
        return child;
      },
    );
  }

}



class _TabletHomePage extends StatelessWidget {
  bool horizontalOrient; 
  _TabletHomePage({@required this.horizontalOrient});

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



