import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xff021B2D);
  static const Color secondary = Color(0xFF0C2C55);
  static const Color textColor = Color(0xffE9F2FB);
  static const Color secondarytextColor = Color(0xffBAC9CC);
  static const Color blue25 = Color(0x1FE9F2FB);
  static const Color green500 = Color(0xFF00D8B1);

  // Centralized theme setup colors
  static const Color cardBackground = Color(0x1FE9F2FB);
  static const Color cyanHighlight = Color(0xFF0AD5EC);
  static const Color blueHighlight = Color(0xFF1B85FF);

  static const LinearGradient brandLinearGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1B85FF), // Blue - left side (rgba(27, 133, 255, 1))
      Color(0xFF0AD5EC), // Cyan - right side (rgba(10, 213, 236, 1))
    ],
    stops: [0.0, 1.0],
  );
}
