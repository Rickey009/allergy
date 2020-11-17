import 'package:flutter/material.dart';
import '../header.dart';
import '../model/meals_card_model.dart';

class Notice extends StatefulWidget {
  @override
  _Notice createState() => _Notice();
}

class _Notice extends State<Notice> {
  final String headerTitle = '通知';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(headerTitle: headerTitle),
        body:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Expanded(child: Stack(
            children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage("assets/icons/icon001.png"),
              radius: 30.0,
              backgroundColor: Colors.red,),
            ],
          )
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[ Text("ユーザ名")],
          ),
          )
            ]
        )
    );
  }
}