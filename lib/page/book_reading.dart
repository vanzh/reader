import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/page_info.dart';
import 'package:reader/data_model/book_reader_model.dart';
import 'package:reader/net/http_helper.dart';
import 'package:reader/net/resp/chapter_context_resp.dart';
import 'package:reader/net/resp/chapter_list_resp.dart';
import 'package:reader/net/resp/toc_list_resp.dart';
import 'package:reader/util/page_view.dart';
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
  ReadingSetting readingSetting;
  List<PageInfo> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: init ? _buildView() : WidgetUtil.loadingView());
  }

  final String bookId;

  _BookReading(this.bookId) {
    readingSetting = ReadingSetting(fortSize: 20, maxRow: 20, maxWord: 18);
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
      _toPageInfos(cpContent);
      if (pages != null) init = true;
      print(init);
    });
  }

  _buildView() {
    return new ReaderPageView(pages[0]);
  }

  List<PageInfo> _toPageInfos(String content) {
    List<String> prgrhs = content.split("\n\n"); //段落数
    List<String> lines = [];
    int maxWord = readingSetting.maxWord;
    int maxRow = readingSetting.maxRow;
    //总计行
    for (int i = 0; i < prgrhs.length; i++) {
      int j = 0;
      int linesLength = prgrhs[i].length;
      while (linesLength >= j * maxWord) {
        int startCol = j * maxWord;
        int endCol;
        if (j == 0 && linesLength >= (j + 1) * maxWord - 2) {
          endCol = maxWord - 2;
          lines.add("   " + prgrhs[i].substring(startCol, endCol));
        } else if (linesLength >= (j + 1) * maxWord) {
          endCol = (j + 1) * maxWord;
          lines.add(prgrhs[i].substring(startCol, endCol));
        } else {
          endCol = prgrhs[i].length;
          lines.add(prgrhs[i].substring(startCol, endCol));
        }
        print("总计行 $i >> $linesLength ... start:$startCol  end:$endCol");
        j++;
      }
    }
    pages = [];
    int totalPage = (lines.length ~/ maxRow) + 1;
    print("总计行 end " + lines.length.toString());
    for (int i = 0; i < totalPage; i++) {
      PageInfo pageInfo = new PageInfo();
      pageInfo.indexPage = i;
      pageInfo.readingSetting = this.readingSetting;
      int startRow = i * maxRow;
      int endRow =
          (i + 1) * maxRow >= lines.length ? lines.length : (i + 1) * maxRow;
      print("分页  $totalPage  $startRow  $endRow");
      pageInfo.lineTexts = lines.sublist(startRow, endRow);
      pages.add(pageInfo);
    }
    print("分页 end");

    return pages;
  }
}
