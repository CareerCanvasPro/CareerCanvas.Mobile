import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkillAddDialog extends StatefulWidget {
  final List<KeyVal>? existingSkills;
  final Function(List<String>) onSubmit;
  const SkillAddDialog({
    super.key,
    this.existingSkills,
    required this.onSubmit,
  });

  @override
  State<SkillAddDialog> createState() => _SkillAddDialogState();
}

class _SkillAddDialogState extends State<SkillAddDialog> {
  List<String> _skills = [];
  final TextEditingController skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingSkills != null && widget.existingSkills!.isNotEmpty) {
      _skills.addAll(widget.existingSkills!.map((e) => e.name).toList());
    }
  }

  // Method to add a new skills field
  void _addSkilssField(String skill) {
    if (_skills.contains(skill)) {
      return;
    }
    setState(() {
      _skills.add(skill);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(int index) {
    if (_skills.isNotEmpty && index < _skills.length) {
      setState(() {
        _skills.removeAt(index);
      });
    }
  }

  List<String> skillsList = [
    // Existing skills
    'Flutter',
    'App Development',
    'Web Development',
    'UI/UX',
    'AI',

    // Technical Skills
    // Frontend Development
    'React/React Native',
    'JavaScript/TypeScript',
    'HTML5/CSS3',
    'Redux/State Management',
    'Mobile UI/UX',

    // Backend Development
    'Node.js/Express',
    'RESTful APIs',
    'GraphQL',
    'Microservices',
    'AWS Services',

    // Database
    'MongoDB',
    'PostgreSQL',
    'Redis',
    'Database Design',
    'Query Optimization',

    // DevOps
    'Docker',
    'Kubernetes',
    'CI/CD',
    'AWS Infrastructure',
    'Linux Systems',

    // Testing
    'Jest',
    'React Testing Library',
    'Integration Testing',
    'E2E Testing',
    'Performance Testing',

    // Soft Skills
    // Leadership
    'Team Management',
    'Decision Making',
    'Strategic Planning',
    'Mentoring',
    'Conflict Resolution',

    // Communication
    'Technical Writing',
    'Presentation Skills',
    'Client Communication',
    'Team Collaboration',
    'Documentation',

    // Project Management
    'Agile Methodologies',
    'Sprint Planning',
    'Risk Management',
    'Resource Allocation',
    'Stakeholder Management',

    // Problem Solving
    'Analytical Thinking',
    'Debugging',
    'System Design',
    'Performance Optimization',
    'Root Cause Analysis',

    // Personal Development
    'Continuous Learning',
    'Time Management',
    'Adaptability',
    'Work Ethics',
    'Innovation',
  ];
  List<String> searchSkills(String input) {
    return skillsList
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
            ? _addSkilssField(skillsList[index])
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
              isSuggested ? skillsList[index] : _skills[index],
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
                        "Skills",
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
                  "Update your skills",
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: FieldSuggestion<String>(
                          search: (item, input) {
                            if (skillsController.text.isEmpty) return false;
                            return item
                                .toLowerCase()
                                .contains(input.toLowerCase());
                          },
                          inputDecoration: InputDecoration(
                            hintText: 'Skill (ex: UI/UX Design)',
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
                          suggestions: skillsList,
                          textController: skillsController,
                          // boxController: boxController, // optional
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () => _addSkilssField(
                                    skillsList[index],
                                  ),
                                );
                                skillsController.clear();
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
                                      skillsList[index],
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
                if (_skills.isNotEmpty)
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
                                "Your Skills",
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
                                children: _skills
                                    .map((e) =>
                                        _buildSkilssCard(_skills.indexOf(e)))
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
                              "Suggested Skills",
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
                              children: skillsList
                                          .where((skill) =>
                                              _skills.isEmpty ||
                                              !_skills.contains(skill))
                                          .length >
                                      5
                                  ? skillsList
                                      .where((skill) =>
                                          _skills.isEmpty ||
                                          !_skills.contains(skill))
                                      .take(5)
                                      .toList()
                                      .map(
                                        (e) => _buildSkilssCard(
                                          skillsList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList()
                                  : skillsList
                                      .where((skill) =>
                                          _skills.isEmpty ||
                                          !_skills.contains(skill))
                                      .map(
                                        (e) => _buildSkilssCard(
                                          skillsList.indexOf(e),
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
                          widget.onSubmit(_skills);
                        },
                        backgroundColor: primaryBlue,
                        textStyle:
                            getCTATextStyle(context, 14, color: Colors.white),
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
