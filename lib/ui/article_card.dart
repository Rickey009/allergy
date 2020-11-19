import 'package:flutter/material.dart';

class ArticleCard {
  Widget createCard(Map articleData) {
    return _ArticleCard(articleData);
  }
}

class _ArticleCard extends StatelessWidget {
  final Map _articleData;

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
            height: deviceHeight * 0.15,
          child:Image.network(_articleData["url"], fit: BoxFit.cover)
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              height: deviceHeight * 0.12,
              child: Column(children: <Widget>[
                Expanded(
                    flex: 2,
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                            child: Text(
                          _articleData["date"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.grey),
                        )))),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                            child: Text(
                          _articleData["title"],
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.black54),
                        )))),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                            child: Text(
                          "by " + _articleData["writer"],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black54),
                        )))),
              ]))
        ],
      ),
    ));
  }
}
