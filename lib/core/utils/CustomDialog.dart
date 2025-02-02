import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    String buttonText = "Ok",
    VoidCallback? onPressed,
    String? button2Text,
    VoidCallback? onPressed2,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: getCTATextStyle(context, 24, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                textAlign: TextAlign.center,
                style: getBodyTextStyle(context, 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      title: buttonText,
                      onPressed: onPressed ?? () => Get.back(),
                      backgroundColor: primaryBlue,
                      textStyle:
                          getCTATextStyle(context, 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              if (button2Text != null) SizedBox(height: 4),
              if (button2Text != null)
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        title: button2Text,
                        onPressed: onPressed2 ?? () => Get.back(),
                        backgroundColor: primaryBlue.withOpacity(0.8),
                        textStyle:
                            getCTATextStyle(context, 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
