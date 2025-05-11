import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/interests.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/HomePage.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileCompletionScreenFive extends StatefulWidget {
  static const String routeName = '/profileCompletionFive';

  @override
  _ProfileCompletionScreenFiveState createState() =>
      _ProfileCompletionScreenFiveState();
}

class _ProfileCompletionScreenFiveState
    extends State<ProfileCompletionScreenFive> {
  //final _formKey = GlobalKey<FormState>();
// List to hold the interests form fields
  final TextEditingController interestController = TextEditingController();
  List<String> _interests = [];

  bool isUploadingData = false;

  @override
  void initState() {
    super.initState();
  }

  // Method to add a new interests field
  void _addSkilssField(String interest) {
    if (_interests.contains(interest)) {
      return;
    }
    setState(() {
      _interests.add(interest);
    });
  }

  // Method to remove the last interests field
  void _removeSkilssField(int index) {
    if (_interests.isNotEmpty && index < _interests.length) {
      setState(() {
        _interests.removeAt(index);
      });
    }
  }

  // Skills will be in a chieps style design with a x button to remove the interest
  Widget _buildSkilssCard(
    int index, {
    bool isSuggested = false,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSuggested
            ? _addSkilssField(interestsList[index])
            : _removeSkilssField(index);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 50,
        ),
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSuggested ? Colors.black : primaryBlue,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          isSuggested ? interestsList[index] : _interests[index],
          overflow: TextOverflow.ellipsis,
          style: getCTATextStyle(
            context,
            12,
            color: isSuggested ? Colors.black : primaryBlue,
          ),
        ),
      ),
    );
  }

  List<String> interestsList = [
    // Core Technical Roles
    "Software Engineer",
    "Frontend Developer",
    "Backend Developer",
    "Full Stack Developer",
    "Mobile Developer",
    "Android Developer",
    "iOS Developer",
    "Web Developer",
    "Data Scientist",
    "Machine Learning Engineer",
    "Artificial Intelligence Engineer",
    "DevOps Engineer",
    "Site Reliability Engineer",
    "Cloud Engineer",
    "Cloud Architect",
    "Data Engineer",
    "Security Engineer",
    "Cybersecurity Analyst",
    "Blockchain Developer",
    "Game Developer",
    "Embedded Systems Engineer",
    "IoT Engineer",
    "AR Developer",
    "VR Developer",
    "Software Architect",
    "Test Engineer",
    "QA Engineer",
    "Automation Engineer",
    "System Administrator",
    "Database Administrator",

    // Specialized & Hybrid Roles
    "AI Engineer",
    "NLP Engineer",
    "Computer Vision Engineer",
    "Infrastructure Engineer",
    "Platform Engineer",
    "Product Engineer",
    "Tools Engineer",
    "Performance Engineer",
    "Firmware Engineer",
    "Solutions Architect",
    "Technical Program Manager",

    // Leadership and Strategy Roles
    "Engineering Manager",
    "Technical Lead",
    "Tech Lead",
    "Team Lead",
    "CTO",
    "VP of Engineering",
    "Chief Architect",

    // Adjacent Technical Roles
    "Product Manager",
    "Technical Product Manager",
    "UX Engineer",
    "UI Engineer",
    "Technical Writer",
    "Developer Advocate",
    "Developer Evangelist",
    "Security Analyst",
    "Penetration Tester",
    "Ethical Hacker",

    // Career/Work Modes
    "Remote Developer",
    "Freelance Developer",
    "Open Source Contributor",
    "Startup Engineer",
    "Technical Consultant"
  ];
  List<String> searchSkills(String input) {
    return interestsList
        .where((element) => element.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
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
            height: context.screenHeight,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Welcome to Career Canvas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Add your Interests below.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Progress Bar
                    Row(
                      children: [
                        Expanded(
                          child: buildProgressBar(progress: 1),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "5 of 5",
                          style: getCTATextStyle(
                            context,
                            12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: FieldSuggestion<String>(
                              search: (item, input) {
                                if (interestController.text.isEmpty)
                                  return false;
                                return item
                                    .toLowerCase()
                                    .contains(input.toLowerCase());
                              },
                              inputDecoration: InputDecoration(
                                hintText: 'Interests (ex: Design)',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
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
                              boxStyle: BoxStyle(
                                backgroundColor: scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              inputType: TextInputType.text,
                              suggestions: interestsList,
                              textController: interestController,
                              // boxController: boxController, // optional
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(
                                      () => _addSkilssField(
                                        interestsList[index],
                                      ),
                                    );
                                    interestController.clear();
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      color: scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      interestsList[index],
                                      overflow: TextOverflow.ellipsis,
                                      style: getCTATextStyle(
                                        context,
                                        12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    if (_interests.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Interests",
                                    style: getCTATextStyle(
                                      context,
                                      14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _interests
                                        .map((e) => _buildSkilssCard(
                                            _interests.indexOf(e)))
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Suggested Interests",
                                  style: getCTATextStyle(
                                    context,
                                    14,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: interestsList
                                              .where((interest) =>
                                                  _interests.isEmpty ||
                                                  !_interests
                                                      .contains(interest))
                                              .length >
                                          5
                                      ? interestsList
                                          .where((interest) =>
                                              _interests.isEmpty ||
                                              !_interests.contains(interest))
                                          .take(5)
                                          .toList()
                                          .map(
                                            (e) => _buildSkilssCard(
                                              interestsList.indexOf(e),
                                              isSuggested: true,
                                            ),
                                          )
                                          .toList()
                                      : interestsList
                                          .where((interest) =>
                                              _interests.isEmpty ||
                                              !_interests.contains(interest))
                                          .map(
                                            (e) => _buildSkilssCard(
                                              interestsList.indexOf(e),
                                              isSuggested: true,
                                            ),
                                          )
                                          .toList(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Action buttons
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressBar({required double progress}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: LinearPercentIndicator(
              lineHeight: 10,
              animation: true,
              percent: progress,
              animateFromLastPercent: true,
              backgroundColor: Colors.white,
              progressColor: primaryBlue,
              barRadius: Radius.circular(10),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/svg/icons/icon_coin_5.svg',
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                disabledBackgroundColor: Colors.white,
                disabledForegroundColor: Colors.grey,
                side: BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(80, 35),
              ),
              child: Text(
                'Back',
                style: getCTATextStyle(
                  context,
                  14,
                  color: primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isUploadingData
                  ? null
                  : () {
                      // Action for skip button
                      debugPrint("Skip button clicked");
                      Navigator.pushNamed(context, HomePage.routeName);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                disabledBackgroundColor: primaryBlue,
                disabledForegroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white),
                ),
                minimumSize: const Size(80, 35),
              ),
              child: Text(
                'Skip',
                style: getCTATextStyle(
                  context,
                  14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isUploadingData
                  ? null
                  : () async {
                      // final allValues = _getAllEducationValues();
                      // print(_interests);
                      // Navigator.pushNamed(context, HomePage.routeName);
                      if (_interests.isEmpty) {
                        return;
                      }
                      try {
                        if (getIt<UserProfileController>().isOnline.value ==
                            false) {
                          throw "You Are Offline";
                        }
                        setState(() {
                          isUploadingData = true;
                        });
                        final dio = Dio(
                          BaseOptions(
                            baseUrl: ApiClient.userBase,
                            connectTimeout: const Duration(seconds: 3000),
                            receiveTimeout: const Duration(seconds: 3000),
                          ),
                        );
                        UploadInterest uploadInterests =
                            UploadInterest(interests: _interests);

                        final response = await dio.put(
                          "${ApiClient.userBase}/interests",
                          data: uploadInterests.toJson(),
                          options: Options(
                            headers: {
                              'Content-Type': "application/json",
                              "Authorization": "Bearer ${TokenInfo.token}",
                            },
                          ),
                        );
                        debugPrint(response.data['message']);
                        setState(() {
                          isUploadingData = false;
                        });
                        getIt<UserProfileController>().getUserProfile();
                        Get.to(
                          () => HomePage(),
                        );
                      } on DioException catch (e) {
                        setState(() {
                          isUploadingData = false;
                        });
                        // The request was made and the server responded with a status code
                        // that falls out of the range of 2xx and is also not 304.
                        if (e.response != null) {
                          // print(e.response!.data["message"]);
                          // print(e.response!.headers);
                          // print(e.response!.requestOptions);
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Error",
                            content: e.response!.data["message"].toString(),
                          );
                        } else {
                          // Something happened in setting up or sending the request that triggered an Error
                          // print(e.requestOptions);
                          // print(e.message);
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Error",
                            content: e.message.toString(),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                        setState(() {
                          isUploadingData = false;
                        });
                        CustomDialog.showCustomDialog(
                          context,
                          title: "Error",
                          content: e.toString(),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                disabledBackgroundColor: Colors.white,
                disabledForegroundColor: Colors.grey,
                side: BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(80, 35),
              ),
              child: Text(
                'Next',
                style: getCTATextStyle(
                  context,
                  14,
                  color: primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
