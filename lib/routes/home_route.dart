import 'package:allergy/page/posting.dart';
import 'package:flutter/material.dart';
import '../header.dart';
import '../model/meals_card_model.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final String headerTitle = 'ホーム';
  List _cardList = List<MealsCardModel>();

  @override
  void initState() {
    super.initState();
    _load();
    setState(() {});
  }

  Future<void> _load() async {
    _cardList = await MealsCardModel().createCardList('home_timeline');
  }
  void _forwardPosting() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostingPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerTitle: headerTitle, headerColor:Colors.red[100], headerTitleColor: Colors.white,),
      body: Stack(
          children: <Widget>[
            FutureBuilder(
                future: _load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: _cardList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _cardList[index];
                        }
                    );
                  } else {
                    return Center(child:
                    Container(
                      child: CircularProgressIndicator(),
                    ),
                    );
                  }
                }
            ),
            Center(
              child:new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.add),
                    onPressed: () {
                      _forwardPosting();
                    },
                  ),
                ]
              ),
            )
          ]
      )
    );
  }
}