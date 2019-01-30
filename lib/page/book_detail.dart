import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/data_model/BookDetailModel.dart';
import 'package:reader/net/http_helper.dart';
import 'package:reader/net/resp/book_info_resp.dart';
import 'package:reader/page/book_reading.dart';
import 'package:reader/util/date_util.dart';
import 'package:reader/util/widget_util.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;

  String bookRecommendUrlById = "http://api.zhuishushenqi.com/book/";

  BookDetailPage(this.bookId);

  @override
  State<StatefulWidget> createState() {
    print('BookDetialPage:' + bookId);
    bookRecommendUrlById = bookRecommendUrlById + bookId + "/recommend";

    return new _BookDetailPage(bookId);
  }
}

class _BookDetailPage extends State<BookDetailPage> {
  BookDetailModel bookDetailModel = new BookDetailModel();

  _BookDetailPage(String bookId) {
    _loadBookDetail(bookId);
  }

  _loadBookDetail(String bookId) async {
    var resp = await HttpHelper.getInstance().getBookDetail(bookId);
    setState(() {
      bookDetailModel.bookInfoResp = new BookInfoResp.fromJson(resp);
      print(bookDetailModel.bookInfoResp.title);
      print(bookDetailModel.bookInfoResp.author);
      print(bookDetailModel.bookInfoResp.cover);
    });
  }

  _gotoBookReading(String bookId) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new BookReading(bookId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("书籍详情"),
      ),
      body: bookDetailModel.bookInfoResp == null
          ? WidgetUtil.loadingView()
          : _buildBookInfo(),
    );
  }

  Widget _buildBookInfo() {
    return new Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  HttpHelper.imgApi + bookDetailModel.bookInfoResp?.cover,
                  width: 80,
                  height: 80,
                ),
                Expanded(
                    child: new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              bookDetailModel.bookInfoResp.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                            ),
                            Text(
                              bookDetailModel.bookInfoResp.author +
                                  "  |  " +
                                  bookDetailModel.bookInfoResp.minorCate +
                                  "  |  " +
                                  (bookDetailModel.bookInfoResp.wordCount ~/
                                          10000)
                                      .toString() +
                                  "万字",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black38),
                            ),
                            Text(
                              DateUtil.toNow(
                                  bookDetailModel.bookInfoResp.updated),
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )))
              ],
            ),
            WidgetUtil.verLineView(),
            new Padding(
                padding: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    Material(
                      child: MaterialButton(
                        child: Text(
                          "加入书架",
                        ),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () {},
                      ),
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.redAccent,
                    ),
                    Material(
                      child: MaterialButton(
                        child: Text(
                          "开始阅读",
                        ),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () {
                          _gotoBookReading(bookDetailModel.bookInfoResp.id);
                        },
                      ),
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.redAccent,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )),
            WidgetUtil.verLineView(),
            new Padding(
                padding: EdgeInsets.only(left: 10),
                child: new Text(
                  bookDetailModel.bookInfoResp.longIntro,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ));
  }
}
