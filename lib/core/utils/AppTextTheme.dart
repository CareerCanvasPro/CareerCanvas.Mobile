
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/Sizes.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.darkColor,
    scaffoldBackgroundColor: AppColortext.white,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: Sizes.TEXT_SIZE_40,
        fontWeight: FontWeight.bold,
        color: AppColortext.black,
      ),
      bodyMedium: TextStyle(
        fontSize: Sizes.TEXT_SIZE_14,
        color: AppColortext.greyShade6,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        fontSize: Sizes.TEXT_SIZE_14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}



class Decorations {
  static BoxDecoration customBoxDecoration({
    Color color = AppColortext.white,
    double blurRadius = 5.0,
    double borderRadius = 10.0,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: blurRadius,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}

class Borders {
  static BorderSide customBorder({Color color = AppColortext.greyShade6, double width = 1.0}) {
    return BorderSide(color: color, width: width);
  }

  static customOutlineInputBorder({color}) {}
}