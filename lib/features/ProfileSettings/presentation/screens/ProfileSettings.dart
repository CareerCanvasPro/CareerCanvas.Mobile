import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/AppCache.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/LoadingDialog.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/ProfileSettings/presentation/getx/controllers/profileSettingsController.dart';
import 'package:career_canvas/features/login/presentation/screens/LoginScreen.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettings extends StatefulWidget {
  static const String routeName = "/profileSettings";
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late UserProfileController userProfileController;
  late ProfileSettingsController profileSettingsController;
  @override
  void initState() {
    super.initState();
    userProfileController = getIt<UserProfileController>();
    profileSettingsController = getIt<ProfileSettingsController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile().then((value) {
        profileSettingsController.isPrivate.value =
            userProfileController.userProfile.value?.isPrivate ?? false;
      });
    } else {
      profileSettingsController.isPrivate.value =
          userProfileController.userProfile.value?.isPrivate ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () {
              return Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    await profileSettingsController.uploadProfileImage(context);
                    await userProfileController.getUserProfile();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      userProfileController.isLoading.value
                          ? Container(
                              height: 100,
                              width: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    primaryBlue,
                                  ),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  userProfileController.userProfile.value !=
                                          null
                                      ? userProfileController
                                          .userProfile.value!.profilePicture
                                      : "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    primaryBlue,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 100,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      if (profileSettingsController.imageUploading.value)
                        Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                primaryBlue,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  userProfileController.userProfile.value?.name ?? "",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: getCTATextStyle(
                    context,
                    16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Obx(() {
                      return ListTile(
                        title: Text(
                          "Private Profile",
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          "Your profile is private by default. You can make it public to share it with your friends.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {},
                        leading: SvgPicture.asset(
                          "assets/svg/icons/user_icon.svg",
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            primaryBlue,
                            BlendMode.srcIn,
                          ),
                        ),
                        trailing: Switch.adaptive(
                          activeColor: primaryBlue,
                          value: profileSettingsController.isPrivate.value,
                          onChanged: _onChangePrivate,
                        ),
                      );
                    }),
                    // ListTile(
                    //   title: Text(
                    //     "Notification",
                    //     style: TextStyle(
                    //       color: primaryBlue,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    //   leading: SvgPicture.asset(
                    //     "assets/svg/icons/notification_icon.svg",
                    //     height: 20,
                    //     width: 20,
                    //     colorFilter: ColorFilter.mode(
                    //       primaryBlue,
                    //       BlendMode.srcIn,
                    //     ),
                    //   ),
                    //   trailing: const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 20,
                    //     color: primaryBlue,
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text(
                    //     "Paymment",
                    //     style: TextStyle(
                    //       color: primaryBlue,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    //   leading: SvgPicture.asset(
                    //     "assets/svg/icons/payment_icon.svg",
                    //     height: 20,
                    //     width: 20,
                    //     colorFilter: ColorFilter.mode(
                    //       primaryBlue,
                    //       BlendMode.srcIn,
                    //     ),
                    //   ),
                    //   trailing: const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 20,
                    //     color: primaryBlue,
                    //   ),
                    // ),
                    ListTile(
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "Read our privacy policy to learn more about how we use your data.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () async {
                        launchUrl(
                          Uri.parse("https://careercanvas.pro/pp.html"),
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                      leading: SvgPicture.asset(
                        "assets/svg/icons/privacy_policy.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: primaryBlue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Help Center",
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "If you have any questions or need help, visit our help center.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      onTap: launchEmailApp,
                      leading: SvgPicture.asset(
                        "assets/svg/icons/help_center_icon.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: primaryBlue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Invite Friends",
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "Invite your friends to join Career Canvas and start building your career profile.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () async {
                        String androidLink =
                            "https://play.google.com/store/apps/details?id=pro.careercanvas.app";
                        //TODO: Add iOS link
                        String iosLink =
                            "https://apps.apple.com/us/app/career-canvas/id1601239870";
                        String webLink = "https://careercanvas.pro";
                        String appLink = "";
                        if (Platform.isAndroid) {
                          appLink = androidLink;
                        } else if (Platform.isIOS) {
                          appLink = iosLink;
                        } else {
                          appLink = webLink;
                        }
                        ShareResult result = await Share.share(
                          "Check out Career Canvas App. $appLink",
                          subject: 'Look what I found on Career Canvas',
                          sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100),
                        );
                        if (result.status == ShareResultStatus.success) {
                          debugPrint('Thank you for sharing my website!');
                        }
                      },
                      leading: SvgPicture.asset(
                        "assets/svg/icons/invite_icon.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: primaryBlue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "Log out of Career Canvas to start fresh.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () async {
                        await CustomDialog.showCustomDialog(
                          context,
                          title: "Logout?",
                          content: "Are you sure you want to logout?",
                          buttonText: "Logout",
                          button2Text: "Cancel",
                          onPressed: () async {
                            Get.back();
                            LoadingDialog.instance().show(
                              context: context,
                              text: "Deleting Profile",
                            );
                            await TokenInfo.clear();
                            await Appcache.clear();
                            LoadingDialog.instance().hide();
                            await Get.offNamedUntil(
                                LoginScreen.routeName, (route) => false);
                          },
                        );
                      },
                      leading: SvgPicture.asset(
                        "assets/svg/icons/logout_icon.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Delete Account",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "Delete your account and all your data.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        CustomDialog.showCustomDialog(
                          context,
                          title: "Delete Account?",
                          content:
                              "Are you sure you want to delete your account? This action is irreversible. All your data related to your account will be deleted.",
                          buttonText: "Delete",
                          button2Text: "Cancel",
                          onPressed: () async {
                            Get.back();
                            LoadingDialog.instance().show(
                              context: context,
                              text: "Deleting Profile",
                            );
                            await profileSettingsController.deleteProfile(
                              onDeleted: () async {
                                await TokenInfo.clear();
                                await Appcache.clear();
                                LoadingDialog.instance().hide();
                                await Get.offNamedUntil(
                                    LoginScreen.routeName, (route) => false);
                              },
                              onError: () {
                                LoadingDialog.instance().hide();
                              },
                            );
                          },
                        );
                      },
                      leading: SvgPicture.asset(
                        "assets/svg/icons/delete_icon.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          Colors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  void launchEmailApp() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@careercanvas.pro',
      queryParameters: {
        'subject': 'Help needed',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch email client';
    }
  }

  void _onChangePrivate(bool value) async {
    await profileSettingsController.updateProfilePrivacy(value);
  }
}
