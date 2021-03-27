import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

enum _EnumKeys{
  wayTranslate,
  hideTranslate
}


class DefaultUtils{

  DefaultUtils._();
  static final DefaultUtils shared = DefaultUtils._();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _getKey(_EnumKeys enumValue){
    switch(enumValue){
      case _EnumKeys.wayTranslate: return "wayTranslate";
      case _EnumKeys.hideTranslate: return "hideTranslate";
    }
  }

  //wayTranslate

  Future<int> get wayTranslate async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.wayTranslate);
    return prefs.get(key) ?? 0;
  }


  Future<void> saveWayTranslate(int index) async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.wayTranslate);
    prefs.setInt(key, index);
  }

  //hideTranslate

  Future<bool> get hideTranslate async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.hideTranslate);
    return prefs.get(key) ?? true;
  }

  Future<void> saveHideValue(bool value) async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.hideTranslate);
    prefs.setBool(key, value);
  }


}
