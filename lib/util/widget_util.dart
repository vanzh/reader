import 'package:flutter/cupertino.dart';

class WidgetUtil {
  static Widget verLineView() {
    return new Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: new Container(
          height: 1,
          color: Color.fromARGB(255, 200, 10, 30),
        ));
  }

  static Widget loadingView() {
    return new Center(child: new Text("加载中"));
  }
}
