import 'package:flutter/material.dart';
import '../footer.dart';
import '../header.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(headerTitle: "ホーム"),
        bottomNavigationBar: RootWidget(),
    );
  }
}
