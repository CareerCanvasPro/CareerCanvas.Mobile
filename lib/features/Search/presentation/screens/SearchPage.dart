import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Search/presentation/getx/controllers/searchController.dart';
import 'package:career_canvas/features/Search/presentation/screens/CourseDetails.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  late final GlobalSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = getIt<GlobalSearchController>();
    if (searchController.courses.value == null) {
      searchController.getCoursesRecomendation();
    }
    if (searchController.jobs.value == null ||
        searchController.jobs.value!.data == null ||
        searchController.jobs.value!.data!.jobs == null) {
      searchController.getJobsRecomendation();
    }
  }

  Future<void> onRefresh() async {
    await searchController.getCoursesRecomendation();
    await searchController.getJobsRecomendation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: CustomMaterialIndicator(
        onRefresh: onRefresh,
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              elevation: 3,
              color: scaffoldBackgroundColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          focusNode.unfocus();
                          if (searchController.searchState.value ==
                              SearchState.course) {
                            searchController.searchCourses(value);
                          } else {
                            searchController.searchJobs(value);
                          }
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          isCollapsed: false,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () {
                          focusNode.unfocus();
                          if (searchController.searchState.value ==
                              SearchState.course) {
                            searchController.searchCourses(controller.text);
                          } else {
                            searchController.searchJobs(controller.text);
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/icons/search_icon.svg",
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Obx(() {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              searchController.searchQuery.value.isEmpty
                                  ? 'Recomended ${searchController.searchState.value == SearchState.course ? "Courses" : "Jobs"}'
                                  : '${searchController.searchState.value == SearchState.course ? "Courses" : "Jobs"} Result for: "${searchController.searchQuery.value}"',
                              style: getCTATextStyle(
                                context,
                                12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          PopupMenuButton<SearchState>(
                            initialValue: searchController.searchState.value,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Radio.adaptive(
                                        value: SearchState.course,
                                        fillColor:
                                            WidgetStatePropertyAll(primaryBlue),
                                        groupValue:
                                            searchController.searchState.value,
                                        onChanged: null,
                                      ),
                                      Text(
                                        "Courses",
                                        style: getCTATextStyle(
                                          context,
                                          12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: SearchState.course,
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Radio.adaptive(
                                        value: SearchState.job,
                                        groupValue:
                                            searchController.searchState.value,
                                        fillColor:
                                            WidgetStatePropertyAll(primaryBlue),
                                        onChanged: null,
                                      ),
                                      Text(
                                        "Jobs",
                                        style: getCTATextStyle(
                                          context,
                                          12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: SearchState.job,
                                ),
                              ];
                            },
                            onSelected: (value) {
                              controller.text = "";
                              searchController.searchQuery.value = "";
                              searchController.searchState.value = value;
                            },
                            icon: SvgPicture.asset(
                              "assets/svg/icons/Icon_Filter.svg",
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (searchController.searchState.value == SearchState.job)
                      Expanded(
                        child: Column(
                          children: [
                            if (searchController.isLoading.value)
                              Expanded(
                                child: Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (!searchController.isLoading.value &&
                                searchController.jobsErrorMessage.isNotEmpty)
                              Center(
                                child: Text(
                                  searchController.jobsErrorMessage.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            if (!searchController.isLoading.value &&
                                searchController.jobsErrorMessage.isEmpty &&
                                (searchController
                                        .jobs.value?.data?.jobs?.isNotEmpty ??
                                    false))
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return getJobsItem(
                                      context,
                                      searchController
                                          .jobs.value!.data!.jobs![index],
                                    );
                                  },
                                  itemCount: searchController
                                      .jobs.value!.data!.jobs!.length,
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (searchController.searchState.value ==
                        SearchState.course)
                      Expanded(
                        child: Column(
                          children: [
                            if (searchController.isLoading.value)
                              Expanded(
                                child: Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (!searchController.isLoading.value &&
                                searchController.coursesErrorMessage.isNotEmpty)
                              Center(
                                child: Text(
                                  searchController.coursesErrorMessage.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            if (!searchController.isLoading.value &&
                                searchController.coursesErrorMessage.isEmpty &&
                                (searchController.courses.value?.data?.courses
                                        ?.isNotEmpty ??
                                    false))
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return getCourseItem(
                                        context,
                                        searchController.courses.value!.data!
                                            .courses![index]);
                                  },
                                  itemCount: searchController
                                      .courses.value!.data!.courses!.length,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
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

  String formatedDate(DateTime? date) {
    if (date == null) {
      return "N/A";
    }
    return DateFormat.yMEd().format(date);
  }

  Widget getJobsItem(
    BuildContext context,
    JobsModel job,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 4,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: GestureDetector(
          onTap: () {
            CustomDialog.showCustomDialog(
              context,
              title: "Redirection Alert",
              content:
                  "You are about to be redirected to the job page of ${job.sourceName ?? "Source"}. Do you want to continue?",
              buttonText: "Continue",
              button2Text: "Cancel",
              onPressed: () async {
                Get.back();
                if (job.url != null && job.url!.isNotEmpty) {
                  await launchUrl(
                    Uri.parse(job.url!),
                    mode: LaunchMode.inAppBrowserView,
                  );
                }
              },
              onPressed2: () {
                Get.back();
              },
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: primaryBlue,
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: job.companyLogo ?? "https://google.com",
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          primaryBlue,
                        ),
                      )),
                      errorWidget: (context, url, error) => Center(
                        child: SvgPicture.asset(
                          "assets/svg/icons/Icon_Work_experience.svg",
                        ),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          job.position.toString(),
                                          style: getCTATextStyle(
                                            context,
                                            14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          job.organization.toString() +
                                              " · " +
                                              job.location.toString(),
                                          style: getCTATextStyle(
                                            context,
                                            12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (job.isSaved) {
                                  await searchController.unsaveJob(job);
                                } else {
                                  await searchController.saveJob(job);
                                }
                              },
                              icon: SvgPicture.asset(
                                job.isSaved
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
                                "Deadline: ${formatedDate(job.deadline)}",
                                style: getCTATextStyle(
                                  context,
                                  12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryBlue,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Text(
                                job.locationType.toString(),
                                style: getCTATextStyle(
                                  context,
                                  12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryBlue,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Text(
                                job.type.toString(),
                                style: getCTATextStyle(
                                  context,
                                  12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (job.sourceName != null)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryBlue,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "By ${job.sourceName ?? "N/A"}",
                                  style: getCTATextStyle(
                                    context,
                                    12,
                                    color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget getCourseItem(BuildContext context, CoursesModel course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      padding: const EdgeInsets.only(right: 16.0),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => CourseDetails(
              course: course,
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
              tag: course.id,
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

  String formatNumber(num value) {
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B'; // Billion
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M'; // Million
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K'; // Thousand
    } else {
      return value.toString(); // No formatting needed
    }
  }
}
