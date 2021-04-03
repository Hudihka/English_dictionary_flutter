import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'ThemeCubit.dart';
import 'WordCubit.dart';


class SingltonsCubit{

  SingltonsCubit._();
  static final SingltonsCubit shared = SingltonsCubit._();

  WordCubit _wordCubit;
  ThemeCubit _contentCubit;

  saveThemeCubit(ThemeCubit cubit){
    _contentCubit = cubit;
  }

  ThemeCubit get getThemeCubit {
    return _contentCubit;
  }


  saveWordCubit(WordCubit cubit){
    _wordCubit = cubit;
  }

  WordCubit get getWodrCubit {
    return _wordCubit;
  }


}
