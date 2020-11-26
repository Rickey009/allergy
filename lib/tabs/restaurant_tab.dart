import 'package:allergy/model/sweets_card_model.dart';
import 'package:flutter/material.dart';

class Restaurant extends StatefulWidget {
  @override
  _Restaurant createState() => _Restaurant();
}

class _Restaurant extends State<Restaurant> {
  List _cardList = List<SweetsCardModel>();
  var _textFieldFocusNode;
  var _inputController = TextEditingController();
  var _chipList = List<Chip>();
  var _keyNumber = 0;

  @override
  void initState() {
    _textFieldFocusNode = FocusNode();
    super.initState();
    _load();
    setState(() {});
  }

  Future<void> _load() async {
    _cardList = await SweetsCardModel().createCardList('home_timeline');
  }



  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _onSubmitted(String text) {
    setState(() {
      _inputController.text = '';
      _addChip(text);
      FocusScope.of(context).requestFocus(_textFieldFocusNode);
    });
  }

  void _addChip(String text) {
    var chipKey = Key('chip_key_$_keyNumber');
    _keyNumber++;

    _chipList.add(
      Chip(
        key: chipKey,
        label: Text(text),
        onDeleted: () => _deleteChip(chipKey),
      ),
    );
  }

  void _deleteChip(Key chipKey) {
    setState(() => _chipList.removeWhere((Widget w) => w.key == chipKey));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        body:Column(
            children: <Widget>[
              Expanded(
                  child: FutureBuilder(
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
                  )
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      focusNode: _textFieldFocusNode,
                      autofocus: false,
                      controller: _inputController,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '食材・料理名で探す',
                      ),
                      onSubmitted: _onSubmitted,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 8.0,
                            runSpacing: 0.0,
                            direction: Axis.horizontal,
                            children: _chipList,
                          ),
                        ),
                      ],
                    ),
                  ]
              )
            ]
        )
    );
  }
}