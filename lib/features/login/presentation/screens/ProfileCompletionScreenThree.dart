import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenFour.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileCompletionScreenThree extends StatefulWidget {
  static const String routeName = '/profileCompletionThree';

  @override
  _ProfileCompletionScreenThreeState createState() =>
      _ProfileCompletionScreenThreeState();
}

class _ProfileCompletionScreenThreeState
    extends State<ProfileCompletionScreenThree> {
  //final _formKey = GlobalKey<FormState>();
// List endDate hold the experience form fields

  List<Experiance> _experiances = [];
  int selectedIndex = 0;
  bool isUploadingData = false;

  @override
  void initState() {
    super.initState();
    // Run after ui build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addExperienceField(); // Add one initial experience section
    });
  }

  // Method endDate add a new experience field
  void _addExperienceField() async {
    CustomDialog.showAddExperianceDialog(
      context,
      onPressedSubmit: (experiance) {
        Get.back();
        _experiances.add(experiance);
        setState(() {});
      },
    );
  }

  void _removeExperiance(int index) {
    if (_experiances.isNotEmpty && index < _experiances.length) {
      setState(() {
        _experiances.removeAt(index);
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat().add_yMMMMd().format(date);
  }

  Widget _buildExperienceCard(int index) {
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
                Expanded(
                  child: Text(
                    _experiances[index].designation +
                        " of " +
                        _experiances[index].organization,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _removeExperiance(index);
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
                  "Organization : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${_experiances[index].organization}",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Designation : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${_experiances[index].designation}",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Start Date : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        formatDate(
                          _experiances[index].startDate,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_experiances[index].endDate == null)
                  SizedBox(
                    width: 8,
                  ),
                if (_experiances[index].endDate == null)
                  Text(
                    "Occupation : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (_experiances[index].endDate == null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _experiances[index].isCurrent
                              ? "Current Occupation"
                              : "Past Occupation",
                        ),
                      ),
                    ],
                  ),
                if (_experiances[index].endDate != null)
                  SizedBox(
                    width: 8,
                  ),
                if (_experiances[index].endDate != null)
                  Text(
                    "End Date : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (_experiances[index].endDate != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatDate(
                            _experiances[index].endDate!,
                          ),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Welcome endDate Career Canvas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Add your experiance details below.",
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
                          child: buildProgressBar(progress: 0.6),
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
                    SizedBox(height: 10),
                    if (_experiances.isEmpty)
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Experiance Info Added.',
                          style: getCTATextStyle(
                            context,
                            14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    // Form fields
                    // Dynamic list of experience fields
                    if (_experiances.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _experiances.length,
                        itemBuilder: (context, index) {
                          return _buildExperienceCard(index);
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _addExperienceField,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: scaffoldBackgroundColor,
                              side: BorderSide(color: primaryBlue),
                              fixedSize: Size(double.maxFinite, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              '+ Add Experience',
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
                        context,
                        ProfileCompletionScreenFour.routeName,
                      );
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
                      if (_experiances.isEmpty) {
                        return;
                      }
                      try {
                        if (await getIt<UserProfileController>().isOnline ==
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
                        UploadExperiance exp = UploadExperiance(
                          occupations: _experiances,
                        );

                        final response = await dio.post(
                          "${ApiClient.userBase}/occupations",
                          data: exp.toJson(),
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
                          () => ProfileCompletionScreenFour(),
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
                      //   context,
                      //   ProfileCompletionScreenFour.routeName,
                      // );
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
