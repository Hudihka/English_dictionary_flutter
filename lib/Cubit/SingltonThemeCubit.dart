import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'ThemeCubit.dart';


class SingltonThemeCubit{

  SingltonThemeCubit._();
  static final SingltonThemeCubit shared = SingltonThemeCubit._();


  ThemeCubit _contentCubit;

  saveThemeCubit(ThemeCubit cubit){
    _contentCubit = cubit;
  }

  ThemeCubit get getThemeCubit {
    return _contentCubit;
  }


}
