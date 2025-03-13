import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/features/ProfileSettings/presentation/screens/ProfileSettings.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:career_canvas/src/profile/presentation/screens/widgets/language_dialog.dart';
import 'package:career_canvas/src/profile/presentation/screens/widgets/skills_dialog.dart';
import 'package:career_canvas/src/profile/presentation/screens/widgets/text_field_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
  });

  static const String routeName = "/userProfile";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProfileController userProfileController;
  @override
  void initState() {
    super.initState();
    userProfileController = getIt<UserProfileController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile();
    }
  }

  void _addEducationField() async {
    CustomDialog.showAddEducationDialog(
      context,
      onPressedSubmit: (education) async {
        Get.back();
        await userProfileController.uploadEducation(
          UploadEducation(
            education: [education],
          ),
        );
        await userProfileController.getUserProfile();
      },
    );
  }

  void _addWorkExperiance() async {
    CustomDialog.showAddExperianceDialog(
      context,
      onPressedSubmit: (experiance) async {
        Get.back();
        await userProfileController.uploadExperiance(
          UploadExperiance(
            occupation: [experiance],
          ),
        );
        await userProfileController.getUserProfile();
      },
    );
  }

  void _updateAboutMe() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        scrollable: true,
        content: TextFieldDialog(
          title: "About Me",
          existingText: userProfileController.userProfile.value?.aboutMe,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
          onSubmit: (String text) async {
            await userProfileController.updateAboutMe(text);
            await userProfileController.getUserProfile();
          },
        ),
      ),
    );
  }

  void _updateSkills() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        scrollable: true,
        content: SkillAddDialog(
          existingSkills: userProfileController.userProfile.value?.skills,
          onSubmit: (List<String> skills) async {
            await userProfileController.updateSkills(skills);
            await userProfileController.getUserProfile();
          },
        ),
      ),
    );
  }

  void _updateLanguages() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        scrollable: true,
        content: LanguageAddDialog(
          existingLanguages: userProfileController.userProfile.value?.languages,
          onSubmit: (List<String> languages) async {
            // await userProfileController.upda(skills);
            await userProfileController.getUserProfile();
          },
        ),
      ),
    );
  }

  // void pickFileAndUpload() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     userProfileController.uploadResume(
  //         file, userProfileController.resumes.length + 1);
  //   }
  // }

  void pickFileAndUpload() async {
    try {
      // Show file picker and allow the user to pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      // Check if a file was selected
      if (result != null) {
        // Get the picked file's path
        String? filePath = result.files.single.path;

        if (filePath != null) {
          // Platform-specific file path handling
          File file;

          if (Platform.isAndroid) {
            // For Android, you may need to resolve content URI to file path
            // Here we're assuming you have a method to resolve the content URI into a file path
            file = File(
                filePath); // Assuming it's a cached file path or resolved URI
          } else if (Platform.isIOS) {
            // For iOS, file paths are directly accessible
            file = File(filePath);
          } else {
            // Default fallback for other platforms (e.g., Web)
            file = File(filePath);
          }

          // Get the index of the new resume
          int index = userProfileController.resumes.length + 1;

          // Proceed to upload the resume
          await userProfileController.uploadResume(file, index);
        } else {
          // Handle case where filePath is null
          Get.snackbar("Error", "Failed to get the file path.");
        }
      } else {
        // Handle case where no file was selected
        Get.snackbar("Error", "No file selected.");
      }
    } catch (e) {
      // Handle errors that may occur during the file picking or upload process
      Get.snackbar(
          "Error", "An error occurred while picking or uploading the file: $e");
    }
  }

  String formatBytes(int bytes, {int decimals = 2}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    int i = (bytes > 0) ? (log(bytes) / log(1024)).floor() : 0;
    double size = bytes / pow(1024, i);
    return "${size.toStringAsFixed(decimals)} ${suffixes[i]}";
  }

  @override
  Widget build(BuildContext context) {
    ScrollController? controller = ScrollController();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Obx(() {
        return Column(
          children: [
            _profileHeaderSection(
              context,
              userProfileController.userProfile.value,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    // About Me Section
                    _aboutMeSection(
                      context,
                      userProfileController.userProfile.value,
                    ),

                    // Work Experience Section
                    _workExperianceSection(
                      context,
                      userProfileController.userProfile.value?.occupation ?? [],
                    ),

                    // Education Section
                    _educationSection(
                      context,
                      userProfileController.userProfile.value?.education ?? [],
                    ),
                    // Skills Section
                    _skillsSection(context,
                        userProfileController.userProfile.value?.skills ?? []),

                    // Language Section
                    _languageSection(
                        context,
                        userProfileController.userProfile.value?.languages ??
                            []),

                    // Appreciation Section
                    // _appreciationSection(context, userProfileController.userProfile.value?. ?? []),

                    // Resume section
                    // GestureDetector(
                    //   onTap: pickFileAndUpload,
                    //   child: SvgPicture.asset("assets/svg/icons/Add.svg"),
                    // ),
                    _resumeSection(
                      context,
                      userProfileController
                          .resumes, // Assuming resumes are loaded into this list
                    ),
                    // _resumeSection(
                    //   context,
                    //   userProfileController.userProfile.value?.resumes ?? [],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  String formatNumber(num value) {
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B'; // Billion
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M'; // Million
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K'; // Thousand
    } else {
      return value.toString(); // No formatting needed
    }
  }

  Container _profileHeaderSection(
      BuildContext context, UserProfileData? userProfileData) {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(25),
          bottomEnd: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: userProfileData != null
                        ? userProfileData.profilePicture
                        : "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    )),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.ios_share),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Get.toNamed(ProfileSettings.routeName);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfileData != null ? userProfileData.name : "",
                        overflow: TextOverflow.ellipsis,
                        style: getHeadlineTextStyle(
                          context,
                          18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userProfileData != null ? userProfileData.address : "",
                        overflow: TextOverflow.ellipsis,
                        style:
                            getBodyTextStyle(context, 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icons/coin_icon.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    userProfileData != null
                        ? formatNumber(userProfileData.coins)
                        : "",
                    style:
                        getBodyTextStyle(context, 16, color: Color(0xFFCC9933)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  "assets/images/madels/Bronze_Medal.png",
                  semanticLabel: "Bronze Medal",
                ),
                Image.asset(
                  "assets/images/madels/Silver_Medal.png",
                  semanticLabel: "Silver Medal",
                ),
              ],
            ),
            // const SizedBox(height: 8),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: userProfileData != null
                            ? userProfileData.followers.toString()
                            : "",
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " Followers",
                        style: getBodyTextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: userProfileData != null
                            ? userProfileData.following.toString()
                            : "",
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " Following",
                        style: getBodyTextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  label: Text(
                    "Edit ",
                    style: getBodyTextStyle(
                      context,
                      14,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    "assets/svg/icons/Edit.svg",
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _aboutMeSection(
      BuildContext context, UserProfileData? userProfileData) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_About_me.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "About Me",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _updateAboutMe,
                child: SvgPicture.asset(
                  "assets/svg/icons/Edit.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          Text(
            userProfileData != null ? userProfileData.aboutMe : "",
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container _workExperianceSection(
    BuildContext context,
    List<Experiance> data,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Work_experience.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Work Experience",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _addWorkExperiance,
                child: SvgPicture.asset(
                  "assets/svg/icons/Add.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return getExperianceItem(
                  context,
                  title: data[index].designation,
                  company: data[index].organization,
                  startDate:
                      DateTime.fromMillisecondsSinceEpoch(data[index].from),
                  endDate: data[index].to != null
                      ? DateTime.fromMillisecondsSinceEpoch(data[index].to!)
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }

  Container _educationSection(BuildContext context, List<Education> data) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Education.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Education",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _addEducationField,
                child: SvgPicture.asset(
                  "assets/svg/icons/Add.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return EducationItem(
                  context,
                  education: data[index],
                );
              },
            ),
        ],
      ),
    );
  }

  Container _skillsSection(BuildContext context, List<String> data) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Skill.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Skills",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _updateSkills,
                child: SvgPicture.asset(
                  "assets/svg/icons/Edit.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  data.map((e) => getChipItem(context, title: e)).toList(),
            ),
        ],
      ),
    );
  }

  Container _languageSection(BuildContext context, List<String> data) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Language.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Languages",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _updateLanguages,
                child: SvgPicture.asset(
                  "assets/svg/icons/Edit.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  data.map((e) => getChipItem(context, title: e)).toList(),
            ),
        ],
      ),
    );
  }

  Container _appreciationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Appreciation.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Appreciation",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          getAppreciationItem(
            context,
            title: "Wireless Symposium (RWS)",
            organization: "Young Scientist",
            date: DateTime.now(),
          ),
          getAppreciationItem(
            context,
            title: "Nasa Space Apps Challenge",
            organization: "Local Champion",
            date: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Container _resumeSection(BuildContext context, List<Resume> data) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: 20,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Appreciation.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Resume",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: pickFileAndUpload, // Trigger file picker when tapped
                child: SvgPicture.asset(
                  "assets/svg/icons/Add.svg",
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return getResumeItem(
                  context,
                  resume: data[index],
                  onRemove: () {},
                );
              },
            ),
        ],
      ),
    );
  }

  Container _resumeSectionold(BuildContext context, List<Resume> data) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: 20,
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
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Appreciation.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Resume",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          if (data.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return getResumeItem(
                  context,
                  resume: data[index],
                  onRemove: () {},
                );
              },
            ),
        ],
      ),
    );
  }

  String getFormatedDateForResume(DateTime date) {
    return "${DateFormat().add_d().add_MMM().add_y().format(date)} at ${DateFormat().add_jm().format(date)}";
  }

  Widget getResumeItem(
    BuildContext context, {
    required Resume resume,
    required Function()? onRemove,
  }) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(resume.url),
          webOnlyWindowName: 'Resume',
          mode: LaunchMode.inAppWebView,
          browserConfiguration: const BrowserConfiguration(
            showTitle: false,
          ),
          webViewConfiguration: const WebViewConfiguration(
            headers: {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36'
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/icons/PDF.svg",
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resume.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${formatBytes(resume.size)} . ${getFormatedDateForResume(resume.uploadedAt)}",
                    overflow: TextOverflow.ellipsis,
                    style: getBodyTextStyle(
                      context,
                      12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: onRemove,
              child: SvgPicture.asset(
                "assets/svg/icons/Icon_Remove.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getChipItem(BuildContext context, {required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: getBodyTextStyle(
          context,
          14,
          color: Colors.black,
        ),
      ),
    );
  }

  String getFormatedDate(DateTime date) {
    return DateFormat().add_MMM().add_y().format(date);
  }

  String getDuration(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate).inDays;
    if (duration >= 365) {
      return "${duration ~/ 365} Years";
    }
    if (duration >= 30) {
      return "${duration ~/ 30} Months";
    }
    return "$duration Days";
  }

  Widget EducationItem(
    BuildContext context, {
    required Education education,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                education.field,
                style: getCTATextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Text(
            education.institute,
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          if (education.graduationDate != null)
            Row(
              children: [
                if (education.graduationDate != null)
                  Text(
                    "${getFormatedDate(DateTime.fromMillisecondsSinceEpoch(education.graduationDate!))}",
                    style: getBodyTextStyle(
                      context,
                      14,
                      color: Colors.black,
                    ),
                  ),
                if (education.graduationDate != null && education.isCurrent)
                  Text(
                    " . ",
                    style: getBodyTextStyle(
                      context,
                      14,
                      color: Colors.black,
                    ),
                  ),
                if (education.isCurrent)
                  Text(
                    "Current",
                    style: getBodyTextStyle(
                      context,
                      14,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          Text(
            education.achievements,
            style: getBodyTextStyle(
              context,
              12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget getExperianceItem(
    BuildContext context, {
    required String title,
    required String company,
    required DateTime startDate,
    required DateTime? endDate,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: getCTATextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Text(
            company,
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                "${getFormatedDate(startDate)} ${endDate != null ? "- ${getFormatedDate(endDate)}" : ""}",
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              Text(
                " . ",
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              Text(
                getDuration(startDate, endDate ?? DateTime.now()),
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAppreciationItem(
    BuildContext context, {
    required String title,
    required String organization,
    required DateTime date,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: getCTATextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Text(
            organization,
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          Text(
            getFormatedDate(date),
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
