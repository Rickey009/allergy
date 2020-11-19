import 'package:allergy/page/registration.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final String headerTitle;
  final Color headerColor;
  final Color headerTitleColor;

  Header({this.headerTitle, this.headerColor, this.headerTitleColor});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserIcon(iconColor: headerTitleColor),
      ),
      title: Center(
        child: Text(headerTitle,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: headerTitleColor)),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.settings,color: headerTitleColor,),
            onPressed: () {},
          ),
        ),
      ],
      backgroundColor: headerColor,
    );
  }
}

class UserIcon extends StatefulWidget {
  final Color iconColor;
  UserIcon({this.iconColor});

  @override
  _UserIcon createState() => _UserIcon(iconColor:iconColor);
}

class _UserIcon extends State {

  final Color iconColor;
  _UserIcon({this.iconColor});


  void _forwardRegistration() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 40.0,
          color: iconColor,
          onPressed: _forwardRegistration,
        )
      ],
    );
  }
}
