import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  SkillsScreen({super.key});

  final List<Map<String, dynamic>> courses = [
    {
      "title": "Advanced Front-End Programming Techniques",
      "author": "Julia Anatole",
      "duration": "1 hr",
      "rating": 4.5,
      "reviews": 2980,
      "image": ImageAssets.skills1,
    },
    {
      "title": "Ultimate Cybersecurity Fundamental for Beginners",
      "author": "Jacob Jones",
      "duration": "3:30 hr",
      "rating": 4.5,
      "reviews": 2980,
      "image": ImageAssets.skills2,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills"),
        leading: const Icon(Icons.flash_on),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Skill up yourself"),
              courseList(),
              sectionTitle("Based on your skill goal"),
              courseList(),
              sectionTitle("Trending Skills"),
              courseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "See all",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget courseList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return courseCard(course);
        },
      ),
    );
  }

  Widget courseCard(Map<String, dynamic> course) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              course["image"],
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course["title"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${course["author"]} • ${course["duration"]}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(" ${course["rating"]} (${course["reviews"]})")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
