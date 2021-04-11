import 'package:english_dictionary_flutter/export.dart';

class WordsState {

  List<Word> words;

  int indexSegment;
  bool hideTranslate;

  String textSertch;

  WordsState({this.words, this.indexSegment, this.hideTranslate, this.textSertch});

  WordsState copyWith({List<Word> newWords, 
                       int newIndexSegment, 
                       bool newHideTranslate,
                       String newTextSertch}){

    if (newWords != null){
      this.words = newWords;
    }

    if (newIndexSegment != null){
      this.indexSegment = newIndexSegment;
    }

    if (newHideTranslate != null){
      this.hideTranslate = newHideTranslate;
    }

    if (newTextSertch != null){
      this.textSertch = newTextSertch;
    }
    
    return WordsState(words: words,
                      indexSegment: indexSegment,
                      hideTranslate: hideTranslate,
                      textSertch: textSertch ?? "");

  }
  
}


class WordCubit extends Cubit<WordsState>{

  List<String> themesID;
  
  List<Word> _listWord = [];
  List<Word> _sertchWords = [];

  int _indexTranslete = 0;

  String _text = "";
  bool firstLoad = false;
  

  final DBProvider cash = DBProvider.db;
  final DefaultUtils userDF = DefaultUtils.shared;

  final WordsState userState;

  WordCubit(this.userState, {@required this.themesID}) : super(WordsState());


  Future<void> fetchContent() async {

    if (firstLoad){
      return;
    }

    firstLoad = true;

    _indexTranslete = await userDF.wayTranslate;
    final hideTranslate = await userDF.hideTranslate;

    _listWord = await cash.getWordsSorted(themesID, _indexTranslete == 0, text: _text);

    emit(userState.copyWith(newWords: _listWord, 
    newIndexSegment: _indexTranslete, 
    newHideTranslate: hideTranslate, 
    newTextSertch: _text));
  }

  switchAction(bool newValue) async {
    await userDF.saveHideValue(newValue);
    emit(userState.copyWith(newHideTranslate: newValue));
  }

  newWayTranslate(int newValue) async {
    firstLoad = false;
    _text = "";
    await userDF.saveWayTranslate(newValue);
    await fetchContent();
  }


  textSertch(String text) {

    _text = text;

    if (text == ""){
      emit(userState.copyWith(newWords: _listWord, newTextSertch: _text));
      return;
    }

    if (_indexTranslete == 0){
      _sertchWords = _listWord.where((element) => element.rusValue.contains(text)).toList();
    } else {
      _sertchWords = _listWord.where((element) => element.engValue.contains(text)).toList();
    }

    emit(userState.copyWith(newWords: _sertchWords, newTextSertch: _text));
  }

  pressLikeButton(Word word) async {
    await DBProvider.db.likeButton(word);
    textSertch(_text);
    SingltonsCubit.shared.getThemeCubit.reloadFavorit();
  }

}


