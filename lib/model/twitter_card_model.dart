import 'dart:convert';

import '../ui/custom_card.dart';
import '../http/http_model.dart';
import '../http/form_data.dart';
import '../util/convert_text.dart';
import '../util/get_local_object.dart';

class TwitterCardModel {

  /// カードのリストを作成する
  /// 
  /// 非同期でAPIから[apiName]の情報を取得する。
  /// 取得した[_tweets]のデータを使用してcustomCardを作成する。
  /// カードを追加した[_cardList]を返却する。
  Future<List> createCardList(String apiName) async{
    List _cardList = [];
    final _tweets = await getTweetsJson(apiName);

    CustomCard customCard = CustomCard();
    for (var i = 0; i < _tweets.length; i++) {
      _cardList.add(customCard.createCard(_tweets[i]));
    }
    return _cardList;
  }

  /// tweet情報を取得する
  /// 
  /// [_userTimelinePath]のJsonデータを取得する。
  /// 取得した[jsonData]から必要な情報を取得し、[_tweets]に詰めて返却する。
  Future<List> getTweetsJson(String apiName) async{
    String _userTimelinePath;
    Map<String, String> _userTimelineParam;

    switch (apiName) {
      case 'home_timeline':
          _userTimelinePath = 'statuses/home_timeline.json';
          _userTimelineParam = {
            'count': '3',
            'include_entities': 'true',
          };
        break;
      default:
          _userTimelinePath = 'statuses/home_timeline.json';
          _userTimelineParam = {
            'count': '10',
            'include_entities': 'true',
          };
    }
    FormData formData = FormData();
    formData.param001 = "1";
    var jsonData = await ApiDao().getJson('https://nmx516t6g4.execute-api.ap-northeast-1.amazonaws.com/PFM_POCK/sample', formData, ['content-type', 'application/json']);
    jsonData = jsonDecode(jsonData["body"]);
    //final jsonData = await LoadLocalJson().getJson('assets/jsons/timeline.json');
    List _tweets = [];

    for (int i = 0; i < jsonData.length; i++){
      final String _timeText = ConvertText().twitterTimetamp(jsonData[i]['created_at']);
      final List<String> _images = [];

      String _text = jsonData[i]['text'];
      try {
        _images.add(jsonData[i]['entities']['media'][0]['media_url']);
        /// textに画像1枚目のURLが含まれているので削除する
        if (_text.contains(jsonData[i]['entities']['media'][0]['url'])) {
          _text = _text.replaceAll(jsonData[i]['entities']['media'][0]['url'], '');
        }
        for (var _url in jsonData[i]['extended_entities']['media']) {
          _images.add(_url['media_url']);
        }
      } catch (e) {
      }

      _tweets.add(
          {
            'timeText': _timeText,
            'name': jsonData[i]['user']['name'],
            'screenName': jsonData[i]['user']['screen_name'],
            'profileImageUrlHttps': jsonData[i]['user']['profile_image_url_https'],
            'text': _text,
            'image': _images,
            'favoriteCount': jsonData[i]['favorite_count'] != 0 ? jsonData[i]['favorite_count'] : '',
            'retweetCount': jsonData[i]['retweet_count'] != 0 ? jsonData[i]['retweet_count'] : '',
          }
      );
    }
    return _tweets;
  }
}