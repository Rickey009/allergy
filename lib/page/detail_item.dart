import 'package:allergy/ds/recipe_data.dart';
import 'package:allergy/model/item_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'image_preview.dart';

class DetailItemPage extends StatefulWidget {
  final String title;
  final String url;
  final String id;

  DetailItemPage({this.title, this.url, this.id});

  @override
  _DetailItemPage createState() =>
      _DetailItemPage(title: title, url: url, id: id);
}

class _DetailItemPage extends State<DetailItemPage> {
  final String title;
  final String url;
  final String id;

  _DetailItemPage({this.title, this.url, this.id});

  Map _itemData;
  var allergenInfList = [
    {
      "path": "assets/icons/icon001.png",
      "title": "乳",
    },
    {
      "path": "assets/icons/icon002.png",
      "title": "小麦粉",
    },
    {
      "path": "assets/icons/icon003.png",
      "title": "タマゴ",
    },
    {
      "path": "assets/icons/icon004.png",
      "title": "甲殻類",
    },
    {
      "path": "assets/icons/icon005.png",
      "title": "貝類",
    },
    {
      "path": "assets/icons/icon006.png",
      "title": "ソバ",
    },
    {
      "path": "assets/icons/icon007.png",
      "title": "魚卵",
    },
    {
      "path": "assets/icons/icon008.png",
      "title": "落花生",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initLoading();
  }

  Future<void> _initLoading() async {
    _itemData = await ItemDetailModel().createItemData(id);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("商品詳細"),
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
            child: Card(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: SingleChildScrollView(
                        child: FutureBuilder(
                            future: _initLoading(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                    child: Column(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        _itemData["name"],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: _Image(imageUrl: url)),
                                        Expanded(
                                          child: (Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Text(
                                                  _itemData["number"],
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(children: [
                                                    Text(
                                                      "【内容量】",
                                                      style: TextStyle(
                                                        letterSpacing: 3,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      _itemData["amount"],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ])),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(children: [
                                                    Text(
                                                      "【本体価格】",
                                                      style: TextStyle(
                                                        letterSpacing: 0.05,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      "¥" + _itemData["price"],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ])),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  padding: EdgeInsets.all(10),
                                                  child: Text("常温",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      begin: FractionalOffset
                                                          .topLeft,
                                                      end: FractionalOffset
                                                          .bottomRight,
                                                      colors: [
                                                        Colors.deepOrangeAccent,
                                                        Colors.orangeAccent,
                                                      ],
                                                      stops: const [
                                                        0.0,
                                                        1.0,
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          )),
                                        )
                                      ],
                                    ),
                                    Divider(color: Colors.black),
                                    Container(
                                        child: Column(children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "【原材料名】",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )),
                                      getMaterialChips(_itemData["materials"])
                                    ])),
                                    Divider(color: Colors.black),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: getAllergenWidgets(
                                            _itemData["allergenFlg"],
                                            deviceHeight,
                                            deviceWidth)),
                                    Divider(color: Colors.black),
                                    Container(
                                        padding:
                                        EdgeInsets.all(10),
                                        child:Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          _itemData["note"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ))),
                                    Divider(color: Colors.black),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Card(
                                                color: Colors.green,
                                                shadowColor: Colors.black54,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: InkWell(
                                                    onTap: () => {},
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 6,
                                                                bottom: 6,
                                                                left: 6),
                                                        height:
                                                            deviceHeight * 0.05,
                                                        child: Row(children: [
                                                          Expanded(
                                                              child: Center(
                                                                  child: Text(
                                                            "もっと詳しく",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                                        ]))))),
                                        Expanded(
                                            child: Card(
                                                color: Colors.deepOrange,
                                                shadowColor: Colors.black54,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: InkWell(
                                                    onTap: () => {},
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 6,
                                                                bottom: 6,
                                                                left: 6),
                                                        height:
                                                            deviceHeight * 0.05,
                                                        child: Row(children: [
                                                          Expanded(
                                                              child: Center(
                                                                  child: Text(
                                                            "ご購入",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                                        ]))))),
                                      ],
                                    )
                                  ],
                                ));
                              } else {
                                return Center(
                                  child: Container(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            }))))));
  }

  Widget getMaterialChips(String argMaterials) {
    List materialStringList = argMaterials.split(',');
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < materialStringList.length; i++) {
      list.add(Chip(
        backgroundColor: Colors.orange[200],
        labelPadding: EdgeInsets.all(5.0),
        label: Text(materialStringList[i]),
        labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ));
    }
    return Align( alignment: Alignment.topLeft,child: Wrap(children: list, spacing: 6.0));
  }

  Widget getAllergenWidgets(String argFlg, argHeight, argWidth) {
    List allergenList = argFlg.split(',');
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < allergenList.length; i++) {
      if (allergenList[i] == "1") {
        list.add(ConstrainedBox(
            constraints:
                BoxConstraints.loose(Size(argWidth * 0.09, argHeight * 0.1)),
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Image.asset(allergenInfList[i]["path"], fit: BoxFit.cover),
                  Container(
                      child: Column(children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Text(
                            allergenInfList[i]["title"],
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.grey,
                                fontSize: 10),
                          ),
                        )),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Text(
                            "不使用",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.grey,
                                fontSize: 10),
                          ),
                        ))
                  ])),
                ]))));
      }
    }
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: list));
  }
}

class _Image extends StatelessWidget {
  final String imageUrl;

  _Image({this.imageUrl});

  final Radius _radius = Radius.circular(20.0);
  final double _imageHeight = 0.2;

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
