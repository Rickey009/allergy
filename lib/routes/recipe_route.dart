import 'package:allergy/tabs/restaurant_tab.dart';
import 'package:allergy/tabs/staple_tab.dart';
import 'package:flutter/material.dart';
import '../model/meals_card_model.dart';

class Recipe extends StatefulWidget {
  @override
  _Recipe createState() => _Recipe();
}

class _Recipe extends State<Recipe> {
  final String headerTitle = 'レシピ動画';
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
    final double deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow[100],
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(deviceHeight * 0.06), // here the desired height
              child:AppBar(
                  bottom: ColoredTabBar(
                    color: Colors.yellow[200],
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
  Choice(title: '主食', icon: Icons.directions_car, page: Staple()),
  Choice(title: '新着', icon: Icons.directions_bike, page: Restaurant()),
  Choice(title: 'お気に入り', icon: Icons.directions_boat, page: Restaurant()),
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

