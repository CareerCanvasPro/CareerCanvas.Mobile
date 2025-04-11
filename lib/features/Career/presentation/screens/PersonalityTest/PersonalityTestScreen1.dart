import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/AnalyzingResultsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/EntjDetailsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/PersonalityTestScreen.dart';
import 'package:flutter/material.dart';

// class Question {
//   final String? questionID;
//   final String? question;
//   int? selectedOption;

//   Question({
//     required this.questionID,
//     required this.question,
//     this.selectedOption,
//   });
// }
// import 'package:flutter/material.dart';

class PersonalityTestScreen1 extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen1";

  @override
  State<PersonalityTestScreen1> createState() => _PersonalityTestScreen1State();
}

class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
  int? selectedOption1 = 2;
  int? selectedOption2 = 2;

  final Color primaryColor = const Color(0xFF0057FF);

  final List<String> question1Options = [
    "Building practical solutions",
    "Understanding how things work",
    "Exploring creative applications",
    "Using it to help others",
  ];

  final List<String> question2Options = [
    "Problem-solving and critical thinking",
    "Artistic or design-based creativity",
    "Communication and teamwork",
    "Data analysis and logical reasoning",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Personality Test",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "2 of 5",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Bar
                    LinearProgressIndicator(
                      value: 0.4,
                      color: primaryColor,
                      backgroundColor: Colors.grey[300],
                      minHeight: 6,
                    ),
                    const SizedBox(height: 24),

                    // Question 1
                    const Text(
                      "What excites you most about learning new technology?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(question1Options.length, (index) {
                      return RadioListTile<int>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(question1Options[index]),
                        value: index,
                        groupValue: selectedOption1,
                        onChanged: (val) {
                          setState(() {
                            selectedOption1 = val;
                          });
                        },
                        activeColor: primaryColor,
                      );
                    }),

                    const SizedBox(height: 24),

                    // Question 2
                    const Text(
                      "Which skill do you enjoy developing the most?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(question2Options.length, (index) {
                      return RadioListTile<int>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(question2Options[index]),
                        value: index,
                        groupValue: selectedOption2,
                        onChanged: (val) {
                          setState(() {
                            selectedOption2 = val;
                          });
                        },
                        activeColor: primaryColor,
                      );
                    }),

                    const SizedBox(height: 80), // Space above buttons
                  ],
                ),
              ),
            ),

            // Fixed Bottom Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () { Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PersonalityTestScreen(),
                          ),
                        );},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Back",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () { 
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EntjDetailsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
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
