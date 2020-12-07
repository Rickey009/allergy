import 'package:flutter/material.dart';
import '../page/image_preview.dart';
import '../util/expansion_tile.dart';
import '../page/detail_item.dart';

class TalkCard {
  Widget createCard(Map talkData) {
    return _TalkCard(talkData);
  }
}

class _TalkCard extends StatelessWidget {
  final Map _talkData;

  _TalkCard(
    this._talkData,
  );

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Card(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getCategory(_talkData["categoryId"]),
                          SizedBox(width: 10),
                          Text(
                            _talkData["date"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 15,
                          ),
                          Text(
                            _talkData["time"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(child:Text(
                            _talkData["title"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.chat_bubble,
                              color: Colors.white,
                              size: 10,
                            ),
                            padding: EdgeInsets.all(5),
                          ),
                          Text(
                            _talkData["numOfComments"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.sensor_door_outlined,
                              color: Colors.white,
                              size: 10,
                            ),
                            padding: EdgeInsets.all(5),
                          ),
                          Text(
                            _talkData["target"],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
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
    );
  }

  Widget getCategory(String argId) {
    String category = "";
    switch (argId) {
      case "1":
        category = "おしえて";
        break;
      case "2":
        category = "言わせて";
        break;
      case "9":
        category = "その他";
        break;
      default:
        break;
    }
    return Container(
      color: Colors.pink[100],
      child: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget getMaterialChips(String argMaterials) {
    List materialStringList = argMaterials.split(',');
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < materialStringList.length; i++) {
      list.add(Chip(
        backgroundColor: Colors.blue[400],
        labelPadding: EdgeInsets.all(5.0),
        label: Text(materialStringList[i]),
        labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ));
    }
    return new Wrap(children: list, spacing: 6.0);
  }
}
