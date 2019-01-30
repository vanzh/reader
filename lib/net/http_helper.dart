import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String baseApi = 'http://api.zhuishushenqi.com';
  static final String imgApi = 'http://statics.zhuishushenqi.com';
  final String chapterApi = "http://chapter2.zhuishushenqi.com/chapter";
  http.Client client = http.Client();

  static HttpHelper _httpHelper;

  static HttpHelper getInstance() {
    if (_httpHelper == null) {
      _httpHelper = HttpHelper();
    }
    return _httpHelper;
  }

  _baseGet(String url) async {
    print('===>>  ' + url);
    var response = await client.get(url);
    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }
    return json.decode(response.body);
  }

  getBookByCategory(String type, String major) async {
    var url = baseApi +
        '/book/by-categories?gender=male&type=new&major=%E7%8E%84%E5%B9%BB&start=0&limit=50';
    return _baseGet(url);
  }

  getBookDetail(String bookId) async {
    var url = baseApi + '/book/$bookId';
    return _baseGet(url);
  }

  //获取该书籍所有来源
  getBookTocs(String bookId) async {
    var url = baseApi + '/toc/' + '?view=summary&book=$bookId';
    return _baseGet(url);
  }

  //根据书源获取章节列表
  getBookTocChapters(String tocId) async {
    var url = baseApi + '/toc/$tocId' + '?view=chapters';
    return _baseGet(url);
  }

  //根据章节id获取章节内容
  getBookChapterBylink(String link) {
    var url = chapterApi + '/$link';
    return _baseGet(url);
  }
}
