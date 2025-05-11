import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/otpVerificationResponse.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/AuthService.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/HomePage.dart';
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/VersionInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenOne.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/controller/TabContentController.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = "/loginScreen";

  final EmailController emailController = Get.put(EmailController());
  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  final WhatsAppController whatsAppController = Get.put(WhatsAppController());

  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> whatsappFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: primaryBlue,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: IgnorePointer(
                child: Image.asset(
                  "assets/icons/cc_bg.png",
                  width: context.screenWidth,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              height: context.screenHeight - 36,
              width: context.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.screenHeight * 0.1),
                  // Logo and Title
                  Image.asset(
                    "assets/icons/cc_logo.png",
                    width: context.screenWidth * 0.60,
                  ),
                  SizedBox(height: context.screenHeight * 0.12),
                  _buildTabContent(
                    'Enter your eMail',
                    // 'Continue with Magic Link',
                    "Get OTP",
                    context,
                    () {
                      FocusScope.of(context).unfocus();
                      // CustomDialog.showCustomOTPDialog(
                      //   context,
                      //   to: emailController.emailController.text,
                      //   onPressedSubmit: (String pin) {},
                      // );
                      emailController.onEmailButtonPressed(
                        context,
                        formKey: emailFormKey,
                        onDone: (String? message) async {
                          await CustomDialog.showCustomOTPDialog(
                            context,
                            to: emailController.emailController.text,
                            username: emailController.emailController.text,
                            onPressedSubmit:
                                (Otpverificationresponse response) async {
                              emailController.emailController.clear();
                              // final prefs = await SharedPreferences.getInstance();
                              // await prefs.setString('token', response.accessToken);
                              // await prefs.setString('username', response.email);
                              // await prefs.setString('type', "Email");
                              // await prefs.setInt(
                              //   'expiresAt',
                              //   response.expiresAt.millisecondsSinceEpoch,
                              // );
                              await TokenInfo.setToken(
                                response.accessToken,
                                response.email,
                                'Email',
                                response.expiresAt,
                              );
                              await getIt<AuthService>()
                                  .setToken(response.accessToken);

                              Get.back();
                              if (response.isNewUser) {
                                Get.to(
                                  () => ProfileCompletionScreenOne(),
                                  arguments: {
                                    'type': 'Email',
                                    'username': response.email,
                                    'token': response.accessToken
                                  },
                                );
                              } else {
                                Get.to(
                                  () => HomePage(),
                                  arguments: {
                                    'type': 'Email',
                                    'username': response.email,
                                    'token': response.accessToken
                                  },
                                );
                              }
                            },
                          );
                        },
                        onError: (String error) {
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Error",
                            content: error,
                            onPressed: () {
                              Get.back();
                            },
                          );
                        },
                      );
                    }, // Pass specific button logic
                    emailController.isLoading, // Pass isLoading state
                    controller: emailController.emailController,
                    onSecondaryPressed: () async {
                      FocusScope.of(context).unfocus();
                      // CustomDialog.showCustomOTPDialog(
                      //   context,
                      //   to: emailController.emailController.text,
                      //   onPressedSubmit: (String pin) {},
                      // );
                      emailController.onEmailButtonPressed(
                        context,
                        formKey: emailFormKey,
                        type: EmailLoginType.MagicLink,
                        onDone: (String? message) async {
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Magic Link Sent",
                            content:
                                "Please check your email for the magic link. Click on the Login button and it will automaticly take you into the app.",
                          );
                        },
                        onError: (String error) {
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Error",
                            content: error,
                            onPressed: () {
                              Get.back();
                            },
                          );
                        },
                      );
                    },
                    isSecondaryLoading: emailController.isSecondaryLoading,
                    secondaryButtonText: "Password Less Login",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                    formKey: emailFormKey,
                  ),

                  Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'By proceeding, I acknowledge that i have read and agree to career canvas\'s Terms & Conditions and Privacy Statement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Center(
                    child: Text(
                      VersionInfo.getVersionInfo(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    String hintText,
    String buttonText,
    BuildContext context,
    VoidCallback onPressed,
    RxBool isLoading, {
    VoidCallback? onSecondaryPressed,
    RxBool? isSecondaryLoading,
    String? secondaryButtonText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    required GlobalKey<FormState> formKey,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: SizedBox(
              height: 40,
              child: TextFormField(
                validator: validator,
                controller: controller,
                autofocus: false,
                cursorColor: primaryBlue,
                cursorOpacityAnimates: true,
                style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  color: Colors.black,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFfb0102),
                    ),
                  ),
                  errorMaxLines: 1,
                  // errorText: '',
                  errorStyle: TextStyle(
                    fontSize: 0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02),
          Obx(() {
            return ElevatedButton(
              onPressed: (isLoading.value == true ||
                      (isSecondaryLoading != null &&
                          isSecondaryLoading == true))
                  ? null
                  : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                disabledBackgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: isLoading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: primaryBlue,
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text(
                      buttonText,
                      style: const TextStyle(color: primaryBlue, fontSize: 12),
                    ),
            );
          }),
          if (isSecondaryLoading != null &&
              onSecondaryPressed != null &&
              secondaryButtonText != null)
            SizedBox(height: 4),
          if (isSecondaryLoading != null &&
              onSecondaryPressed != null &&
              secondaryButtonText != null)
            Obx(() {
              return ElevatedButton(
                onPressed: (isLoading.value == true ||
                        isSecondaryLoading.value == true)
                    ? null
                    : onSecondaryPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                child: isSecondaryLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text(
                        secondaryButtonText,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
              );
            }),
        ],
      ),
    );
  }
}
