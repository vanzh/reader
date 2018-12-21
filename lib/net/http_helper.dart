import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String baseApi = 'http://api.zhuishushenqi.com';
  static final String imgApi = 'http://statics.zhuishushenqi.com';
  http.Client client = http.Client();

  static HttpHelper _httpHelper;

  static HttpHelper getInstatnce() {
    if (_httpHelper == null) {
      _httpHelper = HttpHelper();
    }
    return _httpHelper;
  }

  getBookByCategory(String type, String major) async {
    var url = baseApi +
        '/book/by-categories?gender=male&type=new&major=%E7%8E%84%E5%B9%BB&start=0&limit=50';

    var response = await client.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    return json.decode(response.body);
  }
}
