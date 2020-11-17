import 'package:flutter/material.dart';
import '../routes/image_preview.dart';

class MealExpansionPanel {
  bool isExpanded;
  ExpansionPanel createExpansionPanel(Map mealData) {
    isExpanded = mealData['isExpanded'];
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          color: Colors.yellow[200],
          child: _Header(mealData),
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(child: _Image(imageUrl:mealData['imageUrlHttps']),),
            Expanded(child: (
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.red[50],
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(mealData['status']),
                    ),
                    Container(
                      color: Colors.red[100],
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(mealData['location']),
                    ),
                    Container(
                      color: Colors.red[200],
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(mealData['note']),
                    ),
                  ],
                )
            ),),

          ],
          ),

          Container(
            color: Colors.blue[50],
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(mealData['text']),
          ),

          Container(
            color: Colors.lightGreen[300],
            child: _FooterButtons(mealData),
          ),
        ],
      ),
      isExpanded: isExpanded,
    );
  }

}


class _Image extends StatelessWidget {
  final String imageUrl;
  _Image({this.imageUrl});

  final Radius _radius = Radius.circular(20.0);
  final double _imageHeight = 200;
  final double _padding = 2.5;

  /// 画像に各種設定を行う
  /// 
  /// [url]の画像に対して以下を設定した[Container]を返却する。
  /// 指定がない場合はデフォルト値を使用。
  /// [height]、[width]、[borderRadius]、[padding]
  Widget _imageItem({
    BuildContext context,
    String url,
    double height = double.infinity,
    double width = double.infinity,
    BorderRadius borderRadius,
    EdgeInsets padding,
    }) {

    borderRadius ??= BorderRadius.all(Radius.circular(0));
    padding ??= EdgeInsets.zero;

    Image image = Image.network(
      url,
      fit:BoxFit.cover
    );
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreview(image: image),
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: image,
        ),
      ),
    );
  }

  /// 画像1枚用のウィジェット
  Widget _image1(BuildContext context){
    return _imageItem(
      context: context,
      url: imageUrl,
      height: _imageHeight,
      borderRadius: BorderRadius.all(_radius),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _image1(context);
  }
}

class _Header extends StatelessWidget {
  final Map _mealData;
  
  _Header(
    this._mealData,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 10,
          child: Row(
            children: <Widget>[
              Text(
                _mealData['timeText'],
                style: TextStyle(
                  color: Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Flexible(
                flex: 10,
                child: Text(
                  '　' + _mealData['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _FooterButtons extends StatelessWidget {
  final Map _mealData;
  _FooterButtons(
    this._mealData,
  );
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      buttonPadding: EdgeInsets.all(0.0),
      alignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              iconSize: 18.0,
              onPressed: () {},
            ),
            Text(''),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cached),
              iconSize: 18.0,
              onPressed: () {},
            ),
            Text(_mealData['retweetCount'].toString()),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              iconSize: 18.0,
              onPressed: () {},
            ),
            Text(_mealData['favoriteCount'].toString()),
          ],
        ),
        IconButton(
          icon: Icon(Icons.share),
          iconSize: 18.0,
          onPressed: () {},
        ),
      ],
    );
  }
}