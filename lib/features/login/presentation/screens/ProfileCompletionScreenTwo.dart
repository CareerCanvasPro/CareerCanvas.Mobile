import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenThree.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getG;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileCompletionScreenTwo extends StatefulWidget {
  static const String routeName = '/profileCompletiontwo';

  @override
  _ProfileCompletionScreenTwoState createState() =>
      _ProfileCompletionScreenTwoState();
}

class _ProfileCompletionScreenTwoState
    extends State<ProfileCompletionScreenTwo> {
  List<Education> _educationList = [];
  bool isUploadingData = false;
  bool isUploadingCertificate = false;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // Run after ui build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addEducationField(); // Add one initial education section
    });
  }

  // Method to add a new education field
  void _addEducationField() async {
    CustomDialog.showAddEducationDialog(
      context,
      onPressedSubmit: (education) {
        getG.Get.back();
        _educationList.add(education);
        setState(() {});
      },
    );
  }

  void _removeEducation(int index) {
    if (_educationList.isNotEmpty && index < _educationList.length) {
      setState(() {
        _educationList.removeAt(index);
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat().add_yMMMMd().format(date);
  }

  Widget _buildEducationCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryBlue,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _educationList[index].field,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  onPressed: () {
                    _removeEducation(index);
                  },
                  icon: Image.asset(
                    "assets/icons/delete_icon.png",
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Institute : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${_educationList[index].institute}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (_educationList[index].graduationDate != null)
                  SizedBox(
                    height: 8,
                  ),
                if (_educationList[index].graduationDate != null)
                  Text(
                    "${_educationList[index].graduationDate!.isAfter(DateTime.now()) ? "Expected " : ""}Graduation Date : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (_educationList[index].graduationDate != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatDate(
                            _educationList[index].graduationDate!,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Status : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _educationList[index].isCurrent
                            ? 'Running'
                            : 'Completed',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Achievements : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _educationList[index].achievements,
                      ),
                    ),
                  ],
                ),
                if (_educationList[index].certificate != null)
                  SizedBox(
                    height: 8,
                  ),
                if (_educationList[index].certificate != null)
                  Row(
                    children: [
                      Text(
                        "Certificate : ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Certificate.${extensionFromMime(_educationList[index].certificate!.type)}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: primaryBlue,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 0,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      "Add your education details below.",
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
                          child: buildProgressBar(progress: 0.4),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "2 of 5",
                          style: getCTATextStyle(
                            context,
                            12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    if (_educationList.isEmpty)
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Education Info Added.',
                          style: getCTATextStyle(
                            context,
                            14,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    // Form fields
                    // Dynamic list of education fields
                    if (_educationList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _educationList.length,
                        itemBuilder: (context, index) {
                          return _buildEducationCard(index);
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _addEducationField,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: scaffoldBackgroundColor,
                              side: BorderSide(color: primaryBlue),
                              fixedSize: Size(double.maxFinite, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              '+ Add Education',
                              style: getCTATextStyle(
                                context,
                                14,
                                color: primaryBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Action buttons
                    _buildFooter(context),
                    SizedBox(height: 30),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
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
                        Navigator.pushNamed(
                            context, ProfileCompletionScreenThree.routeName);
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
                  'Skip',
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
                    : () async {
                        if (_educationList.isEmpty) {
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
                          UploadEducation uploadEducation = UploadEducation(
                            educations: _educationList,
                          );

                          final response = await dio.post(
                            "${ApiClient.userBase}/educations",
                            data: uploadEducation.toJson(),
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
                          Get.to(
                            () => ProfileCompletionScreenThree(),
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
                        // Navigator.pushNamed(
                        //     context, ProfileCompletionScreenThree.routeName);
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
                  'Next',
                  style: getCTATextStyle(
                    context,
                    14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
