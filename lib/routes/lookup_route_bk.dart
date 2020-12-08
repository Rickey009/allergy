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
        argContext,
        MaterialPageRoute(
            builder: (context) => TalkPage(
            )));
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
                  height: deviceHeight * 0.75,
                  width: deviceWidth * 0.9,
                  child: Column(children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Card(
                            child: InkWell(
                                onTap: () => _forwardListPage(context),
                                child: Stack(children: <Widget>[
                                  Opacity(
                                    opacity: 0.7,
                                    child: Image.asset(
                                        "assets/icons/shiraberu.png",
                                        fit: BoxFit.cover),
                                  ),
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
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ],
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
                                ], fit: StackFit.expand)))),
                    Expanded(
                        flex: 3,
                        child: Card(
                            child: Stack(children: <Widget>[
                              Opacity(
                                opacity: 0.7,
                                child: Image.asset("assets/icons/soudan.png",
                                    fit: BoxFit.cover),
                              ),
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
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10.0,
                                              color: Colors.white,
                                            ),
                                          ],
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
                            ], fit: StackFit.expand))),
                    Expanded(
                        flex: 3,
                        child: Card(
                            child: Stack(children: <Widget>[
                              Opacity(
                                opacity: 0.7,
                                child: Image.asset("assets/icons/kaihatsu.png",
                                    fit: BoxFit.cover),
                              ),
                              Center(
                                child: Container(
                                    margin: EdgeInsets.all(30.0),
                                    child: Column(children: <Widget>[
                                      Text(
                                        "みんなで",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black87,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "商品を開発する！",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black87,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                              )
                            ], fit: StackFit.expand))),
                  ]))),
        ));
  }
}
