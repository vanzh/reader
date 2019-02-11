import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/page_info.dart';

//阅读页面View
class ReaderPageView extends StatefulWidget {

  final PageInfo pageInfo;

  @override
  State<StatefulWidget> createState() {
    return new ReaderPageViewState(this.pageInfo);
  }

  ReaderPageView(this.pageInfo);
}

class ReaderPageViewState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: CustomPaint(
        painter: ReaderPagePainter(context, this.pageInfo),
      ),
    );
  }

  PageInfo pageInfo;

  ReaderPageViewState(this.pageInfo);
}

class ReaderPagePainter extends CustomPainter {
  BuildContext context;
  Paint mPaint;
  Size size;
  PageInfo pageInfo;

  ReaderPagePainter(this.context, this.pageInfo) {
    mPaint = new Paint()..color = Color(0xffbbc3c5);
    size = MediaQuery.of(context).size;
    print("physicalSize: " + ui.window.physicalSize.toString());
    print(size.toString());
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (this.pageInfo == null) return;

    for (int i = 0; i < pageInfo.lineTexts.length; i++) {
      print(pageInfo.lineTexts[i]);
      ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.start,
          fontSize: pageInfo.readingSetting.fortSize*1.0,
          textDirection: TextDirection.ltr,
        ),
      )
        ..pushStyle(
          ui.TextStyle(
              color: Color(0xffbbc3c5),
              textBaseline: ui.TextBaseline.alphabetic,
              fontWeight: ui.FontWeight.normal),
        )
        ..addText(pageInfo.lineTexts[i]);

      ui.Paragraph paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: this.size.width));
      Offset offset2 = Offset(0, i * 26.0);
      canvas.drawParagraph(paragraph, offset2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
