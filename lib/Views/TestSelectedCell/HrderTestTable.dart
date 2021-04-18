

import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';

class HrderTestTable extends StatelessWidget {


  TestSelectedCubit get _testCubit {
    return SingltonsCubit.shared.getTestSelectedCubit;
  }

  int get _countTrue {
    return _testCubit.getCountTrue;
  }

  int get _countFalse {
    return _testCubit.getCountFalse;
  }

  int get _countAll {
    return _testCubit.selectedState.words?.length ?? 0;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 17, right: 16, bottom: 13),
          child: _content,
        ),
    );
  }

  Widget get _content {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Container(
          width: double.infinity,
          height: 19,
          child: _getWidgetText(color: Colors.black, text: 'Всего $_countAll')
        ),
        SizedBox(height: 9,),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          _getWidgetText(color: Colors.green, text: '$_countTrue +'),
          SizedBox(width: 20,),
          _getWidgetText(color: Colors.red, text: '$_countFalse -'),
        ])],
    );


  }

  Text _getWidgetText({@required String text, @required Color color}){
    return Text(
            text, 
            style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            );
  }


}