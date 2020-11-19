import 'package:allergy/ui/material_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RecipePage extends StatefulWidget {
  final String title;
  RecipePage({this.title});
  @override
  _RecipeState createState() => _RecipeState(title:title);
}

class _RecipeState extends State<RecipePage> {
  final String title;
  _RecipeState({this.title});

  VideoPlayerController _controller;
  List _cardList = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://pfm-poc.s3-ap-northeast-1.amazonaws.com/recipe001.mp4");
    _controller.initialize().then((_) {
      // 最初のフレームを描画するため初期化後に更新
      setState(() {});
    });
    _listLoad();
  }

  Future<void> _listLoad() async {
    _cardList = await createCardList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List> createCardList() async {
    List _cardList = [];
    MaterialCard materialCard = MaterialCard();
    Map<String, String> frameworks = {
      'name': 'パスタ',
      'amount': '500g',
      'buy': 'true',
    };
    _cardList.add(materialCard.createCard(frameworks));
    frameworks = {
      'name': 'トマト',
      'amount': '100g',
      'buy': 'false',
    };
    _cardList.add(materialCard.createCard(frameworks));
    frameworks = {
      'name': 'ひき肉',
      'amount': '50g',
      'buy': 'true',
    };
    _cardList.add(materialCard.createCard(frameworks));
    frameworks = {
      'name': 'チーズ',
      'amount': '10g',
      'buy': 'true',
    };
    _cardList.add(materialCard.createCard(frameworks));
    frameworks = {
      'name': '酒',
      'amount': '20ml',
      'buy': 'false',
    };
    _cardList.add(materialCard.createCard(frameworks));
    return _cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(
                left: 20, right: 20, bottom: 10, top: 20),
            child: Card(
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: SingleChildScrollView(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                          ),
                          _ProgressText(controller: _controller),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _controller
                                      .seekTo(Duration.zero)
                                      .then((_) => _controller.play());
                                },
                                icon: Icon(Icons.refresh),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controller.play();
                                },
                                icon: Icon(Icons.play_arrow),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controller.pause();
                                },
                                icon: Icon(Icons.pause),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Container(
                                  child: Text(
                                '材料（一人前）',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black54),
                              ))),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: FutureBuilder(
                                  future: _listLoad(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: _cardList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return _cardList[index];
                                          });
                                    } else {
                                      return Center(
                                        child: Container(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }))
                        ],
                      ),
                    ))))));
  }
}

class _ProgressText extends StatefulWidget {
  final VideoPlayerController controller;

  const _ProgressText({Key key, this.controller}) : super(key: key);

  @override
  __ProgressTextState createState() => __ProgressTextState();
}

class __ProgressTextState extends State<_ProgressText> {
  VoidCallback _listener;

  __ProgressTextState() {
    _listener = () {
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void deactivate() {
    widget.controller.removeListener(_listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final String position =
        _printDuration(widget.controller.value.position).toString();
    final String duration =
        _printDuration(widget.controller.value.duration).toString();
    return Text('$position / $duration');
  }

  String _printDuration(Duration duration) {
    var rtnStr = "00:00:00";
    if (duration != null) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      rtnStr =
          "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return rtnStr;
  }
}
