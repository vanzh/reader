
import 'package:reader/net/resp/chapter_context_resp.dart';
import 'package:reader/net/resp/chapter_list_resp.dart';
import 'package:reader/net/resp/toc_list_resp.dart';

/// BookReading界面的数据源
class BookReadingModel {
  TocListResp tocListResp;
  ChapterListResp chapterListResp;
  ChapterContextResp chapterContextResp;
}