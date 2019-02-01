import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReaderSliderView extends StatelessWidget {
  double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _getPadding()),
      width: 360,
      height: 200,
      color: Colors.black,
    );
  }

  ReaderSliderView(this.percentage);

  _getPadding() {
    return this.percentage == null ? 0 : this.percentage;
  }
}
