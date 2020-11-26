import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'photograph.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  final String screenName = '登録';
  var m_itemList = ["", "", "", "", "", "", "", ""];
  List<CameraDescription> cameras = [];
  String _resultImagePath;
  String _prefImagePath;

  @override
  void initState() {
    super.initState();
    _initial();
  }

  void _forwardCamera() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotographPage(cameras: cameras),
        ));
    setState(() {
      print(result);
      _resultImagePath = result;
    });
  }

  Future<void> _initial() async {
    // Fetch the available cameras before initializing the app.
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    var grid = [
      _photoItem("icon001", m_itemList[0], "乳", deviceHeight),
      _photoItem("icon002", m_itemList[1], "小麦粉", deviceHeight),
      _photoItem("icon003", m_itemList[2], "タマゴ", deviceHeight),
      _photoItem("icon004", m_itemList[3], "甲殻類", deviceHeight),
      _photoItem("icon005", m_itemList[4], "貝類", deviceHeight),
      _photoItem("icon006", m_itemList[5], "ソバ", deviceHeight),
      _photoItem("icon007", m_itemList[6], "魚卵", deviceHeight),
      _photoItem("icon008", m_itemList[7], "落花生", deviceHeight),
    ];
    var textList = ["", "重度", "中度", "軽度"];

    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Container(
                color: Colors.blue[50],
                child: Column(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 3.0, color: Colors.white)),
                      ),
                      padding: EdgeInsets.only(
                          left: 5, top: 10, right: 5, bottom: 10),
                      margin: EdgeInsets.only(
                          left: 5, top: 10, right: 5, bottom: 10),
                      child: Row(children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/icons/pic001.jpg"),
                              radius: 30.0,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "あさはら",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ])),
                  GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                                    backgroundColor: Colors.white,
                                    children: <Widget>[
                                      SimpleDialogOption(
                                          onPressed: () =>
                                              Navigator.pop(context, 1),
                                          child: Container(
                                            child: Card(
                                                color: Colors.black38,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 6,
                                                        bottom: 6,
                                                        left: 6),
                                                    child: Center(
                                                      child: Container(
                                                        child: Text(
                                                          "重度",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 30.0,
                                                            color:
                                                                Colors.black87,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius:
                                                                    10.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))),
                                          )),
                                      SimpleDialogOption(
                                        onPressed: () =>
                                            Navigator.pop(context, 2),
                                        child: Container(
                                          child: Card(
                                              color: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 6),
                                                  child: Center(
                                                    child: Container(
                                                      child: Text(
                                                        "中度",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30.0,
                                                          color: Colors.black87,
                                                          shadows: <Shadow>[
                                                            Shadow(
                                                              offset:
                                                                  Offset(0, 0),
                                                              blurRadius: 10.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ))),
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          onPressed: () =>
                                              Navigator.pop(context, 3),
                                          child: Container(
                                            child: Card(
                                                color: Colors.white54,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 6,
                                                        bottom: 6,
                                                        left: 6),
                                                    child: Center(
                                                      child: Container(
                                                        child: Text(
                                                          "軽度",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 30.0,
                                                            color:
                                                                Colors.black87,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius:
                                                                    10.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))),
                                          )),
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
                  Container(
                    color: Colors.white,
                    child: CustomPaint(
                      painter: TrianglePainter(),
                      child: Container(
                        height: 70,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: _donePhotograph(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _createPhotoImage();
                        } else {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      })
                ])),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(30),
                child: FloatingActionButton(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.add),
                  onPressed: () async {
                    _forwardCamera();
                  },
                ),
              )),
        ]));
  }

  Widget _checked(String argText) {
    if (argText == "") {
      return Container();
    } else {
      return Align(
          alignment: Alignment.topLeft,
          child: Container(
            child:
                Image.asset("assets/icons/icon_check.png", fit: BoxFit.cover),
          ));
    }
  }

  Widget _setAllergyStatus(String argText, double deviceHeight) {
    if (argText == "") {
      return Container();
    } else {
      return Container(
          padding: EdgeInsets.only(
              top: deviceHeight * 0.06,
              left: 10,
              right: 10,
              bottom: deviceHeight * 0.06),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                argText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.black87,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 10.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }

  Widget _photoItem(
      String image, String text, String name, double deviceHeight) {
    var assetsImage = "assets/icons/" + image + ".png";
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
        child: Stack(children: <Widget>[
          Image.asset(assetsImage, fit: BoxFit.cover),
          _checked(text),
          _checked(text),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              )),
          _setAllergyStatus(text, deviceHeight),
        ], fit: StackFit.expand));
  }

  Future<Widget> _donePhotograph() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _prefImagePath = prefs.getString('IMAGE_PATH');
  }

  Widget _createPhotoImage() {
    if (_prefImagePath == null || _prefImagePath == "") {
      return Container();
    } else {
      return Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "現在登録中の内容",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  fontWeight: FontWeight.normal,
                  fontSize: 30.0,
                  color: Colors.pink[500],
                ),
              ),
            )),
        Image.file(File(_prefImagePath))
      ]);
    }
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.blue[50];
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

    // 三角（塗りつぶし）
    paint.color = Colors.blueGrey;
    var path = Path();
    path.moveTo(size.width / 4, size.height / 10);
    path.lineTo(size.width / 2, size.height / 10 * 5);

    path.lineTo(size.width / 4 * 3, size.height / 10);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
