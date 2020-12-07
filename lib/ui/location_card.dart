import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.Dart';
import '../page/image_preview.dart';
import '../page/google_map.dart';

class LocationCard {
  Widget createCard(Map locationData) {
    return _LocationCard(locationData);
  }
}

class _LocationCard extends StatelessWidget {
  final Map _locationData;

  _LocationCard(
    this._locationData,
  );

  void _forwardRecipePage(argContext, argStapleData) async {
    Navigator.push(
        argContext,
        MaterialPageRoute(
          builder: (context) => MapPage(
              locationName: argStapleData["name"],
              latitude: double.parse(argStapleData["latitude"]),
              longitude: double.parse(argStapleData["longitude"])),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Card(
        child: InkWell(
      onTap: () => _forwardRecipePage(context, _locationData),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  color: Colors.white70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _Image(
                                imageUrl: _locationData['imageUrlHttps']),
                          ),
                          Expanded(
                            child: Container(
                                height: deviceHeight * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: getFavoriteWidgets(
                                              _locationData['favorite']),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
//                                color: Colors.red[50],
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            _locationData['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
//                                color: Colors.red[200],
                                          margin: EdgeInsets.only(left: 10),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: InkWell(
                                            child: Text(_locationData['tel'], style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                //                      fontSize: 15,
                                                color: Colors.lightBlue)),
                                            onTap: () async {
                                              String url = "tel:" + "08056128450";
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
//                                color: Colors.red[200],
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(_locationData['note']),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
//                                color: Colors.red[200],
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text("ここから" + distanceBetween(double.parse(_locationData["latitude"]), double.parse(_locationData["longitude"]), 35.65821727124788, 139.70165382288937).toString() + "m"),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
//                                color: Colors.red[200],
                                          margin: EdgeInsets.only(left: 20),
                                          child: Card(
                                              color: Colors.white,
                                              shadowColor: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 6),
                                                  height: deviceHeight * 0.05,
                                                  child: Row(children: [
                                                    Icon(Icons.location_on,
                                                        color: Colors.grey),
                                                    Text(
                                                      "地図アプリで開く",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ]))),
                                        )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget getFavoriteWidgets(int argNum) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < argNum; i++) {
      list.add(new Icon(Icons.favorite, color: Colors.red));
    }
    return new Row(
      children: list,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  int distanceBetween(lat1, lon1, lat2, lon2, {mode = false}) {
    // 緯度経度をラジアンに変換
    final radLat1 = lat1 * pi / 180; // 緯度１
    final radLon1 = lon1 * pi / 180; // 経度１
    final radLat2 = lat2 * pi / 180; // 緯度２
    final radLon2 = lon2 * pi / 180; // 経度２

    // 緯度差
    final radLatDiff = radLat1 - radLat2;

    // 経度差算
    final radLonDiff = radLon1 - radLon2;

    // 平均緯度
    final radLatAve = (radLat1 + radLat2) / 2.0;

    // 測地系による値の違い
    final a = mode ? 6378137.0 : 6377397.155; // 赤道半径
    final b = mode ? 6356752.314140356 : 6356078.963; // 極半径
    final e2 = mode ? 0.00669438002301188 : 0.00667436061028297; // 第一離心率^2
    final a1e2 = mode ? 6335439.32708317 : 6334832.10663254; // 赤道上の子午線曲率半径

    final sinLat = sin(radLatAve);
    final w2 = 1.0 - e2 * (sinLat * sinLat);
    final m = a1e2 / (sqrt(w2) * w2); // 子午線曲率半径M
    final n = a / sqrt(w2); // 卯酉線曲率半径

    final t1 = m * radLatDiff;
    final t2 = n * cos(radLatAve) * radLonDiff;
    final dist = sqrt((t1 * t1) + (t2 * t2));

    double multiplier = 1;
    return (multiplier * dist).round();
  }

}

class _Image extends StatelessWidget {
  final String imageUrl;

  _Image({this.imageUrl});

  final Radius _radius = Radius.circular(20.0);
  final double _imageHeight = 0.2;

  /// 画像に各種設定を行う
  ///
  /// [url]の画像に対して以下を設定した[Container]を返却する。
  /// 指定がない場合はデフォルト値を使用。
  /// [height]、[width]、[borderRadius]、[padding]
  Widget _imageItem({
    BuildContext context,
    String url,
    double height = double.infinity,
    double width = double.infinity,
    BorderRadius borderRadius,
    EdgeInsets padding,
  }) {
    borderRadius ??= BorderRadius.all(Radius.circular(0));
    padding ??= EdgeInsets.zero;

    Image image = Image.network(url, fit: BoxFit.cover);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreview(image: image),
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: image,
        ),
      ),
    );
  }

  /// 画像1枚用のウィジェット
  Widget _image1(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return _imageItem(
      context: context,
      url: imageUrl,
      height: _imageHeight * deviceHeight,
      borderRadius: BorderRadius.all(_radius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _image1(context);
  }
}
