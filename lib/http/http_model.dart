import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:allergy/http/form_data.dart'
;
class ApiDao {
  final http.Client httpClient = http.Client();
  /// TwitterAPIから情報を取得する
  /// 
  /// [path]に対して[param]を付与し、Getで接続する
  /// 取得したJsonをDecodeして返却する
  Future getJson(String url, FormData param, List headers) async {
    var result = await httpClient.post(url, body: json.encode(param.toJson()), headers: {headers[0]: headers[1]});
    //var result = await httpClient.post(url, body: "", headers: {headers[0]: headers[1]});
    return jsonDecode(result.body);
  }
}
