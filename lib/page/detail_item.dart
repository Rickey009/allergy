import 'package:allergy/ds/recipe_data.dart';
import 'package:allergy/model/recipes_model.dart';
import 'package:allergy/ui/material_item.dart';
import 'package:flutter/material.dart';

class DetailItemPage extends StatefulWidget {
  final String title;
  final String url;
  final String id;

  DetailItemPage({this.title, this.url, this.id});

  @override
  _DetailItemPage createState() =>
      _DetailItemPage(title: title, url: url, id: id);
}

class _DetailItemPage extends State<DetailItemPage> {
  final String title;
  final String url;
  final String id;

  _DetailItemPage({this.title, this.url, this.id});

  List _cardList = [];

  @override
  void initState() {
    super.initState();
    _initLoading();
  }

  Future<void> _initLoading() async {
    RecipeData _data = await RecipeModel().createRecipeData(id);
    _cardList = await createCardList(_data);
  }

  Future<List> createCardList(RecipeData argData) async {
    List _cardList = [];
    final _materials = argData.materialList;

    MaterialCard materialCard = MaterialCard();
    for (var i = 0; i < _materials.length; i++) {
      _cardList.add(materialCard.createCard(_materials[i]));
    }
    return _cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: Card(
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: SingleChildScrollView(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Container(
                                  child: Text(
                                '材料（一人前）',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black54),
                              ))),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: FutureBuilder(
                                  future: _initLoading(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: _cardList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return _cardList[index];
                                          });
                                    } else {
                                      return Center(
                                        child: Container(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }))
                        ],
                      ),
                    ))))));
  }
}
