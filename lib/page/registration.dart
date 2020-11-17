import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {

  @override
  _RegistrationState createState() => _RegistrationState();

}
class _RegistrationState extends State<RegistrationPage> {
  final String screenName = '登録';
  var m_itemList = ["", "", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {

    var grid = [
      _photoItem("icon001", m_itemList[0]),
      _photoItem("icon002", m_itemList[1]),
      _photoItem("icon003", m_itemList[2]),
      _photoItem("icon004", m_itemList[3]),
      _photoItem("icon005", m_itemList[4]),
      _photoItem("icon006", m_itemList[5]),
      _photoItem("icon007", m_itemList[6]),
      _photoItem("icon008", m_itemList[7]),
    ];
    var textList = ["", "重度", "中度", "軽度"];

    return Scaffold(
        appBar: AppBar(),
        body: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    border: Border( bottom: BorderSide(width: 3.0, color: Colors.lightBlue.shade50)),
                  ),
                  margin: EdgeInsets.only(left: 5, top: 10, right:5),
                  child:Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/pic001.jpg"),
                              radius: 30.0,
                              backgroundColor: Colors.red,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text("あさはら",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ],
                        ),
                      ]
                  )
              )
              ,
              Expanded(
                child:GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkResponse(
                          child: grid[index],
                          onTap: () async {
                            var result = await showDialog<int>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  title: Text(''),
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      onPressed: () => Navigator.pop(context, 1),
                                      child: const Text('重度'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () => Navigator.pop(context, 2),
                                      child: const Text('中度'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () => Navigator.pop(context, 3),
                                      child: const Text('軽度'),
                                    ),
                                  ],
                                );
                              },
                            );
                            print(index);
                            print('dialog result: $result');
                            setState(() {
                              m_itemList[index] = textList[result];
                            });
                          },
                        ),
                      );
                    }),
              )
            ]
        )
    );
  }
  Widget _photoItemOnly(String image) {
    var assetsImage = "assets/icons/" + image + ".png";
    return  Image.asset(assetsImage, fit: BoxFit.cover,);
  }

  Widget _photoItem(String image, String text) {
    var assetsImage = "assets/icons/" + image + ".png";
    return Stack(
        children: <Widget>[
          Image.asset(assetsImage, fit: BoxFit.cover),
          Center(
            child: Container(
              margin: EdgeInsets.all(30.0),
              child: Text(text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.pink[500],
                ),),
            ),
          )
        ],
        fit: StackFit.expand
    );
  }
}