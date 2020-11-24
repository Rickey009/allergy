import '../model/article_card_model.dart';
import 'package:flutter/material.dart';
import '../header.dart';

class Lookup extends StatefulWidget {
  @override
  _Lookup createState() => _Lookup();
}

class _Lookup extends State<Lookup> {
  final String headerTitle = '調べる';
  List _cardList = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: Header(
            headerTitle: headerTitle,
            headerColor: Colors.green[500],
            headerTitleColor: Colors.white),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
          child: SingleChildScrollView(
              child: Container(
                  height: deviceHeight * 0.4,
                  width: deviceWidth * 0.9,
                  child: Column(children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Stack(children: <Widget>[
                          Image.asset("assets/icons/icon001.png",
                              fit: BoxFit.cover),
                          Center(
                            child: Container(
                                margin: EdgeInsets.all(30.0),
                                child: Column(children: <Widget>[
                                  Text(
                                    "名前を調べる",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    "写真を撮ると人工知能とGreenSnapのみんなが教えてくれます！",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ])),
                          )
                        ], fit: StackFit.expand)),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "みんなの投稿をみる＞",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ))),
                    Expanded(
                        flex: 3,
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Stack(children: <Widget>[
                                Image.asset("assets/icons/icon001.png",
                                    fit: BoxFit.cover),
                                Center(
                                  child: Container(
                                      child: Column(children: <Widget>[
                                        Text(
                                          "育て方を調べる",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "植物図鑑で育て方を調べられます！",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ])),
                                )
                              ], fit: StackFit.expand)),
                          Expanded(
                              child: Stack(children: <Widget>[
                                Image.asset("assets/icons/icon001.png",
                                    fit: BoxFit.cover),
                                Center(
                                  child: Container(
                                      child: Column(children: <Widget>[
                                        Text(
                                          "相談する",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "みんなが植物の悩みに答えてくれます！",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ])),
                                )
                              ], fit: StackFit.expand))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Stack(children: <Widget>[
                          Image.asset("assets/icons/icon001.png",
                              fit: BoxFit.cover),
                          Center(
                            child: Container(
                                child: Column(children: <Widget>[
                                  Text(
                                    "人気の投稿を見つけよう",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),

                                ])),
                          )
                        ], fit: StackFit.expand)),
                    Expanded(
                        flex: 1,
                        child: Stack(children: <Widget>[
                          Image.asset("assets/icons/icon001.png",
                              fit: BoxFit.cover),
                          Center(

                            child: Container(
                                child: Column(children: <Widget>[
                                  Text(
                                    "ショップを検索する",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),

                                ])),
                          )
                        ], fit: StackFit.expand))
                  ]))),
        ));
  }
}
