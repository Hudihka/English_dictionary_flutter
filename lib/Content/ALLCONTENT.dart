

import 'package:english_dictionary_flutter/Content/Prepositions.dart';
import 'package:english_dictionary_flutter/Content/ProfessionAndWork.dart';
import 'package:english_dictionary_flutter/Content/Subjects.dart';
import 'package:english_dictionary_flutter/Content/Time.dart';

class AllContent {
  static List<Map<String, dynamic>> allContent = [
    Prepositions.allWord,
    ProfessionAndWork.allWord,
    Subjects.allWord,
    Time.allWord
  ];
}
