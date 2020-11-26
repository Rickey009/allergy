import 'dart:convert';

import '../ui/location_card.dart';

import '../http/http_model.dart';
import '../http/form_data.dart';

class LocationCardModel {
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _location = await getLocationJson(apiName);

    LocationCard locationCard = LocationCard();
    for (var i = 0; i < _location.length; i++) {
      _cardList.add(locationCard.createCard(_location[i]));
    }
    return _cardList;
  }

  /// tweet情報を取得する
  /// 
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<List> getLocationJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "location";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample2', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _location = [];

    for (int i = 0; i < jsonData.length; i++){

      _location.add(
          {
            'name': jsonData[i]['shop']['name'],
            'latitude': jsonData[i]['shop']['latitude'],
            'longitude': jsonData[i]['shop']['longitude'],
            'note':  jsonData[i]['shop']['note'],
            'imageUrlHttps': jsonData[i]['shop']['image_url'],
            'tel': jsonData[i]['shop']['tel'],
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _location;
  }
}