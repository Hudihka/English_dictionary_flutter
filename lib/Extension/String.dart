
import 'package:english_dictionary_flutter/export.dart';

extension ExtensionString on String {
  String get generateMd5 {
    return md5.convert(utf8.encode(this)).toString();
  }

  Color getColor({double alpha}){

    Color returnColor = Color(int.parse("0xff$this"));

    if (alpha != null) {
      if (alpha >= 0) {
        if (alpha <= 1) {
          return returnColor.withOpacity(alpha);
        }
      }
    }

    return returnColor;
  
  }
}
