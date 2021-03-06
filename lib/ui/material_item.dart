import 'package:flutter/material.dart';

class MaterialCard {
  Widget createCard(Map materialData) {
    return _MaterialCard(materialData);
  }
}

class _MaterialCard extends StatelessWidget {
  final Map _materialData;

  _MaterialCard(
    this._materialData,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: SizedBox(
                  width: double.infinity,
                  child: Container(
                      child: Text(
                    _materialData["name"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.black54),
                  ))),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                  width: double.infinity,
                  child: Container(
                      child: Text(
                    _materialData["amount"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.black54),
                  ))),
            ),
            Expanded(
                flex: 4,
                child: createMaterialList(_materialData["buy"], context)),
          ],
        ),
        Divider(color: Colors.black)
      ]),
    );
  }

  Widget createMaterialList(String flg, BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    if (flg == "true") {
      return Container(

          height: deviceHeight * 0.04,
          child: Row(children: [
            Expanded(
                child: Image.asset(
                    "assets/icons/pareco.png",
                    fit: BoxFit.cover)),
            Expanded(
                child: Text(
                  "で購入",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ))
          ]));
    } else {
      return Container(); // Empty Container Widget
    }
  }
}
