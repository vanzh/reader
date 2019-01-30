import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/data_model/book_reader_model.dart';
import 'package:reader/net/http_helper.dart';
import 'package:reader/net/resp/chapter_context_resp.dart';
import 'package:reader/net/resp/chapter_list_resp.dart';
import 'package:reader/net/resp/toc_list_resp.dart';
import 'package:reader/util/widget_util.dart';

class BookReading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BookReading(bookId);
  }

  final String bookId;

  BookReading(this.bookId);
}

class _BookReading extends State<BookReading> {
  bool init = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: init ? _initView() : WidgetUtil.loadingView());
  }

  final String bookId;

  _BookReading(this.bookId) {
    _loadData();
  }

  BookReadingModel bookReadingModel = new BookReadingModel();
  String cpContent;

  _loadData() async {
    print('loaddata ...');
    var resp = await HttpHelper.getInstance().getBookTocs(bookId);
    bookReadingModel.tocListResp = TocListResp.fromJson(resp);
    String tocId = bookReadingModel.tocListResp.list[0].id;
    print('tocId : ' + tocId);
    resp = await HttpHelper.getInstance().getBookTocChapters(tocId);
    bookReadingModel.chapterListResp = ChapterListResp.fromJson(resp);
    String link = bookReadingModel.chapterListResp.chapters[0].link;
    print('link : ' + link);
    resp = await HttpHelper.getInstance().getBookChapterBylink(link);
    bookReadingModel.chapterContextResp = ChapterContextResp.fromJson(resp);
    cpContent = bookReadingModel.chapterContextResp.chapter.cpContent;

    setState(() {
      if (cpContent.isNotEmpty) init = true;
      print(init);
    });
  }

  _initView() {
    return new Padding(padding: EdgeInsets.all(10), child: new Text(cpContent));
  }
}
