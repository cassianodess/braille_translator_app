import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


Widget gradientText(String title) {
  return GradientText(
    title,
    style: TextStyle(fontSize: 24.0),
    colors: [
      Colors.white54,
      Colors.white,
      Colors.white30,
      // Color(0xff212121),
      // Color(0xff393939),
      // Color(0xff767676),
      // Color(0xffABAAAA),
      // Color(0xffC2C2C2),
  ]);
}