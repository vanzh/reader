import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reader/net/http_helper.dart';

var url =
    'http://api.zhuishushenqi.com/book/by-categories?gender=male&type=new&major=%E7%8E%84%E5%B9%BB&start=0&limit=50';

class BookListPage extends StatefulWidget {
  final String title;

  BookListPage({Key key, this.title}) : super(key: key);

  @override
  _BookListPageState createState() => _BookListPageState("玄幻");
}

class _BookListPageState extends State<BookListPage> {
  List widgets = [];

  var client = new http.Client();
  final String category;

  _BookListPageState(this.category) {
    _loadData();
  }

  void _loadData() async {
    var bookByCategory =
        await HttpHelper.getInstatnce().getBookByCategory("", "");
    setState(() {
      widgets = bookByCategory['books'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }),
    );
  }

  Widget getRow(int i) {
    return Padding(
//        padding: EdgeInsets.all(10.0), child: Text("${widgets[i]["title"]}"));
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Image.network(
              HttpHelper.imgApi + widgets[i]['cover'],
              width: 80,
              height: 80,
            ),
            Expanded(child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widgets[i]['title'],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                  softWrap: false,
                ),
                Text(
                  widgets[i]['author'] + "  |  " + category,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14,color: Colors.black38),
                ),
                Text(
                  widgets[i]['shortIntro'],
                  softWrap: false,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14,color: Colors.black38),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widgets[i]['latelyFollower'].toString() +
                      " 人在追 | " +
                      widgets[i]['retentionRatio'].toString() +
                      " %读者存留",
                  style: TextStyle(fontSize: 14,color: Colors.black26),
                  textAlign: TextAlign.left,
                ),
              ],
            ))
          ],
        ));
  }
}
