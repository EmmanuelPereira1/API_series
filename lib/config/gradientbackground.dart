import 'package:flutter/material.dart';

class GradientColor {
  static BoxDecoration gradient = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
        Color(0XFF101A26),
        Color(0XFF026873),
        Color(0xFF35F2DF)
      ]));
}
