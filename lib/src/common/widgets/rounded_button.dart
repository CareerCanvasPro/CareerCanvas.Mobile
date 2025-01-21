import 'package:flutter/material.dart';

Widget roundedButton({
  required void Function()? onPressed,
  required String text,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text),
  );
}
