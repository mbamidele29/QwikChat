import 'package:flutter/material.dart';

class ColorConverter {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF" + hexColor;
    return hexColor.length == 8
        ? Color(int.parse("0x$hexColor"))
        : Colors.white;
  }
}
