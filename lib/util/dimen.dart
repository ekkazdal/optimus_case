import 'package:flutter/material.dart' show BoxConstraints;

mixin Dimen {
  static double _width = 412;
  static double _height = 732;
  static double get heightFactor => _height / 100;
  static double get widthFactor => _width / 100;

  static double get width => _width;
  static double get height => _height;

  static void init(BoxConstraints constraints) {
    _width = constraints.maxWidth;
    _height = constraints.maxHeight;
  }

  static void getSizes(double maxWidthSize, double maxHeightSize) {
    _width = maxWidthSize;
    _height = maxHeightSize;
  }
}
