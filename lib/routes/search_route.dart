import 'package:allergy/tabs/restaurant_tab.dart';
import 'package:allergy/tabs/sweet_tab.dart';
import 'package:flutter/material.dart';
import '../model/meals_card_model.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final String headerTitle = '検索';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[100],
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0), // here the desired height
              child:AppBar(
                  title: Center(
                    child: Text("検索"),
                  ),
                  bottom: ColoredTabBar(
                    color: Colors.blue[200],
                    tabBar: TabBar(
                      //isScrollable: true,
                      tabs: choices.map((Choice choice) {
                        return Tab(
                          text: choice.title,
                          //icon: Icon(choice.icon),
                        );
                      }).toList(),
                    ),
                  )
              )
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                //child: ChoiceCard(choice: choice),
                child: choice.page,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
class Choice {
  const Choice({this.title, this.icon, this.page});

  final String title;
  final IconData icon;
  final StatefulWidget page;
}

List<Choice> choices = <Choice>[
  Choice(title: 'お菓子', icon: Icons.directions_car, page: Sweet()),
  Choice(title: '食事', icon: Icons.directions_bike, page: Restaurant()),
  Choice(title: 'この場所', icon: Icons.directions_boat, page: Restaurant()),
];

class ColoredTabBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget tabBar;
  final Color color;

  ColoredTabBar({@required this.tabBar, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: color,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => tabBar.preferredSize;
}

