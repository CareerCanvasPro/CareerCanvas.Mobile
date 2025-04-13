import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:career_canvas/core/models/personalityInfo.dart';
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/JobsController.dart';
import 'package:career_canvas/features/Career/presentation/screens/CareerTrendDetailsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/EntjDetailsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/personalityDetailsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/widgets/AnalyticsItem.dart';
import 'package:career_canvas/features/Career/presentation/screens/widgets/goals_dialog.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

// CareerScreen
class CareerScreen extends StatefulWidget {
  CareerScreen({super.key});

  static const String routeName = "/careerScreen";

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  late final JobsController jobsController;
  late final UserProfileController userProfileController;

  @override
  void initState() {
    super.initState();
    _imagePath = '';
    _loadImage();
    jobsController = getIt<JobsController>();
    if (jobsController.jobs.value == null) {
      jobsController.getJobsRecomendation();
    }
    if (jobsController.careerTrends.value == null) {
      jobsController.getCareerTrends();
    }
    userProfileController = getIt<UserProfileController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile();
    }
    if (!TokenInfo.careerTutorialViewDone) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ShowCaseWidget.of(context).startShowCase(
            [_one, _two, _three, _four],
          );
          TokenInfo.careerTutorialViewDoneNow();
        },
      );
    }
  }

  Future<void> onRefresh() async {
    await userProfileController.getUserProfile();
    await jobsController.getCareerTrends();
    await jobsController.getJobsRecomendation();
  }

  String getFormatedDateForTimeline(DateTime date) {
    return DateFormat().add_MMM().add_y().format(date);
  }

  String getFormatedDateForJobs(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    return DateFormat().add_MMM().add_y().format(dateTime);
  }

  String getStyledSalaryRange(
      int salary, int? salaryMax, String currency, String salaryTime) {
    String salaryRange = '';
    if (salaryMax != null) {
      salaryRange =
          '${currency} ${formatNumber(salary)} - ${formatNumber(salaryMax)}';
    } else {
      salaryRange = '${currency} ${formatNumber(salary)}';
    }

    // Convert salary time format
    String timeAbbreviation = salaryTime.toLowerCase() == 'month'
        ? 'M'
        : (salaryTime.toLowerCase() == 'year' ||
                salaryTime.toLowerCase() == 'annum'
            ? 'Y'
            : salaryTime); // Default to original if not "Month" or "Year"
    if (salaryTime.isNotEmpty) {
      salaryRange += '/$timeAbbreviation';
    }
    return salaryRange;
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

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  late String _imagePath =
      'package:hrmsapp/core/ImagePath/ImageAssets.dart'; // Initialize with an empty string

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', pickedFile.path);
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  Widget buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage, // Pick image when tapped
          child: CircleAvatar(
            radius: 40, // Set the radius of the outer CircleAvatar
            backgroundColor:
                Colors.grey.shade300, // Background color of the CircleAvatar
            child: _imagePath.isNotEmpty && File(_imagePath).existsSync()
                ? ClipOval(
                    child: Image.file(
                      File(_imagePath),
                      width: 30, // Set the width of the image
                      height: 30, // Set the height of the image
                      fit: BoxFit.cover, // Ensure the image fits properly
                    ),
                  )
                : const Icon(
                    Icons.person, // Default icon if no image is set
                    size: 20,
                    color: Colors.grey,
                  ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return CustomMaterialIndicator(
            onRefresh: onRefresh,
            backgroundColor: Colors.white,
            indicatorBuilder: (context, controller) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  color: primaryBlue,
                  value: controller.state.isLoading
                      ? null
                      : min(controller.value, 1.0),
                ),
              );
            },
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            userProfileController
                                    .userProfile.value?.profilePicture ??
                                "",
                          ),
                          radius: 25,
                        ),
                        const SizedBox(width: 12),

                        // Text Column
                        Expanded(
                          child: SizedBox(
                            height: 50, // Match image height
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // Center vertically
                              children: [
                                const Text(
                                  "Hi! Welcome,",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  userProfileController
                                          .userProfile.value?.name ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryColor,
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     padding: const EdgeInsets.all(20),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: const [
                  //         AnalyticsItem(
                  //             title: "Day Stacks",
                  //             value: "11",
                  //             subtitle: "Analytics"),
                  //         AnalyticsItem(
                  //             title: "Courses",
                  //             value: "7",
                  //             subtitle: "This Week"),
                  //         AnalyticsItem(
                  //             title: "Goal Competed", value: "2", subtitle: ""),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: userProfileController
                                .userProfile.value?.personalityType ==
                            null
                        ? Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Start Assessment to know",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "better yourself",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/icons/assesment-hand.png",
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          PersonalityTestScreen.routeName);
                                    },
                                    child: const Text(
                                      "Start Assessment",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your Type",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${PersonalityType.getType(userProfileController.userProfile.value?.personalityType ?? "")?.name ?? ""} "
                                            "(${PersonalityType.getType(userProfileController.userProfile.value?.personalityType ?? "")?.category ?? ""})",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${PersonalityType.getType(userProfileController.userProfile.value?.personalityType ?? "")?.description ?? ""} ",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  // EntjDetailsScreen()
                                                  PersonalityDetails(
                                                personalityTestResult:
                                                    userProfileController
                                                        .userProfile
                                                        .value!
                                                        .personalityTestResult!,
                                                personalityType: PersonalityType
                                                    .getType(userProfileController
                                                            .userProfile
                                                            .value
                                                            ?.personalityType ??
                                                        "")!,
                                                type: userProfileController
                                                        .userProfile
                                                        .value!
                                                        .personalityType ??
                                                    "",
                                              ),
                                            ),
                                          );
                                        },
                                        title: "Details",
                                        backgroundColor: primaryBlue,
                                        textStyle: getCTATextStyle(
                                          context,
                                          12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomOutlinedButton(
                                        borderSide: BorderSide(
                                          color: primaryBlue,
                                          width: 1,
                                        ),
                                        onPressed: () {
                                          //                                         WidgetsBinding.instance.addPostFrameCallback((_) {
                                          //   Navigator.pushNamed(context, PersonalityTestScreen.routeName);
                                          // });
                                          Navigator.pushNamed(context,
                                              PersonalityTestScreen.routeName);
                                        },
                                        title: "Re-Assess",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(
                  //     "Personality Assesment",
                  //     style: getCTATextStyle(context, 16, color: Colors.black),
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: getPersonalityTest(context),
                  // ),
                  SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [
                  //     Text("Goal",
                  //         style: TextStyle(
                  //             fontSize: 16, fontWeight: FontWeight.bold)),
                  //     Text("Add New Goal",
                  //         style: TextStyle(color: Colors.blue)),
                  //   ],
                  // ),
                  // const SizedBox(height: 12),

                  // Wrap(
                  //   spacing: 8,
                  //   runSpacing: 8,
                  //   children: goals
                  //       .map(
                  //         (goal) => Chip(
                  //           label: Text(goal),
                  //           backgroundColor: Colors.blue[50],
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //             side: const BorderSide(color: Colors.blue),
                  //           ),
                  //           labelStyle: const TextStyle(color: Colors.blue),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  Showcase(
                    key: _two,
                    title: "Your Goals",
                    enableAutoScroll: true,
                    targetBorderRadius: BorderRadius.circular(16),
                    targetPadding: const EdgeInsets.all(16.0),
                    description:
                        "Here you can see and add your goals so that we can suggest you career guides based on your goals.",
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Goal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog.adaptive(
                                      backgroundColor: Colors.white,
                                      scrollable: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      titlePadding: const EdgeInsets.all(0),
                                      insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      content: AddGoals(
                                        existingGoals: userProfileController
                                            .userProfile.value?.goals,
                                        onSubmit: (List<String> goals) async {
                                          await userProfileController
                                              .updateGoals(goals);
                                          await userProfileController
                                              .getUserProfile();
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Add New Goal",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Goals",
                          //       style: getCTATextStyle(context, 16,
                          //           color: Colors.black),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () {
                          //         showDialog(
                          //           context: context,
                          //           barrierDismissible: false,
                          //           builder: (context) => AlertDialog.adaptive(
                          //             scrollable: true,
                          //             content: AddGoals(
                          //               existingGoals: userProfileController
                          //                   .userProfile.value?.goals,
                          //               onSubmit: (List<String> goals) async {
                          //                 await userProfileController
                          //                     .updateGoals(goals);
                          //                 await userProfileController
                          //                     .getUserProfile();
                          //               },
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.white,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(24.0),
                          //         ),
                          //       ),
                          //       child: Text(
                          //         "Add New Goal",
                          //         style: getCTATextStyle(
                          //           context,
                          //           14,
                          //           color: primaryBlue,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          (userProfileController
                                      .userProfile.value?.goals.isNotEmpty ??
                                  false)
                              ? getGoals(userProfileController
                                  .userProfile.value?.goals)
                              : Container(
                                  height: 150,
                                  child: Center(
                                    child: Text(
                                      "No Goals Yet",
                                      style: getCTATextStyle(
                                        context,
                                        14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Career Trends
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Current career trends",
                      style: getCTATextStyle(
                        context,
                        14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Showcase(
                    key: _three,
                    enableAutoScroll: true,
                    title: "Career Trends",
                    targetBorderRadius: BorderRadius.circular(16),
                    description:
                        "Here you can see some career trends based on your profile.",
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: ((MediaQuery.of(context).size.width - 60) /
                                16 *
                                9) +
                            230,
                      ),
                      child: Obx(() {
                        if (jobsController.isLoadingCareerTrends.value) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              primaryBlue,
                            ),
                          ));
                        }
                        if (jobsController
                            .errorMessageCareerTrends.isNotEmpty) {
                          return Center(
                            child: Text(
                              jobsController.errorMessageCareerTrends.value,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        }
                        if (jobsController.careerTrends.value?.data?.careers ==
                                null ||
                            jobsController
                                .careerTrends.value!.data!.careers.isEmpty) {
                          return const Center(
                            child: Text(
                              'No career trends available for you at the moment.\nPlease check back later.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return getCareerTrendItem(
                              context,
                              jobsController
                                  .careerTrends.value!.data!.careers[index],
                            );
                          },
                          itemCount: jobsController
                              .careerTrends.value!.data!.careers.length,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Jobs for you",
                      style: getCTATextStyle(
                        context,
                        14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Showcase(
                    key: _four,
                    enableAutoScroll: true,
                    title: "Jobs for you",
                    targetBorderRadius: BorderRadius.circular(16),
                    description:
                        "Here you can see some job suggestions based on your profile.",
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 210),
                      child: Obx(() {
                        if (jobsController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (jobsController.errorMessage.isNotEmpty) {
                          return Center(
                            child: Text(
                              jobsController.errorMessage.value,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        }
                        if (jobsController.jobs.value == null ||
                            jobsController.jobs.value!.data == null ||
                            jobsController.jobs.value!.data!.jobs == null ||
                            jobsController.jobs.value!.data!.jobs!.length ==
                                0) {
                          return const Center(
                            child: Text(
                              'No job recommendations for you at the moment.\nPlease check back later.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          // itemExtent: 8,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return getJobItem(
                              context,
                              jobsController.jobs.value!.data!.jobs![index],
                            );
                          },
                          itemCount:
                              jobsController.jobs.value!.data!.jobs!.length,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Card getPersonalityTest(BuildContext context) {
    PersonalityType? personalityType = PersonalityType.getType(
      userProfileController.userProfile.value?.personalityType ?? "",
    );
    CategoryColors categoryColors =
        PersonalityType.getCategoryColor(personalityType?.category ?? "");
    return Card(
      color: userProfileController.userProfile.value?.personalityType != null
          ? categoryColors.background
          : primaryBlue,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Showcase(
        key: _one,
        enableAutoScroll: true,
        title: "Free Personality Test",
        targetBorderRadius: BorderRadius.circular(16),
        description:
            "Take the Personality test assesment and get to know yourself better and we will be able to suggest you career guid based on your personalities.",
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userProfileController.userProfile.value != null &&
                  userProfileController.userProfile.value!.personalityType ==
                      null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Start Assessment to know better yourself ",
                            textAlign: TextAlign.center,
                            style: getCTATextStyle(
                              context,
                              16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PersonalityTestScreen.routeName,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text(
                        'Start Assessment',
                        style: getCTATextStyle(
                          context,
                          16,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              if (userProfileController.userProfile.value != null &&
                  userProfileController.userProfile.value!.personalityType !=
                      null &&
                  userProfileController
                          .userProfile.value!.personalityTestResult !=
                      null)
                getPersonalityTestInfo(
                  context,
                  userProfileController.userProfile.value?.personalityType ??
                      "",
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPersonalityTestInfo(BuildContext context, String type) {
    PersonalityType? personalityType = PersonalityType.getType(type);
    CategoryColors categoryColors =
        PersonalityType.getCategoryColor(personalityType?.category ?? "");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Your type: ${personalityType?.name ?? ""} (${personalityType?.category ?? ""})",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: categoryColors.foreground,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 12),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "TF",
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //         Text(
        //           userProfileController
        //               .userProfile.value!.personalityTestResult!.TF
        //               .toStringAsFixed(2),
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "SN",
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //         Text(
        //           userProfileController
        //               .userProfile.value!.personalityTestResult!.SN
        //               .toStringAsFixed(2),
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "EI",
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //         Text(
        //           userProfileController
        //               .userProfile.value!.personalityTestResult!.EI
        //               .toStringAsFixed(2),
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "JP",
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //         Text(
        //           userProfileController
        //               .userProfile.value!.personalityTestResult!.JP
        //               .toStringAsFixed(2),
        //           style: getCTATextStyle(
        //             context,
        //             16,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                "${personalityType?.description ?? ""}",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: Color(0xff787f8d),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EntjDetailsScreen()
                      // PersonalityDetails(
                      //   personalityTestResult: userProfileController
                      //       .userProfile.value!.personalityTestResult!,
                      //   personalityType: personalityType!,
                      //   categoryColors: categoryColors,
                      //   type: userProfileController
                      //           .userProfile.value!.personalityType ??
                      //       "",
                      // ),
                      ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: categoryColors.foreground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text(
                'Details',
                style: getCTATextStyle(
                  context,
                  16,
                  color: categoryColors.background,
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PersonalityTestScreen.routeName,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text(
                'Re-Assess',
                style: getCTATextStyle(
                  context,
                  16,
                  color: categoryColors.foreground,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getJobItem(BuildContext context, JobsModel job) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.only(
        left: 8,
      ),
      child: Card(
        elevation: 3,
        color: scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: job.companyLogo,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          primaryBlue,
                        ),
                      )),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error,
                        ),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert_rounded,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 45,
                child: Text(
                  job.position,
                  maxLines: 2,
                  style: getCTATextStyle(
                    context,
                    14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${job.organization} · ${job.location}\n${job.type} · ${job.locationType}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getFormatedDateForJobs(job.deadline)),
                  Text(
                    getStyledSalaryRange(
                      job.salary,
                      job.salaryMax,
                      job.currency,
                      job.salaryTime,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getGoals(List<String>? goals) {
    return Wrap(
      children: goals?.map((e) {
            return getGoalItem(e);
          }).toList() ??
          [],
    );
  }

  // Widget getGoalItem(String goal) {
  //   return Chip(
  //     backgroundColor: AppColors.primaryColor,
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       side: const BorderSide(color: AppColors.primaryColor),
  //     ),
  //     // shape: RoundedRectangleBorder(
  //     //   borderRadius: BorderRadius.circular(10),
  //     // ),
  //     label: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
  //       child: Column(
  //         children: [
  //           Text(
  //             goal,
  //             style: getCTATextStyle(
  //               context,
  //               14,
  //               color: Colors.white,
  //             ),
  //           ),
  //           SizedBox(width: 5,height: 5,)
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget getGoalItem(String goal) {
    return Chip(
      backgroundColor: AppColors.primaryColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      label: Text(
        goal,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getCareerTrendItem(BuildContext context, Career career) {
    final tag = UniqueKey();
    double width = MediaQuery.of(context).size.width - 60;
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      margin: const EdgeInsets.only(
        left: 8,
      ),
      child: Card(
        elevation: 3,
        color: scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: width / 16 * 9,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Colors.white,
              ),
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  imageUrl: career.image,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      primaryBlue,
                    ),
                  )),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    career.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getCTATextStyle(
                      context,
                      14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    career.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: getBodyTextStyle(
                      context,
                      12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: CustomTextButton(
                      backgroundColor: primaryBlue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      onPressed: () {
                        Get.to(
                          CareerTrends(
                            career: career,
                            heroTag: tag,
                          ),
                        );
                      },
                      textStyle: getCTATextStyle(context, 12),
                      title: "Read More",
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
