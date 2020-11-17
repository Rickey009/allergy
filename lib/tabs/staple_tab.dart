import 'package:allergy/model/staple_card_model.dart';
import 'package:flutter/material.dart';

class Staple extends StatefulWidget {
  @override
  _Staple createState() => _Staple();
}

class _Staple extends State<Staple> {
  List _cardList = List<StapleCardModel>();

  @override
  void initState() {
    super.initState();
    _load();
    setState(() {});
  }

  Future<void> _load() async {
    _cardList = await StapleCardModel().createCardList('home_timeline');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          Expanded(
              child: FutureBuilder(
                  future: _load(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: _cardList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _cardList[index];
                          });
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })),
          Container(
              color: Colors.grey,
              padding: EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 20,
                      maxLines: 1,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: '食材・料理名で探す',
                        prefixIcon: Icon(Icons.search_rounded,color: Colors.white,),
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                    Container(
//                                color: Colors.red[200],
                      margin: EdgeInsets.only(left: 20),
                      child: FloatingActionButton.extended(
                        heroTag: "",
                        backgroundColor: Colors.black38,
                        onPressed: () {},
                        label: Text("アレルゲンを追加して検索"),
                      ),
                    )
                  ]))
        ]));
  }
}
