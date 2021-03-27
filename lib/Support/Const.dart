import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';
import 'dart:io' show Platform;



class Const {

  //COLOR

  static Color clearColor = Colors.red.withOpacity(0);
  static Color lightGrey  = "F2F2F2".getColor(alpha: 0.2);



  static double hDevice = 0;
  static double wDevice = 0;
  static double statusBarHeight = 0;

  static setSize(BuildContext cont){
    final size = MediaQuery.of(cont).size;

    hDevice = size.height;
    wDevice = size.width;

    statusBarHeight = MediaQuery.of(cont).padding.top;
  }

  static bool get itIOS {
    return Platform.isIOS;
  }

  static bool get itAndroid {
    return Platform.isAndroid;
  }

  static double get heightVideo {
    return Const.wDevice * 216 / 375;
  }

  //методы для иос

  static bool get isIPhone5 {
    return hDevice == 568;
  }

  static bool get isIPhoneXorXmax {
    return hDevice >= 812;
  }


  static int get navigBarHeight{
    return 44;
  }


  static int get heightTabBar {
    return isIPhoneXorXmax ? 84 : 58;
  }

  //методы для андроида



  //методы сразу для 2х систем


  static double get fullHeightNB {
    return AppBar().preferredSize.height + statusBarHeight;//88 : 64
  } 

   static double get fullHeightBody {
    return Const.hDevice - Const.fullHeightNB;
  } 

}
