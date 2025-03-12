// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:career_canvas/core/models/personalityInfo.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PersonalityDetails extends StatefulWidget {
  final CategoryColors categoryColors;
  final PersonalityType personalityType;
  final PersonalityTestResult personalityTestResult;
  final String type;

  const PersonalityDetails({
    Key? key,
    required this.categoryColors,
    required this.personalityType,
    required this.personalityTestResult,
    required this.type,
  }) : super(key: key);

  @override
  State<PersonalityDetails> createState() => _PersonalityDetailsState();
}

class _PersonalityDetailsState extends State<PersonalityDetails> {
  Color greyColor = Color(0xff787f8d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.categoryColors.background,
      appBar: AppBar(
        backgroundColor: widget.categoryColors.background,
        title: Text(
          "${widget.type} Details",
          style: getCTATextStyle(
            context,
            16,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.personalityType.name} (${widget.personalityType.category})",
                      textAlign: TextAlign.center,
                      style: getCTATextStyle(
                        context,
                        24,
                        color: widget.categoryColors.foreground,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.personalityType.description}",
                      textAlign: TextAlign.center,
                      style: getCTATextStyle(
                        context,
                        16,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      leading: SizedBox(width: 68, child: Text("Introvert")),
                      trailing: SizedBox(width: 60, child: Text("Extrovert")),
                      lineHeight: 16,
                      animation: true,
                      percent: widget.personalityTestResult.EI,
                      backgroundColor: Colors.white,
                      progressColor: widget.categoryColors.foreground,
                      barRadius: Radius.circular(10),
                      center: Text(
                        "${(widget.personalityTestResult.EI * 100).ceil()}%",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      leading: SizedBox(width: 68, child: Text("Perceiving")),
                      trailing: SizedBox(width: 60, child: Text("Judging")),
                      lineHeight: 16,
                      animation: true,
                      percent: widget.personalityTestResult.JP,
                      backgroundColor: Colors.white,
                      progressColor: widget.categoryColors.foreground,
                      barRadius: Radius.circular(10),
                      center: Text(
                        "${(widget.personalityTestResult.JP * 100).ceil()}%",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      leading: SizedBox(width: 68, child: Text("Intuition")),
                      trailing: SizedBox(width: 60, child: Text("Sensing")),
                      lineHeight: 16,
                      animation: true,
                      percent: widget.personalityTestResult.SN,
                      backgroundColor: Colors.white,
                      progressColor: widget.categoryColors.foreground,
                      barRadius: Radius.circular(10),
                      center: Text(
                        "${(widget.personalityTestResult.SN * 100).ceil()}%",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      leading: SizedBox(width: 68, child: Text("Feeling")),
                      trailing: SizedBox(width: 60, child: Text("Thinking")),
                      lineHeight: 16,
                      animation: true,
                      percent: widget.personalityTestResult.TF,
                      backgroundColor: Colors.white,
                      progressColor: widget.categoryColors.foreground,
                      barRadius: Radius.circular(10),
                      center: Text(
                        "${(widget.personalityTestResult.TF * 100).ceil()}%",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Ideal Career",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.personalityType.idealCareers.map((e) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Text(
                      e,
                      style: getCTATextStyle(
                        context,
                        14,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Work Environment",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.personalityType.workEnvironment.map((e) {
                  return Text(
                    e,
                    style: getCTATextStyle(
                      context,
                      14,
                      color: greyColor,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Strengths",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.personalityType.strengths.map((e) {
                  return Text(
                    e,
                    style: getCTATextStyle(
                      context,
                      14,
                      color: greyColor,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Recommended Roles",
                textAlign: TextAlign.center,
                style: getCTATextStyle(
                  context,
                  16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.personalityType.recommendedRoles.map((e) {
                  return GestureDetector(
                    onTap: () {
                      // TODO: Open the job recommendation screen
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Text(
                        e,
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
