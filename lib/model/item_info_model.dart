import 'dart:convert';

import '../ds/recipe_data.dart';

import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class ItemDetailModel {
  Future<Map> createItemData(String argId) async {
    final Map dataMap = await getDetailJson(argId);

    return dataMap;
  }

  Future<Map> getDetailJson(String argId) async {
    FormData formData = FormData();
    formData.param001 = argId;
    var jsonData = await ApiDao().getJson(
        'https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample6',
        formData,
        ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    print(jsonData[0].toString());
    Map rtnMap = {
      'itemId': jsonData[0]['item']['id'],
      'number': jsonData[0]['item']['number'],
      'name': jsonData[0]['item']['name'],
      'imageUrl': jsonData[0]['item']['image_url'],
      'price': jsonData[0]['item']['price'],
      'amount': jsonData[0]['item']['amount'],
      'status': jsonData[0]['item']['status'],
      'materials': jsonData[0]['item']['material'],
      'allergenFlg': jsonData[0]['item']['allergenFlg'],
      'note': jsonData[0]['item']['note'],
    };
    return rtnMap;
  }
}
