import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/util/widget_util.dart';

abstract class BaseState<T extends StatefulWidget>
    extends State<StatefulWidget> {
  bool init = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: init ? buildView(context) : WidgetUtil.loadingView());
  }

  @protected
  Widget buildView(BuildContext context);
}
