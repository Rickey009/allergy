import 'package:flutter/material.dart';

class ArticleCard {
  Widget createCard(Map articleData) {
    return _ArticleCard(articleData);
  }
}

class _ArticleCard extends StatelessWidget {
  final Map _articleData;
  Map get getArticleData => _articleData;
  _ArticleCard(
    this._articleData,
  );

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Card(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: deviceHeight * 0.2,
          child:Center(child:Image.network(_articleData["url"], fit: BoxFit.cover)
          )),
          Container(
              padding: EdgeInsets.all(5.0),
              height: deviceHeight * 0.1,
              child: Column(children: <Widget>[
                // Expanded(
                //     flex: 3,
                //     child: SizedBox(
                //         width: double.infinity,
                //         child: Container(
                //             child: Text(
                //           _articleData["date"],
                //           textAlign: TextAlign.left,
                //           style: TextStyle(
                //               fontWeight: FontWeight.normal,
                //               color: Colors.grey),
                //         )))),
                Expanded(
                //  flex: 6,
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                            child: Text(
                          _articleData["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        )))),
                // Expanded(
                //     flex: 3,
                //     child: SizedBox(
                //         width: double.infinity,
                //         child: Container(
                //             child: Text(
                //           "by " + _articleData["writer"],
                //           textAlign: TextAlign.end,
                //           style: TextStyle(
                //               fontWeight: FontWeight.normal,
                //               color: Colors.black54),
                //         )))),
              ]))
        ],
      ),
    ));
  }
}
