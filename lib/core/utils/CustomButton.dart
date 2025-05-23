import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool hasIcon;
  final Icon? icon;
  final Color color;
  final BorderSide? borderSide;
  final TextStyle? textStyle;
  final double? elevation;
  final double? height;

  CustomButton(
      {required this.title,
      required this.onPressed,
      this.hasIcon = false,
      this.icon,
      this.color = Colors.blue,
      this.borderSide,
      this.textStyle,
      this.elevation = 2.0,
      this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: hasIcon ? icon ?? SizedBox.shrink() : SizedBox.shrink(),
      label: Text(title, style: textStyle),
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: color,
        side: borderSide,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  CustomTextButton({
    required this.title,
    required this.onPressed,
    this.textStyle,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        title,
        style: textStyle ?? TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderSide? borderSide;
  final Color? color;
  final bool isLoading;
  final Widget? loadingWidget;

  CustomOutlinedButton({
    required this.title,
    required this.onPressed,
    this.textStyle,
    this.padding,
    this.borderSide,
    this.color,
    this.isLoading = false,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: !isLoading ? onPressed : null,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: borderSide ??
            BorderSide(
              color: color ?? Theme.of(context).primaryColor,
              width: 1.5,
            ),
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
      ),
      child: isLoading
          ? loadingWidget ?? const Center(child: CircularProgressIndicator())
          : Text(
              title,
              style: textStyle ??
                  TextStyle(
                    color: color ?? Theme.of(context).primaryColor,
                  ),
            ),
    );
  }
}
