import 'dart:convert';

import 'package:allergy/ui/staple_card.dart';

import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class StapleCardModel {
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _staple = await getStapleJson(apiName);

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
  Future<List> getStapleJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "3";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _staple = [];

    for (int i = 0; i < jsonData.length; i++){

      _staple.add(
          {
            'name': jsonData[i]['sweet']['name'],
            'note':  jsonData[i]['sweet']['note'],
            'imageUrlHttps': jsonData[i]['sweet']['image_url'],
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _staple;
  }
}