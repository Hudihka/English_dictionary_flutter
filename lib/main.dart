
import 'package:english_dictionary_flutter/export.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  await DBProvider.db.initDB();
  await DBProvider.db.initListFavoriteWord();

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ThemeList(),
//     );
//   }
// }



class MyApp extends StatelessWidget {

    ThemeCubit themeCubit = ThemeCubit(ThemeState());
    WordCubit exploreCubit = WordCubit(WordsState());
    TestSelectedCubit testSelectedCubit = TestSelectedCubit(TestSelectedState())

    @override
    Widget build(BuildContext context) {
  
      return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => themeCubit..fetchContent(),
          ),
          BlocProvider<WordCubit>(
            create: (context) => exploreCubit,
          ),
          BlocProvider<TestSelectedCubit>(
            create: (context) => testSelectedCubit,
          ),
        ],
        child:  MaterialApp(
          home: Lenta(),
        ),
      );
    }
  
  
}

 