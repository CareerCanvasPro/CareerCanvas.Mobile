import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGoals extends StatefulWidget {
  final Function(List<String>) onSubmit;
  final List<String>? existingGoals;
  const AddGoals({
    super.key,
    required this.onSubmit,
    this.existingGoals,
  });

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  List<String> _goals = [];
  final TextEditingController goalsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.existingGoals != null && widget.existingGoals!.isNotEmpty) {
      _goals.addAll(widget.existingGoals!);
    }
  }

  // Method to add a new skills field
  void _addGoal(String goal) {
    if (_goals.contains(goal)) {
      return;
    }
    setState(() {
      _goals.add(goal);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(String index) {
    if (_goals.isNotEmpty) {
      setState(() {
        _goals.removeWhere((element) => element == index);
      });
    }
  }

  List<String> goalsList = [
    "Delegate More Effectively",
    "Become a Better Listener",
    "Organize Team-Building Activities",
    "Provide Constructive Feedback Regularly",
    "Improve Team Communication",
    "Take a Non-Tech Course",
    "Travel to a New Place",
    "Learn a New Language",
    "Try a New Hobby",
    "Start a Journaling Habit",
    "Develop a Morning Routine",
    "Build a Strong Professional Network",
    "Enhance Public Speaking Skills",
    "Read a Business or Self-Development Book",
    "Improve Time Management",
    "Develop a Side Project",
    "Master a Project Management Tool",
    "Speak at a Tech Conference",
    "Write Technical Blog Posts",
    "Mentor a Junior Developer",
    "Implement Zero Trust Security",
    "Set Up a Honeypot",
    "Get a Cybersecurity Certification",
    "Perform a Security Audit",
    "Improve Security Practices",
    "Build a Personal Data Dashboard",
    "Implement an AI Chatbot",
    "Work with Big Data",
    "Learn SQL and NoSQL Databases",
    "Train and Deploy a Machine Learning Model",
    "Automate a Repetitive Task",
    "Contribute to Open Source",
    "Improve Code Quality",
    "Master a New Programming Language",
    "Build and Deploy a Full-Stack App",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Add Goals",
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 20),
        if (_goals.isNotEmpty)
          Column(
            children: _goals.map((e) {
              return Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis,
                          style: getCTATextStyle(
                            context,
                            14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _removeSkilssField(e),
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        if (_goals.isNotEmpty) SizedBox(height: 30),
        FieldSuggestion<String>(
          search: (item, input) {
            if (goalsController.text.isEmpty) return false;
            return item.toLowerCase().contains(input.toLowerCase());
          },
          inputDecoration: InputDecoration(
            hintText: 'Search Goals',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
          boxStyle: BoxStyle(
            backgroundColor: scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          inputType: TextInputType.text,
          suggestions: goalsList,
          textController: goalsController,
          // boxController: boxController, // optional
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(
                  () => _addGoal(
                    goalsList[index],
                  ),
                );
                goalsController.clear();
              },
              child: Card(
                color: scaffoldBackgroundColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          goalsList[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Submit",
                onPressed: () async {
                  Get.back();
                  widget.onSubmit(_goals);
                },
                backgroundColor: primaryBlue,
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Cancel",
                onPressed: () => Get.back(),
                backgroundColor: primaryBlue.withOpacity(0.8),
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
