import 'package:flutter/material.dart';
import '../page/image_preview.dart';
import '../page/recipe.dart';
import '../util/expansion_tile.dart';

class StapleCard {
  Widget createCard(Map stapleData) {
    return _StapleCard(stapleData);
  }
}

class _StapleCard extends StatelessWidget {
  final Map _stapleData;
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String _tileTitle = '原材料詳細';
  _StapleCard(
    this._stapleData,
  );

  void _forwardRecipePage(argContext, argStapleData) async {
    Navigator.push(
        argContext,
        MaterialPageRoute(
          builder: (context) => RecipePage(title: argStapleData["name"]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () => _forwardRecipePage(context, _stapleData),
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
                          Container(
                              child: Row(
                            children: <Widget>[
                              Expanded(
                                child: _Image(
                                    imageUrl: _stapleData['imageUrlHttps']),
                              ),
                              Expanded(
                                child: (Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: getFavoriteWidgets(
                                          _stapleData['favorite']),
                                    ),
                                    Container(
//                                color: Colors.red[50],
                                      margin: EdgeInsets.only(left: 10),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        _stapleData['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
//                                color: Colors.red[200],
                                      margin: EdgeInsets.only(left: 10),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text("あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよわをん"),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          )),
                          AppExpansionTile(
                              key: expansionTile,
                              title: new Text(this._tileTitle),
                              //backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                              children: <Widget>[
                                ListTile(
                                  title: const Text('ひき肉、はちみつ、トマト'),
                                  onTap: () {
                                    expansionTile.currentState.collapse();
                                  },
                                ),

                              ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
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
  final double _padding = 2.5;

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
