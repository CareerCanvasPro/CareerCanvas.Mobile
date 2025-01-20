import 'package:flutter/material.dart';

const primaryBlue = Color(0xFF0052CC);
const primaryGreen = Color(0xFF3CB371);
const seconderyColor1 = Color(0xFFFFA07A);
const seconderyColor2 = Color(0xFFA9A9A9);

TextStyle getHeadlineTextStyle(
  BuildContext context,
  double fontSize, {
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: "Montserrat",
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getBodyTextStyle(
  BuildContext context,
  double fontSize, {
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? Theme.of(context).colorScheme.onSurface,
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
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );
}
