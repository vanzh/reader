import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;

  BookDetailPage({this.bookId});

  @override
  State<StatefulWidget> createState() {
    print('BookDetialPage:' + bookId);
    return new _BookDetailPage();
  }
}

class _BookDetailPage extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("书籍详情"),
    ),body: _buildBookInfo(),
    );
  }

  Widget _buildBookInfo(){
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
//            Image.network(
//              HttpHelper.imgApi + widgets[i]['cover'],
//              width: 80,
//              height: 80,
//            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "道君",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                      softWrap: false,
                    ),
                    Text(
                      "跃千愁" + "  |  " + "古典仙侠" + "  |  " + "468万字",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                    Text(
                      "6小时前",
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ))
          ],
        ));
  }
}
