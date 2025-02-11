import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});

  static const String routeName = "/careerScreen";

  final JobService jobService = JobService();
  final List<UserGoal> userGoals = [
    UserGoal(
      title: 'Complete Bachelor\'s Degree',
      description: 'Bachelor\'s Degree, Career Canvas',
      date: DateTime.now().add(Duration(days: 10)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Internship',
      description: 'Internship, Career Canvas',
      date: DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Start MBA',
      description: 'MBA, Career Canvas',
      date: DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch,
    ),
    UserGoal(
      title: 'Become a Manager',
      description: 'MBA, Career Canvas',
      date: DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch,
    ),
  ];

  String getFormatedDateForTimeline(DateTime date) {
    return DateFormat().add_MMM().add_y().format(date);
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
                            context, PersonalityTestScreen.routeName);
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
                                "Tanvir Ahmed Khan",
                                style: getCTATextStyle(
                                  context,
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "MBTI Personality",
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
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getCourseItem(context);
                },
                itemCount: 5,
              ),
            ),

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
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getJobItem(context);
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getJobItem(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://www.trustedreviews.com/wp-content/uploads/sites/54/2023/04/Twitter-Blue-1024x1024.jpg"),
                        fit: BoxFit.cover,
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
              Text(
                "UX Researcher Internship",
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Twitter inc . California, USA or Remote",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("25 min ago"), Text("\$200/Mo")],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCourseItem(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            width: 200,
            height: 200 / 16 * 9,
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              "https://framerusercontent.com/images/9iXGUxA0mIK2tK87G5HWiidiI.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Advanced Front-End Programming Techniques",
            style: getCTATextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          Text(
            "Julia Anatole · 1 hr 20 mins",
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
              Text("4.5 (2,980)",
                  style: getCTATextStyle(context, 12, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}

// JobCard Widget
class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, size: 40),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.role,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('${job.company} • ${job.location}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: job.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.grey[200],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('25 minutes ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(job.salary,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
