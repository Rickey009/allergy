import 'dart:convert';

import 'package:allergy/ui/staple_card.dart';

import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class StapleCardModel {
  Future<List> createCardList(String argFlg) async{
    List _cardList = [];
    final _staple = await getStapleJson(argFlg);

    StapleCard stapleCard = StapleCard();
    for (var i = 0; i < _staple.length; i++) {
      _cardList.add(stapleCard.createCard(_staple[i]));
    }
    return _cardList;
  }

  /// tweet情報を取得する
  /// 
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<List> getStapleJson(String argFlg) async{
    FormData formData = FormData();
    formData.param001 = argFlg;

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample3', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _staple = [];

    for (int i = 0; i < jsonData.length; i++){

      _staple.add(
          {
            "recipeId": jsonData[i]['recipe_id'].toString(),
            'name': jsonData[i]['staple']['name'],
            'material':  jsonData[i]['staple']['material'],
            'note': jsonData[i]['staple']['note'],
            'imageUrlHttps': jsonData[i]['staple']['image_url'],
            'movieUrl': jsonData[i]['staple']['movie_url'],
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _staple;
  }
}