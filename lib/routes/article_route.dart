import 'package:allergy/ui/article_card.dart';
import 'package:flutter/material.dart';
import '../header.dart';
import 'image_preview.dart';

class Article extends StatefulWidget {
  @override
  _Article createState() => _Article();
}

class _Article extends State<Article> {
  final String headerTitle = '読み物';
  List _cardList = [];

  @override
  void initState() {
    super.initState();
    _listLoad();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(headerTitle: headerTitle),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: double.infinity,
                      child: Container(
                          child: Text(
                        '今日のピックアップ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: Colors.black54),
                      ))),
                  FutureBuilder(
                      future: _listLoad(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GridView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.5),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return _cardList[index];
                              });
                        } else {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                  Card(
                    child: Container(
                        color: Colors.yellow[50],
                        height: 200,
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          SizedBox(
                              width: double.infinity,
                              child: Container(
                                  child: Text(
                                '今週のイチオシ！',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: Colors.black54),
                              ))),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child: Image.network(
                                            "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/mitte83002_TP_V.jpg",
                                            fit: BoxFit.cover)),
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                            margin: EdgeInsets.only(left: 20),
                                          height: 100,
                                          child:Column(children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  child: Container(
                                                      child: Text(
                                                    '2020年11月12日',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey),
                                                  )))),
                                          Expanded(
                                              flex: 5,
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  child: Container(
                                                      child: Text(
                                                    'オープンガーデン　ハーバルハウスさんを訪ねて',
                                                    textAlign: TextAlign.left,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                  ))))
                                        ])))
                                  ]))
                        ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _listLoad() async {
    _cardList = await createCardList();
  }

  Future<List> createCardList() async {
    List _cardList = [];
    ArticleCard articleCard = ArticleCard();
    Map<String, String> Data001 = {
      'title': '秋の実り探し',
      'date': '2020年11月11日',
      'writer': 'ゆゆ',
      "url":
          "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/mitte83002_TP_V.jpg"
    };
    _cardList.add(articleCard.createCard(Data001));
    Map<String, String> Data002 = {
      'title': '多肉植物の「初恋」は、豪華絢爛！花が咲き、赤く紅葉する！',
      'date': '2020年02月19日',
      'writer': 'ELLY',
      "url":
          "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/mitte83002_TP_V.jpg"
    };
    _cardList.add(articleCard.createCard(Data002));
    Map<String, String> Data003 = {
      'title': 'キンモクセイのお花で雑貨DIY！モイストポプリと香水の作り方とは？',
      'date': '2019年10月21日',
      'writer': 'GreenSnap編集部',
      "url":
          "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/mitte83002_TP_V.jpg"
    };
    _cardList.add(articleCard.createCard(Data003));
    Map<String, String> Data004 = {
      'title': 'まるで生き物みたい！？もふもふの毛が生えた多肉植物７選',
      'date': '2020年05月07日',
      'writer': 'GreenSnap編集部',
      "url":
          "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/mitte83002_TP_V.jpg"
    };
    _cardList.add(articleCard.createCard(Data004));
    return _cardList;
  }
}
