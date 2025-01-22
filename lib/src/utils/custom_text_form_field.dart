
import 'package:career_canvas/src/utils/AppColors.dart';
import 'package:career_canvas/src/utils/AppTextStyles.dart';
import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
    final bool? hasSuffixIcon;

  
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? labelStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;

  const CustomTextFormField({
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.labelStyle,
    this.hintTextStyle,
    this.textStyle,
    this.hasSuffixIcon,
    Key? key, TextInputType? textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: labelStyle ?? AppTextStyles.subtitle,
        hintStyle: hintTextStyle ?? AppTextStyles.subtitle.copyWith(color: AppColortext.grey),
        border: border ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColortext.grey),
        ),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColortext.white),
        ),
        enabledBorder: enabledBorder ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColortext.grey),
        ),
        suffixIcon: suffixIcon,
      ),
      style: textStyle ?? AppTextStyles.subtitle,
    );
  }
}
