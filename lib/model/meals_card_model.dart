import 'dart:convert';

import 'package:allergy/ui/meal_panel.dart';

import '../ui/meal_card.dart';
import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class MealsCardModel {

  /// カードのリストを作成する
  /// 
  /// 非同期でAPIから[apiName]の情報を取得する。
  /// 取得した[_tweets]のデータを使用してcustomCardを作成する。
  /// カードを追加した[_cardList]を返却する。
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _meals = await getMealsJson(apiName);

    MealCard mealCard = MealCard();
    MealExpansionPanel mealPanel = MealExpansionPanel();
    for (var i = 0; i < _meals.length; i++) {
      _cardList.add(mealCard.createCard(_meals[i]));
      //_cardList.add(mealPanel.createExpansionPanel(_meals[i]));
    }
    return _cardList;
  }

  /// tweet情報を取得する
  /// 
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<List> getMealsJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "diary";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _meals = [];

    for (int i = 0; i < jsonData.length; i++){
      final String _timeText = ConvertText().twitterTimetamp(jsonData[i]['created_at']);

      _meals.add(
          {
            'timeText': _timeText,
            'name': jsonData[i]['meal']['name'],
            'status': jsonData[i]['meal']['status'],
            'location': jsonData[i]['meal']['location'],
            'note':  jsonData[i]['meal']['note'],
            'imageUrlHttps': jsonData[i]['meal']['image_url'],
            'text': jsonData[i]['text'],
            'favoriteCount': jsonData[i]['favorite_count'] != 0 ? jsonData[i]['favorite_count'] : '',
            'retweetCount': jsonData[i]['retweet_count'] != 0 ? jsonData[i]['retweet_count'] : '',
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _meals;
  }
}