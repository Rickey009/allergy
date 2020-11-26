import 'dart:convert';

import 'package:allergy/ui/sweet_card.dart';

import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class SweetsCardModel {
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _sweets = await getSweetsJson(apiName);

    SweetCard sweetCard = SweetCard();
    for (var i = 0; i < _sweets.length; i++) {
      _cardList.add(sweetCard.createCard(_sweets[i]));
    }
    return _cardList;
  }

  /// tweet情報を取得する
  /// 
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<List> getSweetsJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "sweet";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample2', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _sweets = [];

    for (int i = 0; i < jsonData.length; i++){

      _sweets.add(
          {
            'itemId': "1",
            'name': jsonData[i]['sweet']['name'],
            'note':  jsonData[i]['sweet']['note'],
            'material':  jsonData[i]['sweet']['material'],
            'imageUrlHttps': jsonData[i]['sweet']['image_url'],
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _sweets;
  }
}