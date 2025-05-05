import 'dart:math';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/CoursesController.dart';
import 'package:career_canvas/features/Search/presentation/screens/CourseDetails.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
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
  late final UserProfileController userProfileController;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_checkScrollPosition);
    coursesController = getIt<CoursesController>();
    if (coursesController.courses.value == null) {
      coursesController.getCoursesRecomendation();
    }
    userProfileController = getIt<UserProfileController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile();
    }
  }

  Future<void> onRefresh() async {
    await coursesController.getCoursesRecomendation();
  }

  bool _showFab = false;
  void _checkScrollPosition() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final percent = currentScroll / maxScroll;

    if (percent >= 0.8 && !_showFab) {
      setState(() => _showFab = true);
    } else if (percent < 0.8 && _showFab) {
      setState(() => _showFab = false);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_checkScrollPosition);
    scrollController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(
                Icons.arrow_upward_rounded,
              ),
            )
          : null,
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
          // primary: true,
          controller: scrollController,
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
                    "Saved Courses",
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
                  constraints:
                      const BoxConstraints(maxHeight: 280, minHeight: 200),
                  child: Obx(() {
                    if (userProfileController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userProfileController.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          userProfileController.errorMessage.value,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    if (userProfileController
                            .userProfile.value?.savedCourses.isEmpty ??
                        true) {
                      return const Center(child: Text('No Courses Saved.'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return getSavedCourseItem(
                          context,
                          userProfileController
                              .userProfile.value!.savedCourses[index],
                          true,
                        );
                      },
                      itemCount: userProfileController
                          .userProfile.value!.savedCourses.length,
                    );
                  }),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Recommended Courses",
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
                  constraints: const BoxConstraints(minHeight: 200),
                  child: Obx(() {
                    if (coursesController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (coursesController.courses.value == null ||
                        coursesController.courses.value!.data == null ||
                        coursesController.courses.value!.data!.courses ==
                            null ||
                        coursesController
                            .courses.value!.data!.courses!.isEmpty) {
                      return const Center(child: Text('No Courses Available'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
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
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSavedCourseItem(
    BuildContext context,
    CoursesModel course,
    bool isSaved,
  ) {
    String tag = course.id + UniqueKey().toString();
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CourseDetails(
            course: course,
            tag: tag,
          ),
        );
      },
      child: Container(
        width: 312,
        margin: const EdgeInsets.only(left: 12.0),
        child: Card(
          elevation: 3,
          color: scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: tag,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: primaryBlue,
                  ),
                  width: 312,
                  height: 130,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
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
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
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
                        IconButton(
                          onPressed: () async {
                            await coursesController.unsaveCourse(course);
                          },
                          icon: SvgPicture.asset(
                            isSaved
                                ? "assets/svg/icons/Icon_Bookmarked.svg"
                                : "assets/svg/icons/Icon_Bookmark.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${course.description}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Course By ${course.sourceName}",
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCourseItem(BuildContext context, CoursesModel course) {
    String tag = course.id + UniqueKey().toString();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      padding: const EdgeInsets.only(right: 16.0),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => CourseDetails(
              course: course,
              tag: tag,
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
              tag: tag,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryBlue,
                ),
                padding: const EdgeInsets.all(8.0),
                width: 120,
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
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
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
                        IconButton(
                          onPressed: () async {
                            if (course.isSaved) {
                              await coursesController.unsaveCourse(course);
                            } else {
                              await coursesController.saveCourse(course);
                            }
                          },
                          icon: SvgPicture.asset(
                            course.isSaved
                                ? "assets/svg/icons/Icon_Bookmarked.svg"
                                : "assets/svg/icons/Icon_Bookmark.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course.description,
                            style: getBodyTextStyle(context, 12,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Course By ${course.sourceName}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
