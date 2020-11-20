import 'dart:convert';

import '../ds/recipe_data.dart';

import '../http/http_model.dart';
import '../util/convert_text.dart';
import '../http/form_data.dart';

class RecipeModel {
  Future<RecipeData> createRecipeData(String argId) async {
    final RecipeData recipeData = await getRecipeJson(argId);

    return recipeData;
  }

  /// tweet情報を取得する
  ///
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<RecipeData> getRecipeJson(String argId) async {
    FormData formData = FormData();
    formData.param001 = argId;
    var jsonData = await ApiDao().getJson(
        'https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample4',
        formData,
        ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);

    List<Map<String, String>> _materialList = [];
    for (int i = 0; i < jsonData[0]['recipe']['material'].length; i++) {
      Map<String, String> _materialMap = {
        'name': jsonData[0]['recipe']['material'][i]['name'],
        'amount': jsonData[0]['recipe']['material'][i]['amount'],
        'buy': jsonData[0]['recipe']['material'][i]['buy'],
      };
      _materialList.add(_materialMap);
    }

    RecipeData recipeData = new RecipeData(
        name: jsonData[0]['recipe']['name'],
        materialList: _materialList);

    return recipeData;
  }
}
