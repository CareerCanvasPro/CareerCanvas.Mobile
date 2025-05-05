import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatelessWidget {
  final CoursesModel course;
  final String? tag;
  const CourseDetails({super.key, required this.course, this.tag});

  String getImageCardTitle(List<TagModel> tags) {
    if (tags.isEmpty) return "";

    // Extract valid names from tags (after ':', if present)
    final words = tags
        .map((tag) => tag.name?.split(":").last.trim().replaceAll("-", " "))
        .where((word) => word != null && word.isNotEmpty)
        .cast<String>()
        .toList();

    // Join up to 3 words into a title
    return words.take(3).join("\n");
  }

  double getFontSizeBasedOnLongestWord(String title) {
    final words = title.trim().split(RegExp(r"\s+"));
    if (words.isEmpty) return 24;

    final longestLength =
        words.map((w) => w.length).reduce((a, b) => a > b ? a : b);

    if (longestLength <= 5) return 20;
    if (longestLength <= 8) return 18;
    if (longestLength <= 10) return 16;
    if (longestLength <= 12) return 14;
    return 12; // for very long words
  }

  String formatedDate(DateTime date) {
    return DateFormat.yMEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Course Details",
          style: getCTATextStyle(
            context,
            16,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: tag ?? course.id,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryBlue,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                width: MediaQuery.of(context).size.width,
                height: 120,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.bottomLeft,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    getImageCardTitle(course.tags).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSizeBasedOnLongestWord(
                          getImageCardTitle(course.tags)),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${formatedDate(course.updatedAt)} . ${course.sourceName}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    course.description,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (var tag in course.tags)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            tag.name
                                    ?.split(":")
                                    .last
                                    .trim()
                                    .replaceAll("-", " ")
                                    .capitalize ??
                                "",
                            style: getCTATextStyle(
                              context,
                              12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomTextButton(
                      onPressed: () {
                        CustomDialog.showCustomDialog(
                          context,
                          title: "Redirection Alert",
                          content:
                              "You are about to be redirected to the course page of ${course.sourceName}. Do you want to continue?",
                          buttonText: "Continue",
                          button2Text: "Cancel",
                          onPressed: () async {
                            Get.back();
                            await launchUrl(
                              Uri.parse(course.sourceUrl),
                              mode: LaunchMode.inAppBrowserView,
                            );
                          },
                          onPressed2: () {
                            Get.back();
                          },
                        );
                      },
                      title: "Enroll Now in ${course.sourceName}",
                      backgroundColor: primaryBlue,
                      textStyle: getCTATextStyle(
                        context,
                        12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
