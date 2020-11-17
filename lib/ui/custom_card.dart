import 'package:flutter/material.dart';
import '../routes/image_preview.dart';

class CustomCard {

  Widget createCard(Map tweetData) {
    return _CustomCard(tweetData);
  }
}

class _CustomCard extends StatelessWidget {
  final Map _tweetData;

  _CustomCard(
    this._tweetData,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.orange[300],
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_tweetData['profileImageUrlHttps'])
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:Colors.teal[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.yellow[200],
                        child: _Header(_tweetData),
                      ),
                      Container(
                        color: Colors.blue[200],
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(_tweetData['text']),
                      ),
                      _Image(imageUrl:_tweetData['image']),
                      Container(
                        color: Colors.lightGreen[300],
                        child: _FooterButtons(_tweetData),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final List<String> imageUrl;
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
      url: imageUrl[0],
      height: _imageHeight,
      borderRadius: BorderRadius.all(_radius),
    );
  }

  /// 画像2枚用のウィジェット
  Widget _image2(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded(
          child: _imageItem(
            context: context,
            url: imageUrl[1],
            height: _imageHeight,
            borderRadius: BorderRadius.only(
              topLeft: _radius,
              bottomLeft: _radius,
            ),
            padding: EdgeInsets.only(
              right: _padding,
            ),
          ),
        ),
        Expanded(
          child: _imageItem(
            context: context,
            url: imageUrl[2],
            height: _imageHeight,
            borderRadius: BorderRadius.only(
              topRight: _radius,
              bottomRight: _radius,
            ),
            padding: EdgeInsets.only(
              left: _padding,
            ),
          ),
        ),
      ],
    );
  }

  /// 画像3枚用のウィジェット
  Widget _image3(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded(
          child: _imageItem(
            context: context,
            url: imageUrl[1],
            height: _imageHeight,
            borderRadius: BorderRadius.only(
              topLeft: _radius,
              bottomLeft: _radius,
            ),
            padding: EdgeInsets.only(
              right: _padding,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              _imageItem(
                context: context,
                url: imageUrl[2],
                height: _imageHeight / 2,
                borderRadius: BorderRadius.only(
                  topRight: _radius,
                ),
                padding: EdgeInsets.only(
                  bottom: _padding,
                  left: _padding,
                ),
              ),
              _imageItem(
                context: context,
                url: imageUrl[3],
                height: _imageHeight / 2,
                borderRadius: BorderRadius.only(
                  bottomRight: _radius,
                ),
                padding: EdgeInsets.only(
                  top: _padding,
                  left: _padding,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 画像4枚用のウィジェット
  Widget _image4(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _imageItem(
              context: context,
              url: imageUrl[1],
              height: _imageHeight / 2,
              borderRadius: BorderRadius.only(
                topLeft: _radius,
              ),
              padding: EdgeInsets.only(
                right: _padding,
                bottom: _padding,
              ),
            ),
            _imageItem(
              context: context,
              url: imageUrl[2],
              height: _imageHeight / 2,
              borderRadius: BorderRadius.only(
                topRight: _radius,
              ),
              padding: EdgeInsets.only(
                left: _padding,
                bottom: _padding,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            _imageItem(
              context: context,
              url: imageUrl[3],
              height: _imageHeight / 2,
              borderRadius: BorderRadius.only(
                bottomLeft: _radius,
              ),
              padding: EdgeInsets.only(
                right: _padding,
                top: _padding,
              ),
            ),
            _imageItem(
              context: context,
              url: imageUrl[4],
              height: _imageHeight / 2,
              borderRadius: BorderRadius.only(
                bottomRight: _radius,
              ),
              padding: EdgeInsets.only(
                left: _padding,
                top: _padding,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.length == 0) {
      return Container();
    }

    if (imageUrl.length == 2) {
      return _image1(context);
    }

    if (imageUrl.length == 3) {
      return _image2(context);
    }

    if (imageUrl.length == 4) {
      return _image3(context);
    }

    return _image4(context);
  }
}

class _Header extends StatelessWidget {
  final Map _tweetData;
  
  _Header(
    this._tweetData,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 10,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Text(
                  _tweetData['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                ' @' + _tweetData['screenName'],
                style: TextStyle(
                  color: Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ' ' + _tweetData['timeText'],
                style: TextStyle(
                  color: Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
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
  final Map _tweetData;
  _FooterButtons(
    this._tweetData,
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
            Text(_tweetData['retweetCount'].toString()),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              iconSize: 18.0,
              onPressed: () {},
            ),
            Text(_tweetData['favoriteCount'].toString()),
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