import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenFour.dart';
import 'package:career_canvas/src/constants.dart';
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
// List to hold the experience form fields

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

  // Method to add a new experience field
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: index == selectedIndex,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onExpansionChanged: (value) {
          setState(() {
            selectedIndex = value ? index : 0;
          });
        },
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.only(
          left: 24,
          bottom: 16,
          right: 24,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        trailing: IconButton(
          onPressed: () {
            _removeExperiance(index);
          },
          icon: Icon(
            Icons.delete_forever_rounded,
            color: Colors.red,
          ),
        ),
        collapsedBackgroundColor: primaryBlue,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        iconColor: Colors.black,
        title: Text(
          _experiances[index].designation +
              " of " +
              _experiances[index].organization,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Row(
            children: [
              Text(
                "Organization : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Text(
                  "${_experiances[index].organization}",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Designation : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Text(
                  "${_experiances[index].designation}",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Start Date : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Text(
                  formatDate(DateTime.fromMillisecondsSinceEpoch(
                    _experiances[index].from,
                  )),
                ),
              ),
            ],
          ),
          if (_experiances[index].to == null)
            Row(
              children: [
                Text(
                  "Occupation : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Text(
                    _experiances[index].isCurrent
                        ? "Current Occupation"
                        : "Past Occupation",
                  ),
                ),
              ],
            ),
          if (_experiances[index].to != null)
            Row(
              children: [
                Text(
                  "End Date : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch(
                    _experiances[index].to!,
                  ))),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        //title: Text('Career Canvas'),
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: context.screenHeight,
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
              buildProgressBar(progress: 0.6),
              SizedBox(height: 10),
              Text(
                'Hello! Please add your experience details below.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              if (_experiances.isEmpty)
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No Experiance Info Added.',
                      style: getCTATextStyle(
                        context,
                        16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              // Form fields
              // Dynamic list of experience fields
              if (_experiances.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _experiances.length,
                    itemBuilder: (context, index) {
                      return _buildExperienceCard(index);
                    },
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addExperienceField,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: scaffoldBackgroundColor,
                      side: BorderSide(color: primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
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
                ],
              ),

              SizedBox(height: 30),

              // Action buttons
              _buildFooter(context),
            ],
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
                      Navigator.pushNamed(
                        context,
                        ProfileCompletionScreenFour.routeName,
                      );
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
                      if (_experiances.isEmpty) {
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
                        UploadExperiance exp = UploadExperiance(
                          occupation: _experiances,
                        );

                        final response = await dio.put(
                          "${ApiClient.userBase}/user/profile",
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
                      // Navigator.pushNamed(
                      //   context,
                      //   ProfileCompletionScreenFour.routeName,
                      // );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Next',
                style: getCTATextStyle(context, 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
