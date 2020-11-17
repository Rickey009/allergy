import 'package:allergy/ui/meal_panel.dart';
import 'package:flutter/material.dart';
import '../header.dart';
import '../model/meals_card_model.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final String headerTitle = 'ホーム';
  List _cardList = List<MealExpansionPanel>();

  @override
  void initState() {
    super.initState();
    _load();
    setState(() {});
  }

  Future<void> _load() async {
    _cardList = await MealsCardModel().createCardList('home_timeline');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerTitle: headerTitle),
      body: Stack(
          children: <Widget>[
            FutureBuilder(
                future: _load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                        child: ExpansionPanelList(
                          animationDuration: Duration(milliseconds: 500),
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _cardList[index].isExpanded = !_cardList[index].isExpanded;
                            });
                            },
                          children: _cardList.cast<ExpansionPanel>() as List<ExpansionPanel>,
                        )
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
                      print("pressed");
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