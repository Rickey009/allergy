import 'package:flutter/material.dart';
import '../page/image_preview.dart';
import '../util/expansion_tile.dart';
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
          builder: (context) => MapPage(locationName: argStapleData["name"], latitude: double.parse(argStapleData["latitude"]), longitude: double.parse(argStapleData["longitude"])),
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
                            child: (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: getFavoriteWidgets(
                                      _locationData['favorite']),
                                ),
                                Container(
//                                color: Colors.red[50],
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    _locationData['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
//                                color: Colors.red[200],
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text( _locationData['note']),
                                ),
                                Container(
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
                                              top: 6, bottom: 6, left: 6),
                                          height: deviceHeight * 0.04,
                                          child: Row(children: [
                                            Icon(Icons.location_on, color:Colors.grey),
                                            Text(
                                              "地図アプリで開く",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54),
                                            )
                                          ]))),
                                ),
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
