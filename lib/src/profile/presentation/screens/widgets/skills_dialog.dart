import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkillAddDialog extends StatefulWidget {
  final List<String>? existingSkills;
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
      _skills.addAll(widget.existingSkills!);
    }
  }

  // Method to add a new skills field
  void _addSkilssField(String skill) {
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
  Widget _buildSkilssCard(int index) {
    return Card(
      elevation: 3,
      // margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_skills[index]),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _removeSkilssField(index),
              icon: Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Update Your Skills",
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 20),
        if (_skills.isNotEmpty)
          Wrap(
            children: _skills
                .map((e) => _buildSkilssCard(_skills.indexOf(e)))
                .toList(),
          ),
        if (_skills.isNotEmpty) SizedBox(height: 30),
        FieldSuggestion<String>(
          search: (item, input) {
            if (skillsController.text.isEmpty) return false;
            return item.toLowerCase().contains(input.toLowerCase());
          },
          inputDecoration: InputDecoration(
            hintText: 'Search Skills',
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
              child: Card(
                color: scaffoldBackgroundColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    skillsList[index],
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
                  widget.onSubmit(_skills);
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
