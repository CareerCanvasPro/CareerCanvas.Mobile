import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/CoursesController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SkillsPage extends StatefulWidget {
  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late final CoursesController coursesController;
  @override
  void initState() {
    super.initState();
    coursesController = getIt<CoursesController>();
    if (coursesController.courses.value == null) {
      coursesController.getCoursesRecomendation();
      coursesController.getCoursesBasedOnGoals();
    }
  }

  String getFormatedDutaionForCourse(int seconds) {
    if (seconds < 60) return "${seconds}s"; // Less than 1 minute

    const int minute = 60;
    const int hour = 60 * minute;
    const int day = 24 * hour;
    const int week = 7 * day;
    const int month = 30 * day; // Approximate month length
    const int year = 365 * day; // Approximate year length

    if (seconds >= year) {
      int y = seconds ~/ year;
      int remainingDays = (seconds % year) ~/ day;
      return remainingDays > 0 ? "${y}y ${remainingDays}d" : "${y}y";
    }

    if (seconds >= month) {
      int mo = seconds ~/ month;
      int remainingDays = (seconds % month) ~/ day;
      return remainingDays > 0 ? "${mo}mo ${remainingDays}d" : "${mo}mo";
    }

    if (seconds >= week) {
      int w = seconds ~/ week;
      int remainingDays = (seconds % week) ~/ day;
      return remainingDays > 0 ? "${w}w ${remainingDays}d" : "${w}w";
    }

    if (seconds >= day) {
      int d = seconds ~/ day;
      int remainingHours = (seconds % day) ~/ hour;
      return remainingHours > 0 ? "${d}d ${remainingHours}h" : "${d}d";
    }

    if (seconds >= hour) {
      int h = seconds ~/ hour;
      int remainingMinutes = (seconds % hour) ~/ minute;
      return remainingMinutes > 0 ? "${h}h ${remainingMinutes}m" : "${h}h";
    }

    // If it's more than a minute but less than an hour
    int m = seconds ~/ minute;
    int remainingSeconds = seconds % minute;
    return remainingSeconds > 0 ? "${m}m ${remainingSeconds}s" : "${m}m";
  }

  Future<void> onRefresh() async {
    await coursesController.getCoursesRecomendation();
    await coursesController.getCoursesBasedOnGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/icons/icon_skills_page.svg",
              height: 30,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 8),
            Text(
              "Skills",
              style: getCTATextStyle(
                context,
                24,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: CustomMaterialIndicator(
        onRefresh: onRefresh,
        triggerMode: IndicatorTriggerMode.onEdge,
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
          primary: true,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Skills for you",
                    style: getCTATextStyle(
                      context,
                      16,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: Obx(() {
                    if (coursesController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (coursesController.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          coursesController.errorMessage.value,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    if (coursesController.courses.value == null ||
                        coursesController.courses.value!.data == null ||
                        coursesController.courses.value!.data!.courses ==
                            null) {
                      return const Center(child: Text('No Courses Available'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return getCourseItem(
                            context,
                            coursesController
                                .courses.value!.data!.courses![index]);
                      },
                      itemCount: coursesController
                          .courses.value!.data!.courses!.length,
                    );
                  }),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Skills based on your goals",
                    style: getCTATextStyle(
                      context,
                      16,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: Obx(() {
                    if (coursesController.isLoadingGolsBasedCourses.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (coursesController.courses.value == null ||
                        coursesController.courses.value!.data == null ||
                        coursesController.courses.value!.data!.courses ==
                            null) {
                      return const Center(child: Text('No Courses Available'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return getCourseItem(
                            context,
                            coursesController
                                .coursesGoals.value!.data!.courses![index]);
                      },
                      itemCount: coursesController
                          .coursesGoals.value!.data!.courses!.length,
                    );
                  }),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCourseItem(BuildContext context, CoursesModel course) {
    return Container(
      width: 312,
      margin: const EdgeInsets.only(left: 12.0),
      child: Card(
        elevation: 3,
        color: scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              width: 312,
              height: 130,
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: course.image,
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
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: Text(
                      course.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: getCTATextStyle(
                        context,
                        14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "${course.level} · ${getFormatedDutaionForCourse(course.duration)} · ${course.authors.first}",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.15),
                    height: 12,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        course.sourceName,
                      ),
                      Spacer(),
                      Icon(Icons.star, color: orangeStar, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "${course.rating} (${course.ratingCount})",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
