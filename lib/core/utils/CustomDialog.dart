import 'package:career_canvas/core/models/otpVerificationResponse.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

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

  static Future showCustomOTPDialog(
    BuildContext context, {
    required String to,
    required Function(Otpverificationresponse) onPressedSubmit,
  }) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          content: getOTPVerificationDialog(
            to: to,
            onPressedSubmit: onPressedSubmit,
          ),
        );
      },
    );
  }
}

class getOTPVerificationDialog extends StatefulWidget {
  final String to;
  final Function(Otpverificationresponse) onPressedSubmit;
  getOTPVerificationDialog({
    super.key,
    required this.to,
    required this.onPressedSubmit,
  });

  @override
  State<getOTPVerificationDialog> createState() =>
      _getOTPVerificationDialogState();
}

class _getOTPVerificationDialogState extends State<getOTPVerificationDialog> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> onPressedSubmit(String pin) async {
    try {
      setState(() {
        isLoading = true;
      });
      ApiClient apiClient = ApiClient(
        Dio(
          BaseOptions(
            baseUrl: ApiClient.authBase,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        ),
      );

      final response = await apiClient.get(
        ApiClient.authBase + "/auth-otp/confirm?otp=${pin}",
      );
      print(response.data);
      setState(() {
        isLoading = false;
      });
      if (response.data['data']) {
        widget.onPressedSubmit(
          Otpverificationresponse.fromMap(
            response.data['data'],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    final fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final pinController = TextEditingController();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Enter OTP",
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Otp sent to ${widget.to}",
          textAlign: TextAlign.center,
          style: getBodyTextStyle(context, 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    return value != null && value.length == 6
                        ? null
                        : 'Pin is invalid';
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: onPressedSubmit,
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Submit",
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          await onPressedSubmit(pinController.text);
                        }
                      },
                backgroundColor: primaryBlue,
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Cancel",
                onPressed: () => Get.back(),
                backgroundColor: primaryBlue.withOpacity(0.8),
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
