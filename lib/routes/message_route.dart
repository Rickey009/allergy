import 'package:flutter/material.dart';
import '../header.dart';

class Message extends StatelessWidget {
  final String screenName = 'メッセージ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerTitle: screenName),
      body: Center(child: Text(screenName)),
    );
  }
}