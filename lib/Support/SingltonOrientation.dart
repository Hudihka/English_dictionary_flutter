

import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/services.dart';


class SingltonOrientation{

  SingltonOrientation._();
  static final SingltonOrientation shared = SingltonOrientation._();


  oneOrientation(){
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
  }

  twoOrientation(){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
  }




}
