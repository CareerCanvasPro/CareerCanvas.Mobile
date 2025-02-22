import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenThree.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getIt;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/ImagePath/ImageAssets.dart';

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
        getIt.Get.back();
        _educationList.add(education);
        setState(() {});
      },
    );
  }

  String formatDate(DateTime date) {
    return DateFormat().add_yMMMMd().format(date);
  }

  Widget _buildEducationCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: index == selectedIndex,
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete_forever_rounded,
          ),
        ),
        collapsedBackgroundColor: primaryBlue,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        controlAffinity: ListTileControlAffinity.leading,
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
        title: Text(
          _educationList[index].field,
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
                "Institute : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  "${_educationList[index].institute}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (_educationList[index].graduationDate != null)
            Row(
              children: [
                Text(
                  "Graduation Date : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    formatDate(
                      DateTime.fromMillisecondsSinceEpoch(
                        _educationList[index].graduationDate!,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Text(
                "Current Education : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  _educationList[index].isCurrent ? 'Current' : 'Past',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Achievements : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  _educationList[index].achievements,
                ),
              ),
            ],
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      print(_educationList[index].certificate!.url);
                      try {
                        await launchUrl(
                          Uri.parse(
                            _educationList[index].certificate!.url,
                          ),
                          mode: LaunchMode.inAppWebView,
                        );
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text(
                      "Certificate.${extensionFromMime(_educationList[index].certificate!.type)}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: primaryBlue,
                      ),
                    ),
                  ),
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
                    Image.asset(
                      ImageAssets.logo, // Replace with your logo path
                      height: 50,
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
              buildProgressBar(progress: 0.4),
              SizedBox(height: 10),
              Text(
                'Hello! Please add your education details below.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),

              // Form fields
              // Dynamic list of education fields
              if (_educationList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _educationList.length,
                    itemBuilder: (context, index) {
                      return _buildEducationCard(index);
                    },
                  ),
                ),

              // Add and Remove Education Buttons
              // Row(
              //   children: [
              //     TextButton(
              //       onPressed: _addEducationField,
              //       child: Text('+ Add Education'),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addEducationField,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: scaffoldBackgroundColor,
                      side: BorderSide(color: primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
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
    return Stack(
      children: [
        Container(
          height: 5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress, // Dynamic progress
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
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
                        if (_educationList.isEmpty) {
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
                          final prefs = await SharedPreferences.getInstance();
                          String token = prefs.getString('token') ?? '';
                          UploadEducation uploadEducation = UploadEducation(
                            education: _educationList,
                          );

                          final response = await dio.put(
                            "${ApiClient.userBase}/user/profile",
                            data: uploadEducation.toJson(),
                            options: Options(
                              headers: {
                                'Content-Type': "application/json",
                                "Authorization": "Bearer $token",
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
                        //     context, ProfileCompletionScreenThree.routeName);
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
      ),
    );
  }
}
