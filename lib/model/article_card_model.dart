import 'dart:convert';

import '../ui/article_card.dart';
import '../http/http_model.dart';
import '../http/form_data.dart';

class ArticleCardModel {
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _articles = await getArticlesJson(apiName);

    ArticleCard articleCard = ArticleCard();
    for (var i = 0; i < _articles.length; i++) {
      _cardList.add(articleCard.createCard(_articles[i]));
    }
    return _cardList;
  }

  Future<List> getArticlesJson(String apiName) async{
    FormData formData = FormData();
    formData.param001 = "";

    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample5', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    List _article = [];

    for (int i = 0; i < jsonData.length; i++){

      _article.add(
          {
            'title': jsonData[i]['article']['title'],
            'date':  jsonData[i]['article']['date'],
            'writer': jsonData[i]['article']['writer'],
            'url' : jsonData[i]['article']['url']
          }
      );
    }
    return _article;
  }
}