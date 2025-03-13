import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/skills.dart';
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
  Widget _buildSkilssCard(int index) {
    return Card(
      elevation: 3,
      // margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_skills[index]),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _removeSkilssField(index),
              icon: Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
            )
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
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        //title: Text('Career Canvas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: context.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/svg/Career_Canvas_Logo_black.svg",
                          height: 50,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Career\nCanvas")
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Progress Bar
                buildProgressBar(progress: 0.8),
                SizedBox(height: 10),
                Text(
                  'hello! Complete your profile for onboard!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                if (_skills.isNotEmpty)
                  Wrap(
                    children: _skills
                        .map((e) => _buildSkilssCard(_skills.indexOf(e)))
                        .toList(),
                  ),

                SizedBox(height: 30),
                FieldSuggestion<String>(
                  search: (item, input) {
                    if (skillsController.text.isEmpty) return false;
                    return item.toLowerCase().contains(input.toLowerCase());
                  },
                  inputDecoration: InputDecoration(
                    hintText: 'Search Skills',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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
                      child: Card(
                        color: scaffoldBackgroundColor,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            skillsList[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 30),

                // Action buttons
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgressBar({required double progress}) {
    return Row(
      children: [
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 10,
            animation: true,
            percent: progress,
            backgroundColor: Colors.grey.shade300,
            progressColor: primaryBlue,
            barRadius: Radius.circular(10),
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
              onPressed: isUploadingData
                  ? null
                  : () {
                      // Action for skip button
                      debugPrint("Skip button clicked");
                      Navigator.pushNamed(context, HomePage.routeName);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: scaffoldBackgroundColor,
                side: BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Skip',
                style: getCTATextStyle(
                  context,
                  16,
                  color: primaryBlue,
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
                          "${ApiClient.userBase}/user/profile",
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
                          print(e.response!.data["message"]);
                          print(e.response!.headers);
                          print(e.response!.requestOptions);
                          CustomDialog.showCustomDialog(
                            context,
                            title: "Error",
                            content: e.response!.data["message"].toString(),
                          );
                        } else {
                          // Something happened in setting up or sending the request that triggered an Error
                          print(e.requestOptions);
                          print(e.message);
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
                backgroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Done',
                style: getCTATextStyle(context, 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
