import 'package:flutter/material.dart';

class CustomColor {
  static final Color color1 = CustomColor.fromHex("00A0FF");
  static final Color color2 = CustomColor.fromHex("008FE5");
  static final Color color3 = CustomColor.fromHex("AD807D");

  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF" + hexColor;
    return hexColor.length == 8
        ? Color(int.parse("0x$hexColor"))
        : Colors.white;
  }
}
