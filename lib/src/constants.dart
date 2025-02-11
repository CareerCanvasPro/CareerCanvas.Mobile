import 'package:flutter/material.dart';

const primaryBlue = Color(0xFF0052CC);
const primaryGreen = Color(0xFF3CB371);
const seconderyColor1 = Color(0xFFFFA07A);
const seconderyColor2 = Color(0xFFA9A9A9);
const orangeStar = Color(0xFFFB923C);
const scaffoldBackgroundColor = Color(0xFFF9F9F9);

TextStyle getHeadlineTextStyle(
  BuildContext context,
  double fontSize, {
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: "Montserrat",
    color: color ?? Colors.white,
    fontWeight: FontWeight.w700,
  );
}

TextStyle getBodyTextStyle(
  BuildContext context,
  double fontSize, {
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? Colors.white,
    fontFamily: "Open Sans",
    fontWeight: FontWeight.normal,
  );
}

TextStyle getCTATextStyle(
  BuildContext context,
  double fontSize, {
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? Colors.white,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );
}
