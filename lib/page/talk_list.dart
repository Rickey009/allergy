
import '../model/talk_card_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TalkPage extends StatefulWidget {
  final String title;
  TalkPage({this.title});

  @override
  _TalkPageState createState() => _TalkPageState(title: title);

}

class _TalkPageState extends State<TalkPage> {
  List _cardList = [];
  final String title;

  _TalkPageState({this.title});

  @override
  void initState() {
    super.initState();
    _initLoading();
  }

  Future<void> _initLoading() async {
    _cardList = await TalkCardModel().createCardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.green[100],
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
            child: Container(

              child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: FutureBuilder(
                          future: _initLoading(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _cardList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _cardList[index];
                                  });
                            } else {
                              return Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }))),
            )));
  }
}


