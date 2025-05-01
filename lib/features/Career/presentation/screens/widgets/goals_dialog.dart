import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGoals extends StatefulWidget {
  final Function(List<String>) onSubmit;
  final List<KeyVal>? existingGoals;
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
      _goals.addAll(widget.existingGoals!.map((e) => e.name).toList());
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

  Widget _buildGoalsCard(
    int index, {
    bool isSuggested = false,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSuggested
            ? _addGoal(goalsList[index])
            : _removeSkilssField(_goals[index]);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 50,
        ),
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSuggested ? Colors.black : primaryBlue,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isSuggested ? goalsList[index] : _goals[index],
              style: getCTATextStyle(
                context,
                12,
                color: isSuggested ? Colors.black : primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryBlue,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Goals",
                        style: getCTATextStyle(
                          context,
                          16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Update your goals",
                  textAlign: TextAlign.left,
                  style: getCTATextStyle(
                    context,
                    12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: FieldSuggestion<String>(
                          search: (item, input) {
                            if (goalsController.text.isEmpty) return false;
                            return item
                                .toLowerCase()
                                .contains(input.toLowerCase());
                          },
                          inputDecoration: InputDecoration(
                            hintText: 'Goals (ex: Delegate More Effectively)',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFfb0102),
                              ),
                            ),
                            errorMaxLines: 1,
                            // errorText: '',
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
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
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 50,
                                ),
                                decoration: BoxDecoration(
                                  color: scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      goalsList[index],
                                      style: getCTATextStyle(
                                        context,
                                        12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (_goals.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Goals",
                                style: getCTATextStyle(
                                  context,
                                  14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _goals
                                    .map((e) =>
                                        _buildGoalsCard(_goals.indexOf(e)))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suggested Goals",
                              style: getCTATextStyle(
                                context,
                                14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: goalsList
                                          .where((skill) =>
                                              _goals.isEmpty ||
                                              !_goals.contains(skill))
                                          .length >
                                      5
                                  ? goalsList
                                      .where((skill) =>
                                          _goals.isEmpty ||
                                          !_goals.contains(skill))
                                      .take(5)
                                      .toList()
                                      .map(
                                        (e) => _buildGoalsCard(
                                          goalsList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList()
                                  : goalsList
                                      .where((skill) =>
                                          _goals.isEmpty ||
                                          !_goals.contains(skill))
                                      .map(
                                        (e) => _buildGoalsCard(
                                          goalsList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
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
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        title: "Cancel",
                        onPressed: () => Get.back(),
                        color: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
