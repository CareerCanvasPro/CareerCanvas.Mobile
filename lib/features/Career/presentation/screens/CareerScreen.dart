import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/CoursesController.dart';
import 'package:career_canvas/features/Career/presentation/getx/controller/JobsController.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
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
  late final CoursesController coursesController;
  late final UserProfileController userProfileController;

  @override
  void initState() {
    super.initState();
    jobsController = getIt<JobsController>();
    coursesController = getIt<CoursesController>();
    if (jobsController.jobs.value == null) {
      jobsController.getJobsRecomendation();
    }
    if (coursesController.courses.value == null) {
      coursesController.getCoursesRecomendation();
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
          '${currency} ${formatSalary(salary)} - ${formatSalary(salaryMax)}';
    } else {
      salaryRange = '${currency} ${formatSalary(salary)}';
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

  String formatSalary(num value) {
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
      body: SingleChildScrollView(
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
                          child: Image.network(
                            userProfileController
                                    .userProfile.value?.profilePicture ??
                                "https://ugv.edu.bd/images/teacher_images/1581406453.jpg",
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
                                userProfileController.userProfile.value?.name ??
                                    "",
                                style: getCTATextStyle(
                                  context,
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                userProfileController
                                        .userProfile.value?.aboutMe ??
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
                  onPressed: () {},
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
            Timeline.tileBuilder(
              shrinkWrap: true,
              semanticChildCount: userGoals.length,
              theme: TimelineThemeData(
                nodePosition: 0,
                connectorTheme: const ConnectorThemeData(
                  thickness: 3.0,
                  color: Color(0xffd3d3d3),
                ),
                indicatorTheme: const IndicatorThemeData(
                  size: 15.0,
                ),
              ),
              physics: const NeverScrollableScrollPhysics(),
              // padding: const EdgeInsets.symmetric(vertical: 20.0),
              builder: TimelineTileBuilder.connected(
                contentsBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(2.0),
                  //   color: const Color(0xffe6e7e9),
                  // ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          userGoals[index].title,
                          style: getCTATextStyle(
                            context,
                            14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        getFormatedDateForTimeline(
                          DateTime.fromMillisecondsSinceEpoch(
                              userGoals[index].date),
                        ),
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                connectorBuilder: (_, index, __) {
                  if (userGoals.length > index + 1 &&
                      userGoals[index + 1].date >
                          DateTime.now().millisecondsSinceEpoch) {
                    return const SolidLineConnector(color: primaryBlue);
                  } else if (userGoals[index].date >
                      DateTime.now().millisecondsSinceEpoch) {
                    return const DashedLineConnector(color: primaryBlue);
                  } else {
                    return const DashedLineConnector();
                  }
                },
                indicatorBuilder: (_, index) {
                  if (userGoals[index].date >
                      DateTime.now().millisecondsSinceEpoch) {
                    return const DotIndicator(
                      color: primaryBlue,
                      size: 24,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10.0,
                      ),
                    );
                  } else {
                    return const DotIndicator(
                      color: seconderyColor2,
                      size: 24,
                      // child: Icon(
                      //   Icons.check,
                      //   color: Colors.white,
                      //   size: 10.0,
                      // ),
                    );
                  }
                },
                itemExtentBuilder: (_, __) => 50,
                itemCount: userGoals.length,
              ),
            ),

            SizedBox(height: 20),
            // Courses Section
            Text(
              "Skills for you",
              style: getCTATextStyle(
                context,
                16,
                color: Colors.black,
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
                    coursesController.courses.value!.data!.courses == null) {
                  return const Center(child: Text('No Courses Available'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return getCourseItem(context,
                        coursesController.courses.value!.data!.courses![index]);
                  },
                  itemCount:
                      coursesController.courses.value!.data!.courses!.length,
                );
              }),
            ),
            SizedBox(height: 8),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(job.companyLogo),
                        fit: BoxFit.contain,
                      ),
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

  Widget getCourseItem(BuildContext context, CoursesModel course) {
    return Container(
      width: 300,
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
              width: 300,
              height: 130,
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                course.image,
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
                    "${course.level} · ${getFormatedDutaionForCourse(course.duration)} · ${course.sourceName}",
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
                      Icon(Icons.star, color: orangeStar, size: 18),
                      SizedBox(width: 4),
                      Text("${course.rating} (${course.ratingCount})",
                          style: getCTATextStyle(context, 12,
                              color: Colors.black)),
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
