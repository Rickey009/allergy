import 'dart:convert';

import '../ui/food_card.dart';
import '../http/http_model.dart';
import '../http/form_data.dart';

class FoodsCardModel {
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _foods = await getSweetsJson(apiName);

    FoodCard sweetCard = FoodCard();
    for (var i = 0; i < _foods.length; i++) {
      _cardList.add(sweetCard.createCard(_foods[i]));
    }
    return _cardList;
  }

  Future<List> getSweetsJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "food";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample2', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _sweets = [];

    for (int i = 0; i < jsonData.length; i++){

      _sweets.add(
          {
            'name': jsonData[i]['food']['name'],
            'note':  jsonData[i]['food']['note'],
            'imageUrlHttps': jsonData[i]['food']['image_url'],
            'favorite' : jsonData[i]['favorite']
          }
      );
    }
    return _sweets;
  }
}