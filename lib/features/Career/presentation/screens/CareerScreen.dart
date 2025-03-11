import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/JobsController.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/widgets/goals_dialog.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines_plus/timelines_plus.dart';

// Job Model
class Job {
  final int id;
  final String role;
  final String company;
  final String location;
  final List<String> tags;
  final String salary;

  Job({
    required this.id,
    required this.role,
    required this.company,
    required this.location,
    required this.tags,
    required this.salary,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      salary: json['salary'] ?? '',
    );
  }
}

// JobService: API Service for fetching jobs
class JobService {
  Future<List<Job>> fetchJobs() async {
    // Simulate an API delay
    await Future.delayed(const Duration(seconds: 0));

    // Mock API response
    final response = [
      {
        "id": 1,
        "role": "UI/UX Designer",
        "company": "Google Inc.",
        "location": "California, USA",
        "tags": ["Design", "Full time", "Senior Designer"],
        "salary": "\$15K/Mo"
      },
      {
        "id": 2,
        "role": "UX Researcher",
        "company": "Twitter Inc.",
        "location": "California, USA",
        "tags": ["Research", "Full time", "Mid-level"],
        "salary": "\$12K/Mo"
      },
      {
        "id": 3,
        "role": "Frontend Developer",
        "company": "Meta Platforms",
        "location": "Seattle, USA",
        "tags": ["Development", "Full time", "Junior Developer"],
        "salary": "\$10K/Mo"
      }
    ];

    // Convert the response to a list of Job objects
    return response.map((job) => Job.fromJson(job)).toList();
  }
}

class UserGoal {
  final String title;
  final String description;
  final int date;

  UserGoal({
    required this.title,
    required this.description,
    required this.date,
  });

  factory UserGoal.fromJson(Map<String, dynamic> json) {
    return UserGoal(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? 0,
    );
  }
}

// CareerScreen
class CareerScreen extends StatefulWidget {
  CareerScreen({super.key});

  static const String routeName = "/careerScreen";

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  final JobService jobService = JobService();
  late final JobsController jobsController;
  late final UserProfileController userProfileController;

  @override
  void initState() {
    super.initState();
    jobsController = getIt<JobsController>();
    if (jobsController.jobs.value == null) {
      jobsController.getJobsRecomendation();
    }
    userProfileController = getIt<UserProfileController>();
    if (userProfileController.userProfile.value == null) {
      userProfileController.getUserProfile();
    }
  }

  final List<UserGoal> userGoals = [
    UserGoal(
      title: 'Master a New Programming Language',
      description: 'Bachelor\'s Degree, Career Canvas',
      date: DateTime.now().add(Duration(days: 10)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Build and Deploy a Full-Stack App',
      description: 'Internship, Career Canvas',
      date: DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Improve Code Quality',
      description: 'MBA, Career Canvas',
      date: DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Automate a Repetitive Task',
      description: 'MBA, Career Canvas',
      date: DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch,
    ),
  ];

  String getFormatedDateForTimeline(DateTime date) {
    return DateFormat().add_MMM().add_y().format(date);
  }

  String getFormatedDateForJobs(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    return DateFormat().add_MMM().add_y().format(dateTime);
  }

  String getStyledSalaryRange(
      int salary, int? salaryMax, String currency, String salaryTime) {
    String salaryRange = '';
    if (salaryMax != null) {
      salaryRange =
          '${currency} ${formatNumber(salary)} - ${formatNumber(salaryMax)}';
    } else {
      salaryRange = '${currency} ${formatNumber(salary)}';
    }

    // Convert salary time format
    String timeAbbreviation = salaryTime.toLowerCase() == 'month'
        ? 'M'
        : (salaryTime.toLowerCase() == 'year' ||
                salaryTime.toLowerCase() == 'annum'
            ? 'Y'
            : salaryTime); // Default to original if not "Month" or "Year"
    if (salaryTime.isNotEmpty) {
      salaryRange += '/$timeAbbreviation';
    }
    return salaryRange;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/svg/icons/career_screen_icon.svg',
              width: 30,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(width: 8),
            Text(
              'Career',
              style: getCTATextStyle(context, 24, color: Colors.black),
            ),
          ],
        ),
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assesment",
                  style: getCTATextStyle(context, 16, color: Colors.black),
                ),
                Card(
                  color: primaryBlue,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Start Assessment to know better yourself ",
                                textAlign: TextAlign.center,
                                style: getCTATextStyle(
                                  context,
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PersonalityTestScreen.routeName,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          child: Text(
                            'Start Assessment',
                            style: getCTATextStyle(
                              context,
                              16,
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Who am I",
                  style: getCTATextStyle(context, 16, color: Colors.black),
                ),
                Card(
                  color: primaryBlue,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: CachedNetworkImage(
                                imageUrl: userProfileController
                                        .userProfile.value?.profilePicture ??
                                    "",
                                placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.error,
                                  ),
                                ),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfileController
                                            .userProfile.value?.name ??
                                        "",
                                    style: getCTATextStyle(
                                      context,
                                      16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    userProfileController.userProfile.value
                                            ?.personalityType ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Goals & Timeline",
                      style: getCTATextStyle(context, 16, color: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog.adaptive(
                            scrollable: true,
                            content: AddGoals(
                              onSubmit: (List<String> goals) async {
                                await userProfileController.updateGoals(goals);
                                await userProfileController.getUserProfile();
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text(
                        "Add New Goal",
                        style: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
                    )
                  ],
                ),
                (userProfileController.userProfile.value?.goals.isNotEmpty ??
                        false)
                    ? getGoals(userProfileController.userProfile.value?.goals)
                    : Center(
                        child: Text(
                          "No Goals Yet",
                          style: getCTATextStyle(
                            context,
                            16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                // Courses Section

                Text(
                  "Jobs for you",
                  style: getCTATextStyle(
                    context,
                    16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 210),
                  child: Obx(() {
                    if (jobsController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (jobsController.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          jobsController.errorMessage.value,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    if (jobsController.jobs.value == null ||
                        jobsController.jobs.value!.data == null ||
                        jobsController.jobs.value!.data!.jobs == null) {
                      return const Center(child: Text('No Jobs Available'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return getJobItem(
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
          );
        },
      ),
    );
  }

  Widget getJobItem(BuildContext context, JobsModel job) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        elevation: 3,
        color: scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      imageUrl: job.companyLogo,
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
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert_rounded,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: Text(
                  job.position,
                  maxLines: 2,
                  style: getCTATextStyle(
                    context,
                    16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${job.organization} · ${job.location}\n${job.type} · ${job.locationType}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getFormatedDateForJobs(job.deadline)),
                  Text(
                    getStyledSalaryRange(
                      job.salary,
                      job.salaryMax,
                      job.currency,
                      job.salaryTime,
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

  Widget getGoals(List<String>? goals) {
    return Wrap(
      children: goals?.map((e) {
            return getGoalItem(e);
          }).toList() ??
          [],
    );
  }

  Widget getGoalItem(String goal) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Text(
          goal,
          style: getCTATextStyle(
            context,
            14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
