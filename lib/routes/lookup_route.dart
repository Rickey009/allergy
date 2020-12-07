import '../page/talk_list.dart';
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

  void _forwardListPage(argContext) async {
    Navigator.push(
        argContext, MaterialPageRoute(builder: (context) => TalkPage()));
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
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
              child: Container(
                  height: deviceHeight * 0.65,
                  width: deviceWidth * 0.9,
                  child: Column(children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Card(
                            color: Colors.orangeAccent[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: InkWell(
                                onTap: () => _forwardListPage(context),
                                child:
                                  Center(
                                    child: Container(
                                        margin: EdgeInsets.all(30.0),
                                        child: Column(children: <Widget>[
                                          Text(
                                            "アレルギーについて調べる",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black87,
                                              backgroundColor:
                                              Colors.lightGreenAccent,
                                            ),
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ])),
                                  )
                                ))),
                    Expanded(
                        flex: 3,
                        child: Card(
                            color: Colors.orangeAccent[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child:
                          Center(
                            child: Container(
                                margin: EdgeInsets.all(30.0),
                                child: Column(children: <Widget>[
                                  Text(
                                    "相談する",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black87,
                                      backgroundColor:
                                      Colors.lightGreenAccent,
                                    ),
                                  ),
                                  Text(
                                    "他のユーザーにアレルギーのことを聞いてみよう！",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                ])),
                          ))),
                    Expanded(
                        flex: 3,
                        child: Card(
                            color: Colors.orangeAccent[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Container(
                                  margin: EdgeInsets.all(30.0),
                                  child: Column(children: <Widget>[
                                    Text(
                                      "みんなでアレルギー",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black87,
                                        backgroundColor:
                                            Colors.lightGreenAccent,
                                      ),
                                    ),
                                    Text(
                                      "対応商品を開発する",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black87,
                                        backgroundColor:
                                            Colors.lightGreenAccent,
                                      ),
                                    ),
                                  ])),
                            ))),
                  ]))),
        ));
  }
}
