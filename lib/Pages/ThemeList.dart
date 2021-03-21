import 'package:english_dictionary_flutter/Support/Const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/ThemeCubit.dart';
import '../Models/ThemeWords.dart';


class ThemeList extends StatelessWidget {
  final state = ThemeState();

  @override
  Widget build(BuildContext context) {
    Const.setSize(context);

    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(state),
      child: Lenta()
    );
  }
}

class Lenta extends StatelessWidget {

  BuildContext _context;
  ThemeCubit _contentCubit;

  List<Theme> _dataArray = [];
  List<Theme> _selectedList = [];
  bool _selectedAll = false;

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    _contentCubit = context.read();
    _contentCubit.fetchContent();

    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      if (state is ThemeState) {

        



        return _createTable();

        // _dataArray = state.listContent ?? [];

        // if (_dataArray.isEmpty) {
        //   return Center(
        //   child: CircularProgressIndicator(
        //               valueColor:  AlwaysStoppedAnimation<Color>(Colors.black),
        //             ),
        // );
        // } else {
        //   return _createTable();
        // }
      }
    });
  }

  Widget _createTable() {
    // final _newList = _reloadList(dataArray);

    return ListView.builder(
          itemCount: _dataArray.length + 1,
          itemBuilder: (context, index) {

            if (index == 0){

            } else {

            }

            // Content obj = _dataArray[index];

            // switch (obj.typeCell) {
            //   case EnumTupeCell.content:
            //     return _cellContent(obj);
            //   case EnumTupeCell.registration:
            //     return _cellRegistration();
            //   case EnumTupeCell.tags:
            //     return _categoruCell();
            // }
    });
  }

  //ЯЧЕЙКА ПО ИНДЕКСУ

  // RegistrationCell _cellRegistration() {
  //   final cell = RegistrationCell();
  //   final autPage = AutorizationPage();
  //   autPage.goodRequest = () {
  //     _contentCubit.cleraContentAndLoad();
  //   };

  //   cell.tapedRegistration = () {
  //     Navigator.push(
  //       _context,
  //       MaterialPageRoute(
  //           builder: (context) => autPage, fullscreenDialog: true),
  //     );
  //   };
  //   return cell;
  // }

  // ChooseCategogyCell _categoruCell() {
  //   final cell = ChooseCategogyCell();
  //   cell.tapedCategorus = () {
  //     print('нажали на выбор категорий');
  //   };

  //   return cell;
  // }

  // CellContent _cellContent(Content obj) {
  //   CellContent cell = CellContent(obj, _isAutoriz);

  //   cell.tapedReaction = (bool like, Content conte) {
  //     _pressButtonOnCell(conte, like);
  //   };

  //   cell.tapedCell = (Content conte) {
  //     final detailPage = DetailInfoPage(conte, isUserAutiriz: _isAutoriz,);

  //     Navigator.push(
  //         _context, MaterialPageRoute(builder: (context) => detailPage));
  //   };

  //   cell.tapedThreePoint = (Content conte) {
  //     List<String> list = ['View detail', 'Share', 'Complain'];
  //     final curtain = ThreeButtonCurtain(texts: list);
  //     curtain.actionTaped = (enumValue) {
  //       if (enumValue == EnumTapedButtonCurtain.top) {
  //         print('taped top');
  //       } else if (enumValue == EnumTapedButtonCurtain.midle) {
  //         print('taped midle');
  //       } else {
  //         print('taped dow');
  //       }
  //     };

  //     _presentCurtain(curtain);
  //   };

  //   return cell;
  // }

  // Future<void> _refresh() async {
  //   if (_loadStatus == false) {
  //     //идем в верх по дереву виджетов пока не дойдем до блока
  //     // final UserCubit userCubit = context.read();
  //     // userCubit.reloadUser();
  //   }
  // }

  // _pressButtonOnCell(Content obj, bool pressLike) {
  //   if (_loadStatus) {
  //     return;
  //   }

  //   _contentCubit.reaction(obj, pressLike);
  // }

  // _presentCurtain(Widget curtain) {
  //   showModalBottomSheet(
  //       context: _context,
  //       elevation: 10,
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(21),
  //         ),
  //       ),
  //       builder: (BuildContext bc) {
  //         return curtain;
  //       });
  // }
}





// class ThemeList extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     //говорит о том, что грузим юзеров при запуске
//     final ThemeCubit userCubit = context.read();
//     userCubit.fetchUser();

//     return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {

//       if (state is ThemeState){
//         List<ThemeWords> _dataArray = state.listThemes;
//         bool _loadStatus = state.loadStatus;

//         if (_dataArray.isEmpty)  {
//           return Center(child: _loadStatus ? CircularProgressIndicator() : 
//                                              Text('На бэке пусто', style: TextStyle(fontSize: 20)
//                   ));
//         } else {

//           return RefreshIndicator(
//             child: ListView.builder(
//                 itemCount: _dataArray.length,
//                 itemBuilder: (context, index) {
//                   ThemeWords obj = _dataArray[index];
//                   return _cellForIndex(obj);
//                 }),
//             onRefresh: (){
//               return _refresh(context, _loadStatus);
//             },
//           );
//         }
//       }

//     });
//   }

//   Widget _cellForIndex(ThemeWords obj) {
//     //ячейка по индексу

//     return Ink(
//       color: Colors.grey[50], //выделение ячейки
//       child: ListTile(
//         subtitle: Text(obj.name),
//         title: Text(obj.name),
//         // leading: CircleAvatar(
//         //   child: Text(obj.id.toString()),
//         // ),
//         trailing: Text('слов ${obj.listWord.length}'),
//         onTap: () {
//           print('--------- ${obj.name} ---------------');
//         },
//       ),
//     );
//   }

//   Future<void> _refresh(BuildContext context, bool loadStatus) async {
//     if (loadStatus == false) {
//       //идем в верх по дереву виджетов пока не дойдем до блока
//       final ThemeCubit userCubit = context.read();
//       // userCubit.reloadUser();
//     }
//   }

// }

