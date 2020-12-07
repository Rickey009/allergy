
import 'dart:convert';

import '../ui/talk_card.dart';

import '../http/http_model.dart';
import '../http/form_data.dart';

class TalkCardModel {
  Future<List> createCardList() async{
    List _cardList = [];
    final _talkList = await getTalkListJson();

    TalkCard talkCard = TalkCard();
    for (var i = 0; i < _talkList.length; i++) {
      _cardList.add(talkCard.createCard(_talkList[i]));
    }
    return _cardList;
  }

  Future<List> getTalkListJson() async{
    FormData formData = FormData();
    formData.param001 = "lookup";
    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample7', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
     List _talkList = [];

    for (int i = 0; i < jsonData.length; i++){

      _talkList.add(
          {
            'date': jsonData[i]["date"],
            'time': jsonData[i]["time"],
            'categoryId': jsonData[i]["categoryId"],
            'numOfComments': jsonData[i]["numOfComments"],
            'target': jsonData[i]["target"],
            'title': jsonData[i]["title"],
          }
      );
    }
    return _talkList;
  }
}