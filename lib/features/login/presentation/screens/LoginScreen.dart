import 'package:career_canvas/features/login/presentation/getx/controller/LoginController.dart';
import 'package:career_canvas/features/login/presentation/getx/controller/SocialMediaLoginController.dart';
import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/SpinningLoader.dart';
import 'package:career_canvas/core/utils/VersionInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:get/get.dart';

import '../getx/controller/TabContentController.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";

  final SocialMediaLoginController _controller =
      Get.put(SocialMediaLoginController()); // Inject controller
  final LoginController _loginController =
      Get.put(LoginController()); // Inject controller
  final EmailController emailController = Get.put(EmailController());
  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  final WhatsAppController whatsAppController = Get.put(WhatsAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.1),
                // Logo and Title
                Center(
                  // Centers the content in the middle of the screen
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Centers horizontally
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Centers vertically
                    children: [
                      // Image with height and width based on screen size
                      Image.asset(
                        ImageAssets.logo,
                        height: MediaQuery.of(context).size.height *
                            0.08, // Dynamic height based on screen height
                        width: MediaQuery.of(context).size.height *
                            0.08, // Dynamic width based on screen height
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.01), // Horizontal spacing between the image and text
                      // Text next to the image
                      const Text(
                        'Career\nCanvas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.12),
                // Input Method Tabs
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      // Tab Bar
                      _buildTabBar(context),
                      SizedBox(height: context.screenHeight * 0.05),
                      // Tab Bar Views
                      _buildTabBarViews(context),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                // Social Media Login
                const Text(
                  'or login with',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: context.screenHeight * 0.02),
                _buildSocialMediaIcons(),
                SizedBox(height: context.screenHeight * 0.05),
                // Terms and Conditions
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'By proceeding, I acknowledge that I have read and agree to Career Canvas’s Terms & Conditions and Privacy Statement',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.01,
                ),
                Center(
                  child: Text(
                    VersionInfo.getVersionInfo(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaIcons() {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _buildIcon(
            FontAwesomeIcons.google,
            AppColortext.googleRed,
            _controller.isGoogleLoading,
            _controller.loginWithGoogle,
          ),
          _buildIcon(
            Icons.apple,
            AppColortext.blue,
            _controller.isAppleLoading,
            _controller.loginWithApple,
          ),
          _buildIcon(
            Icons.facebook,
            AppColortext.facebookBlue,
            _controller.isFacebookLoading,
            _controller.loginWithFacebook,
          ),
          _buildIcon(
            FontAwesomeIcons.github,
            AppColortext.black,
            _controller.isGithubLoading,
            _controller.loginWithGithub,
          ),
          _buildIcon(
            FontAwesomeIcons.linkedin,
            AppColortext.linkedInBlue,
            _controller.isLinkedInLoading,
            _controller.loginWithLinkedIn,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(
      IconData icon, Color color, RxBool isLoading, void Function()? onTap) {
    return Obx(() => GestureDetector(
          onTap: isLoading.value ? null : onTap,
          child: isLoading.value
              ? SpinningLoader()
              : Icon(icon, size: 36, color: color),
        ));
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor, // Background for unselected tabs
        borderRadius: BorderRadius.circular(32.0), // Rounded corners
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: Colors.white, // Background color for the selected tab
          borderRadius:
              BorderRadius.circular(24.0), // Rounded corners for the button
        ),
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        labelColor: AppColors.primaryColor, // Text color for the selected tab
        unselectedLabelColor:
            AppColortext.white, // Text color for unselected tabs
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        tabs: [
          Tab(
            child: SizedBox(
              width: context.screenWidth / 3, // Fixed width for each tab
              child: const Text('Email', textAlign: TextAlign.center),
            ),
          ),
          Tab(
            child: SizedBox(
              width: context.screenWidth / 3, // Fixed width for each tab
              child: const Text('Phone Number', textAlign: TextAlign.center),
            ),
          ),
          Tab(
            child: SizedBox(
              width: context.screenWidth / 3, // Fixed width for each tab
              child: const Text('WhatsApp', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarViews(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.2,
      child: TabBarView(
        children: [
          _buildTabContent(
            'Enter your email',
            'Continue with Magic Link',
            context,
            () => emailController
                .onEmailButtonPressed(context), // Pass specific button logic
            emailController.isLoading, // Pass isLoading state
          ),
          _buildTabContent(
            'Enter your phone number',
            'Get OTP',
            context,
            () => phoneNumberController.onPhoneNumberButtonPressed(context),
            phoneNumberController.isLoading,
          ),
          _buildTabContent(
            'Enter your WhatsApp number',
            'Get Varified',
            context,
            () => whatsAppController.onWhatsAppButtonPressed(context),
            whatsAppController.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    String hintText,
    String buttonText,
    BuildContext context,
    VoidCallback onPressed, // Pass a specific onPressed callback
    RxBool isLoading, // Pass isLoading from the controller
  ) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: context.screenHeight * 0.02),
        Obx(() {
          return ElevatedButton(
            onPressed: isLoading.value ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
          );
        }),
      ],
    );
  }
}
