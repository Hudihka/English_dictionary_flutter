import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/Extension/String.dart';
import 'dart:io' show Platform;



class Const {

  //COLOR

  static Color clearColor = Colors.red.withOpacity(0);
  static Color lightGrey  = "F2F2F2".getColor(alpha: 0.2);


  //IMAGE

  static String iconWay(String nameIcon){
    return 'assets/icons/$nameIcon';
  }

  static String imageWay(String nameIcon){
    return 'assets/images/$nameIcon';
  }

  //SIze devise

  static double hDevice = 0;
  static double wDevice = 0;

  static setSize(BuildContext cont){
    final size = MediaQuery.of(cont).size;

    hDevice = size.height;
    wDevice = size.width;
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

  static int get statusBarHeightIphone {
    return isIPhoneXorXmax ? 44 : 20;
  }

  static int get navigBarHeight{
    return 44;
  }

  static int get fullHeightNB {
    return statusBarHeightIphone + navigBarHeight;//88 : 64
  } 

  static int get heightTabBar {
    return isIPhoneXorXmax ? 84 : 58;
  }

  //методы для андроида

  static int get statusBarHeightAndroid {
    return 24;
  }


  //методы сразу для 2х систем

  static int get statusBarHeight {
      return itIOS ? statusBarHeightIphone : statusBarHeightAndroid;
  }

}

