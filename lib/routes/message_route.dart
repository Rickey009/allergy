import '../util/expansion_tile.dart';
import 'package:flutter/material.dart';
import '../header.dart';

class Message extends StatefulWidget {
  @override
  ExpansionTileSampleState createState() => new ExpansionTileSampleState();
}

class ExpansionTileSampleState extends State<Message> {
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String foos = 'One';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: new AppExpansionTile(
            key: expansionTile,
            title: new Text(this.foos),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
            children: <Widget>[
              new ListTile(
                title: const Text('One'),
                onTap: () {
                  setState(() {
                    this.foos = 'One';
                    expansionTile.currentState.collapse();
                  });
                },
              ),
              new ListTile(
                title: const Text('Two'),
                onTap: () {
                  setState(() {
                    this.foos = 'Two';
                    expansionTile.currentState.collapse();
                  });
                },
              ),
              new ListTile(
                title: const Text('Three'),
                onTap: () {
                  setState(() {
                    this.foos = 'Three';
                    expansionTile.currentState.collapse();
                  });
                },
              ),
            ]),
      ),
    );
  }
}

// --- Copied and slightly modified version of the ExpansionTile.
