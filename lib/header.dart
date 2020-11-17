import 'package:allergy/page/registration.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget{
  final String headerTitle;
  Header({this.headerTitle});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserIcon(),
      ),
      title: Center(
        child: Text(headerTitle),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class UserIcon extends StatefulWidget {
  @override
  _UserIcon createState() => _UserIcon();
}

class _UserIcon extends State{
  void _forwardRegistration() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 40.0,
          color: Colors.blue,
          onPressed: _forwardRegistration,)
      ],
    );
  }
}