import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestAddDialog extends StatefulWidget {
  final List<KeyVal>? existingInterests;
  final Function(List<String>) onSubmit;
  const InterestAddDialog({
    super.key,
    this.existingInterests,
    required this.onSubmit,
  });

  @override
  State<InterestAddDialog> createState() => _InterestAddDialogState();
}

class _InterestAddDialogState extends State<InterestAddDialog> {
  List<String> _interests = [];
  final TextEditingController interestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingInterests != null &&
        widget.existingInterests!.isNotEmpty) {
      _interests.addAll(widget.existingInterests!.map((e) => e.name).toList());
    }
  }

  // Method to add a new skills field
  void _addLanguageField(String interest) {
    if (_interests.contains(interest)) {
      return;
    }
    setState(() {
      _interests.add(interest);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(int index) {
    if (_interests.isNotEmpty && index < _interests.length) {
      setState(() {
        _interests.removeAt(index);
      });
    }
  }

  List<String> interestList = [
    // Core Technical Roles
    "Software Engineer",
    "Frontend Developer",
    "Backend Developer",
    "Full Stack Developer",
    "Mobile Developer",
    "Android Developer",
    "iOS Developer",
    "Web Developer",
    "Data Scientist",
    "Machine Learning Engineer",
    "Artificial Intelligence Engineer",
    "DevOps Engineer",
    "Site Reliability Engineer",
    "Cloud Engineer",
    "Cloud Architect",
    "Data Engineer",
    "Security Engineer",
    "Cybersecurity Analyst",
    "Blockchain Developer",
    "Game Developer",
    "Embedded Systems Engineer",
    "IoT Engineer",
    "AR Developer",
    "VR Developer",
    "Software Architect",
    "Test Engineer",
    "QA Engineer",
    "Automation Engineer",
    "System Administrator",
    "Database Administrator",

    // Specialized & Hybrid Roles
    "AI Engineer",
    "NLP Engineer",
    "Computer Vision Engineer",
    "Infrastructure Engineer",
    "Platform Engineer",
    "Product Engineer",
    "Tools Engineer",
    "Performance Engineer",
    "Firmware Engineer",
    "Solutions Architect",
    "Technical Program Manager",

    // Leadership and Strategy Roles
    "Engineering Manager",
    "Technical Lead",
    "Tech Lead",
    "Team Lead",
    "CTO",
    "VP of Engineering",
    "Chief Architect",

    // Adjacent Technical Roles
    "Product Manager",
    "Technical Product Manager",
    "UX Engineer",
    "UI Engineer",
    "Technical Writer",
    "Developer Advocate",
    "Developer Evangelist",
    "Security Analyst",
    "Penetration Tester",
    "Ethical Hacker",

    // Career/Work Modes
    "Remote Developer",
    "Freelance Developer",
    "Open Source Contributor",
    "Startup Engineer",
    "Technical Consultant"
  ];
  List<String> searchLanguage(String input) {
    return interestList
        .where((element) => element.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }

  // Skills will be in a chieps style design with a x button to remove the skill
  Widget _buildSkilssCard(
    int index, {
    bool isSuggested = false,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSuggested
            ? _addLanguageField(interestList[index])
            : _removeSkilssField(index);
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
              isSuggested ? interestList[index] : _interests[index],
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
                        "Interests",
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
                  "Update your interests",
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
                            if (interestController.text.isEmpty) return false;
                            return item
                                .toLowerCase()
                                .contains(input.toLowerCase());
                          },
                          inputDecoration: InputDecoration(
                            hintText: 'Interese (ex: Startup)',
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
                          suggestions: interestList,
                          textController: interestController,
                          // boxController: boxController, // optional
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () => _addLanguageField(
                                    interestList[index],
                                  ),
                                );
                                interestController.clear();
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
                                      interestList[index],
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
                if (_interests.isNotEmpty)
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
                                "Your Interests",
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
                                children: _interests
                                    .map((e) =>
                                        _buildSkilssCard(_interests.indexOf(e)))
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
                              "Suggested Interests",
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
                              children: interestList
                                          .where((skill) =>
                                              _interests.isEmpty ||
                                              !_interests.contains(skill))
                                          .length >
                                      5
                                  ? interestList
                                      .where((skill) =>
                                          _interests.isEmpty ||
                                          !_interests.contains(skill))
                                      .take(5)
                                      .toList()
                                      .map(
                                        (e) => _buildSkilssCard(
                                          interestList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList()
                                  : interestList
                                      .where((skill) =>
                                          _interests.isEmpty ||
                                          !_interests.contains(skill))
                                      .map(
                                        (e) => _buildSkilssCard(
                                          interestList.indexOf(e),
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
                          widget.onSubmit(_interests);
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
