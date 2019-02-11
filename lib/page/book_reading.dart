import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/page_info.dart';
import 'package:reader/data_model/book_reader_model.dart';
import 'package:reader/net/http_helper.dart';
import 'package:reader/net/resp/chapter_context_resp.dart';
import 'package:reader/net/resp/chapter_list_resp.dart';
import 'package:reader/net/resp/toc_list_resp.dart';
import 'package:reader/util/base_state.dart';
import 'package:reader/util/page_view.dart';
import 'package:reader/util/screen.dart';

class BookReading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BookReadingState(bookId);
  }

  final String bookId;

  BookReading(this.bookId);
}

class BookReadingState extends BaseState<BookReading> {
  ReadingSetting readingSetting;
  List<PageInfo> pages;
  PageController pageController = PageController(keepPage: false);
  PageInfo prePageInfo;
  PageInfo curPageInfo;
  PageInfo nextPageInfo;
  int pageIndex = 0;

  final String bookId;

  BookReadingState(this.bookId) {
    readingSetting = ReadingSetting(fortSize: 20, maxRow: 20, maxWord: 17);

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
      _getPages(pageIndex);
    });
  }

  _getPages(int index) {
    if (index < 0) {
      print("已经是第一页了");
      return;
    }
    if (index >= pages.length) {
      print("已经是最后一页了");
      return;
    }

    prePageInfo = index == 0 ? null : curPageInfo;
    curPageInfo = pages[index];
    nextPageInfo = index == pages.length - 1 ? null : pages[index + 1];
    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildReaderView(),
      ],
    );
  }

  Widget buildReaderView() {
    return PageView.builder(
      itemCount: pages.length,
      physics: BouncingScrollPhysics(),
      controller: pageController,
      itemBuilder: buildPageView,
      onPageChanged: onPageChanged,
    );
  }

  Widget buildPageView(BuildContext context, int index) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        onTap(details.globalPosition);
      },
      child: _buildPageView(index),
    );
  }

  _buildPageView(int index) {
    print("index = $index  pageIndex = " + this.pageIndex.toString());
    if (index > this.pageIndex) {
      nextPage();
    }
    return ReaderPageView(curPageInfo);
  }

  onTap(Offset position) {
    double xRate = position.dx / Screen.width;
    if (xRate > 0.33 && xRate < 0.66) {
//      SystemChrome.setEnabledSystemUIOverlays(
//          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
    setState(() {});
  }



  nextPage() {
    print("下一页");
    var index = this.pageIndex + 1;
    if (index >= pages.length) {
      print("已经是最后一页了");
      return;
    }

    prePageInfo = curPageInfo;
    curPageInfo = nextPageInfo;
    nextPageInfo = index == pages.length - 1 ? null : pages[index + 1];

  }

  previousPage() {
    print("前一页");
    var index = this.pageIndex - 1;
    if (index < 0) {
      print("已经是第一页了");
      return;
    }
    curPageInfo = prePageInfo;
    nextPageInfo = curPageInfo;
    prePageInfo = pages[index];
  }

  void onPageChanged(int value) {
    this.pageIndex = value;
//    if(value == 4){
//      new Future.delayed(new Duration(microseconds: 800)).then((next){pageController.jumpToPage(1);});
//    }else if(value == 0){
//      new Future.delayed(new Duration(microseconds: 800)).then((next){pageController.jumpToPage(3);});
//    }
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
          lines.add(" " + prgrhs[i].substring(startCol, endCol));
        } else if (linesLength >= (j + 1) * maxWord) {
          endCol = (j + 1) * maxWord;
          lines.add(prgrhs[i].substring(startCol, endCol));
        } else {
          endCol = prgrhs[i].length;
          var strspan = j == 0 ? " " : "";
          lines.add(strspan + prgrhs[i].substring(startCol, endCol));
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
