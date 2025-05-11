import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/JobsController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class JobsScreen extends StatefulWidget {
  static const String routeName = "/jobs";
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late final UserProfileController userProfileController;
  late final JobsController jobsController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_checkScrollPosition);
    jobsController = getIt<JobsController>();
    if (jobsController.jobs.value == null) {
      jobsController.getJobsRecomendation();
    }
    userProfileController = getIt<UserProfileController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile();
    }
  }

  String formatedDate(DateTime? date) {
    if (date == null) {
      return "N/A";
    }
    return DateFormat.yMMMMd().format(date);
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
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/icons/Icon_jobs.svg",
              height: 30,
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "Jobs",
              style: getCTATextStyle(
                context,
                24,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // primary: true,
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8,
              ),
              child: Text(
                "Saved Jobs",
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 280,
                minHeight: 200,
              ),
              child: Obx(() {
                if (userProfileController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (userProfileController
                        .userProfile.value?.savedJobs.isEmpty ??
                    true) {
                  return const Center(
                    child: Text(
                      'No job saved yet.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  // itemExtent: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return getSavedJobItem(
                      context,
                      userProfileController.userProfile.value!.savedJobs[index],
                      true,
                    );
                  },
                  itemCount:
                      userProfileController.userProfile.value!.savedJobs.length,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8,
              ),
              child: Text(
                "Reccomended Jobs",
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height - 190,
              child: Obx(() {
                if (jobsController.isLoading.value)
                  return Container(
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          primaryBlue,
                        ),
                      ),
                    ),
                  );
                if (!jobsController.isLoading.value &&
                    jobsController.errorMessage.isNotEmpty)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        jobsController.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                if (jobsController.jobs.value?.data?.jobs?.isEmpty ?? true)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "No jobs available at the moment. Please check back later.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );

                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return getJobsItem(
                      context,
                      jobsController.jobs.value!.data!.jobs![index],
                    );
                  },
                  itemCount: jobsController.jobs.value!.data!.jobs!.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSavedJobItem(
    BuildContext context,
    JobsModel job,
    bool isSaved,
  ) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
      margin: const EdgeInsets.only(
        left: 8,
      ),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        await jobsController.unsaveJob(job);
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
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            job.position.toString(),
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
                            job.organization.toString() +
                                " · " +
                                job.location.toString(),
                            maxLines: 2,
                            style: getCTATextStyle(
                              context,
                              12,
                              color: Colors.grey,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                                  await jobsController.unsaveJob(job);
                                } else {
                                  await jobsController.saveJob(job);
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
}
