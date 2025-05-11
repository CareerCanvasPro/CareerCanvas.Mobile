import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/skills.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenFive.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileCompletionScreenFour extends StatefulWidget {
  static const String routeName = '/profileCompletionFour';

  @override
  _ProfileCompletionScreenFourState createState() =>
      _ProfileCompletionScreenFourState();
}

class _ProfileCompletionScreenFourState
    extends State<ProfileCompletionScreenFour> {
  //final _formKey = GlobalKey<FormState>();
// List to hold the skills form fields
  final TextEditingController skillsController = TextEditingController();
  List<String> _skills = [];

  bool isUploadingData = false;

  @override
  void initState() {
    super.initState();
  }

  // Method to add a new skills field
  void _addSkilssField(String skill) {
    if (_skills.contains(skill)) {
      return;
    }
    setState(() {
      _skills.add(skill);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(int index) {
    if (_skills.isNotEmpty && index < _skills.length) {
      setState(() {
        _skills.removeAt(index);
      });
    }
  }

  // Skills will be in a chieps style design with a x button to remove the skill
  Widget _buildSkilssCard(
    int index, {
    bool isSuggested = false,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSuggested
            ? _addSkilssField(skillsList[index])
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isSuggested ? skillsList[index] : _skills[index],
              style: getCTATextStyle(
                context,
                12,
                color: isSuggested ? Colors.black : primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> skillsList = [
    // Existing skills
    'Flutter',
    'App Development',
    'Web Development',
    'UI/UX',
    'AI',

    // Technical Skills
    // Frontend Development
    'React/React Native',
    'JavaScript/TypeScript',
    'HTML5/CSS3',
    'Redux/State Management',
    'Mobile UI/UX',

    // Backend Development
    'Node.js/Express',
    'RESTful APIs',
    'GraphQL',
    'Microservices',
    'AWS Services',

    // Database
    'MongoDB',
    'PostgreSQL',
    'Redis',
    'Database Design',
    'Query Optimization',

    // DevOps
    'Docker',
    'Kubernetes',
    'CI/CD',
    'AWS Infrastructure',
    'Linux Systems',

    // Testing
    'Jest',
    'React Testing Library',
    'Integration Testing',
    'E2E Testing',
    'Performance Testing',

    // Soft Skills
    // Leadership
    'Team Management',
    'Decision Making',
    'Strategic Planning',
    'Mentoring',
    'Conflict Resolution',

    // Communication
    'Technical Writing',
    'Presentation Skills',
    'Client Communication',
    'Team Collaboration',
    'Documentation',

    // Project Management
    'Agile Methodologies',
    'Sprint Planning',
    'Risk Management',
    'Resource Allocation',
    'Stakeholder Management',

    // Problem Solving
    'Analytical Thinking',
    'Debugging',
    'System Design',
    'Performance Optimization',
    'Root Cause Analysis',

    // Personal Development
    'Continuous Learning',
    'Time Management',
    'Adaptability',
    'Work Ethics',
    'Innovation',
  ];
  List<String> searchSkills(String input) {
    return skillsList
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
                      "Add your Skills below.",
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
                          child: buildProgressBar(progress: 0.8),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "4 of 5",
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
                                if (skillsController.text.isEmpty) return false;
                                return item
                                    .toLowerCase()
                                    .contains(input.toLowerCase());
                              },
                              inputDecoration: InputDecoration(
                                hintText: 'Skill (ex: UI/UX Design)',
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
                              suggestions: skillsList,
                              textController: skillsController,
                              // boxController: boxController, // optional
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(
                                      () => _addSkilssField(
                                        skillsList[index],
                                      ),
                                    );
                                    skillsController.clear();
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          skillsList[index],
                                          style: getCTATextStyle(
                                            context,
                                            12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
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
                    if (_skills.isNotEmpty)
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
                                    "Your Skills",
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
                                    children: _skills
                                        .map((e) => _buildSkilssCard(
                                            _skills.indexOf(e)))
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
                                  "Suggested Skills",
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
                                  children: skillsList
                                              .where((skill) =>
                                                  _skills.isEmpty ||
                                                  !_skills.contains(skill))
                                              .length >
                                          5
                                      ? skillsList
                                          .where((skill) =>
                                              _skills.isEmpty ||
                                              !_skills.contains(skill))
                                          .take(5)
                                          .toList()
                                          .map(
                                            (e) => _buildSkilssCard(
                                              skillsList.indexOf(e),
                                              isSuggested: true,
                                            ),
                                          )
                                          .toList()
                                      : skillsList
                                          .where((skill) =>
                                              _skills.isEmpty ||
                                              !_skills.contains(skill))
                                          .map(
                                            (e) => _buildSkilssCard(
                                              skillsList.indexOf(e),
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
                      Navigator.pushNamed(
                          context, ProfileCompletionScreenFive.routeName);
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
                      // print(_skills);
                      // Navigator.pushNamed(context, HomePage.routeName);
                      if (_skills.isEmpty) {
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
                        UploadSkills uploadSkills =
                            UploadSkills(skills: _skills);

                        final response = await dio.put(
                          "${ApiClient.userBase}/skills",
                          data: uploadSkills.toJson(),
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
                        // getIt<UserProfileController>().getUserProfile();
                        Get.to(
                          () => ProfileCompletionScreenFive(),
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
