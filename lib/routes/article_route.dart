import '../model/article_card_model.dart';
import '../ui/article_card.dart';
import 'package:flutter/material.dart';
import '../header.dart';
import '../page/image_preview.dart';

class Article extends StatefulWidget {
  @override
  _Article createState() => _Article();
}

class _Article extends State<Article> {
  final String headerTitle = '読みもの';
  List _cardList = [];

  @override
  void initState() {
    super.initState();
    _listLoad();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: Header(
            headerTitle: headerTitle,
            headerColor: Colors.green[500],
            headerTitleColor: Colors.white),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
          child: SingleChildScrollView(
              child: FutureBuilder(
                  future: _listLoad(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
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
                            GridView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.2),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return _cardList[index];
                                }),
                            Card(
                              child: Container(
                                  color: Colors.yellow[50],
                               //   height: deviceHeight * 0.3,
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
 //                                             fontSize: 25,
                                              color: Colors.black54),
                                        ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: deviceHeight * 0.02),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 4,
                                                  child: Image.network(
                                                      _cardList[4]
                                                              .getArticleData[
                                                          "url"],
                                                      fit: BoxFit.cover)),
                                              Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      height: deviceHeight * 0.15,
                                                      child: Column(
                                                          children: <Widget>[
                                                            Expanded(
                                                                flex: 2,
                                                                child: SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Container(
                                                                        child: Text(
                                                                      _cardList[4]
                                                                              .getArticleData[
                                                                          "date"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.grey),
                                                                    )))),
                                                            Expanded(
                                                                flex: 5,
                                                                child: SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Container(
                                                                        child: Text(
                                                                      _cardList[4]
                                                                              .getArticleData[
                                                                          "title"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      maxLines:
                                                                          3,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black54),
                                                                    ))))
                                                          ])))
                                            ]))
                                  ])),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })),
        ));
  }

  Future<void> _listLoad() async {
    _cardList = await ArticleCardModel().createCardList("");
  }
}
