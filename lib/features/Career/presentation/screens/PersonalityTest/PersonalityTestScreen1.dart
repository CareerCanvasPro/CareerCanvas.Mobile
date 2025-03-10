// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
// import 'package:career_canvas/core/models/QuestionAnswer.dart';
// import 'package:career_canvas/core/models/TextQuestion.dart';
// import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
// import 'package:career_canvas/src/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PersonalityTestScreen1 extends StatefulWidget {
//   static const String routeName = "/PersonalityTestScreen1";

//   const PersonalityTestScreen1({Key? key}) : super(key: key);

//   @override
//   _PersonalityTestScreen1State createState() => _PersonalityTestScreen1State();
// }

// class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
//   // Example questions list
//   List<TestQuestion> questions = [];

//   int currentQuestionIndex = 0;

//   List<TestQuestion> currentQuestions = [];
//   late final PersonalityTestController controller;
//   late String token;

//   @override
//   void initState() {
//     super.initState();
//      token = Get.arguments['token'] ?? '';

//     // Use get_it to get the controller instance
//     controller = getIt<PersonalityTestController>();

//     if (token.isNotEmpty) {
//       controller.loadPersonalityTest(token); // Load personality test data when the screen is initialized
//     }
//     final q = dummyQuestions.map((ques) {
//       return TestQuestion.fromMap(ques);
//     }).toList();
//     questions.addAll(q);
//     setCurrentQuestions();
//   }

//   setCurrentQuestions() {
//     if (currentQuestionIndex < 1) {
//       currentQuestions = questions.sublist(0, 10);
//     } else {
//       currentQuestions = questions.sublist(
//         currentQuestionIndex * 10,
//         (currentQuestionIndex * 10) + 10,
//       );
//     }
//   }

//   void onAnswerSelected(String id, int selectedOption) {
//     setState(() {
//       questions.where((qu) => qu.questionID == id).toList().first.answer =
//           selectedOption;
//       currentQuestions
//           .where((qu) => qu.questionID == id)
//           .toList()
//           .first
//           .answer = selectedOption;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text('Personality Test'),
//         backgroundColor: scaffoldBackgroundColor,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//           ),
//           onPressed: () {
//             if (currentQuestionIndex > 0) {
//               setState(() {
//                 currentQuestionIndex--;
//                 setCurrentQuestions();
//               });
//             } else {
//               Navigator.pop(context); // Pops back to the previous screen
//             }
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           LinearProgressIndicator(
//             value: (currentQuestionIndex + 1) / (questions.length / 10).floor(),
//             backgroundColor: Colors.grey[300],
//             color: Colors.blue,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 16),
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin: const EdgeInsets.symmetric(horizontal: 24),
//                         elevation: 2,
//                         color: Colors.white,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                 currentQuestions[index].question,
//                                 style: getCTATextStyle(
//                                   context,
//                                   14,
//                                   color: Colors.black,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(
//                                 height: 16,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Agree",
//                                   ),
//                                   Text(
//                                     "Neutral",
//                                   ),
//                                   Text(
//                                     "Disagree",
//                                   ),
//                                 ],
//                               ),
//                               SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Transform.scale(
//                                       scale: 1.5,
//                                       child: Radio(
//                                         value: 3,
//                                         activeColor: Colors.green,
//                                         hoverColor: Colors.green,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               3,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Transform.scale(
//                                       scale: 1.3,
//                                       child: Radio(
//                                         value: 2,
//                                         activeColor: Colors.green,
//                                         hoverColor: Colors.green,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               2,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Transform.scale(
//                                       scale: 1.1,
//                                       child: Radio(
//                                         value: 1,
//                                         activeColor: Colors.green,
//                                         hoverColor: Colors.green,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               1,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Radio(
//                                       value: 0,
//                                       activeColor: Colors.grey,
//                                       hoverColor: Colors.grey,
//                                       groupValue: currentQuestions[index].answer,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           onAnswerSelected(
//                                             currentQuestions[index].questionID,
//                                             0,
//                                           );
//                                         });
//                                       },
//                                     ),
//                                     Transform.scale(
//                                       scale: 1.1,
//                                       child: Radio(
//                                         value: -1,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               -1,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Transform.scale(
//                                       scale: 1.3,
//                                       child: Radio(
//                                         value: -2,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               -2,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Transform.scale(
//                                       scale: 1.5,
//                                       child: Radio(
//                                         value: -3,
//                                         groupValue:
//                                             currentQuestions[index].answer,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             onAnswerSelected(
//                                               currentQuestions[index].questionID,
//                                               -3,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: 12,
//                       );
//                     },
//                     itemCount: currentQuestions.length,
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: currentQuestionIndex > 0
//                           ? MainAxisAlignment.spaceBetween
//                           : MainAxisAlignment.center,
//                       children: [
//                         if (currentQuestionIndex > 0)
//                           OutlinedButton(
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.blue,
//                               minimumSize: const Size(100, 50),
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentQuestionIndex--;
//                                 setCurrentQuestions();
//                               });
//                             },
//                             child: const Text('Back'),
//                           ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             backgroundColor: primaryBlue,
//                             minimumSize: const Size(100, 50),
//                           ),
//                           onPressed: () {
//                             if (currentQuestions
//                                 .where((qu) => qu.answer == null)
//                                 .toList()
//                                 .isNotEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     'Answer All the questions',
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               if (currentQuestionIndex <
//                                   (questions.length / 10).floor() - 1) {
//                                 setState(() {
//                                   currentQuestionIndex++;
//                                   setCurrentQuestions();
//                                 });
//                               } else {
//                                 Navigator.pushNamed(
//                                     context, '/AnalyzingResultsScreen');
//                               }
//                             }
//                           },
//                           child: Text(
//                             currentQuestionIndex < questions.length - 1
//                                 ? 'Next'
//                                 : 'Submit',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/features/AuthService.dart';
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalityTestScreen1 extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen1";
  PersonalityTestScreen1({
    Key? key,
  }) : super(key: key);

  @override
  _PersonalityTestScreen1State createState() => _PersonalityTestScreen1State();
}

// class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
//   late final PersonalityTestController controller;
//  late String token='';
// // final prefs = await SharedPreferences.getInstance();
// //     String token = prefs.getString('token') ?? '';
//   @override
//   void initState() {
//     super.initState();
//  token= getIt<AuthService>().token??'';
//  print(token);
//     controller = getIt<PersonalityTestController>();

//     if (token.isNotEmpty) {
//       controller.loadPersonalityTest(token);
//     }
//   }

//   void onAnswerSelected(String id, int selectedOption) {
//     setState(() {
//       Questions question = controller.personalityTest.value!.data!.questions!.firstWhere((q) => q.questionID == id);
//       question.selectedOption = selectedOption;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text('Personality Test'),
//         backgroundColor: scaffoldBackgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.errorMessage.isNotEmpty) {
//           return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red)));
//         }
//         if (controller.personalityTest.value == null || controller.personalityTest.value!.data == null) {
//           return const Center(child: Text('No questions available'));
//         }

//         final questions = controller.personalityTest.value!.data!.questions!;

//         return ListView.builder(
//           itemCount: questions.length,
//           itemBuilder: (context, index) {
//             final question = questions[index];
//             return Card(
//               margin: const EdgeInsets.all(8),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(question.question??'', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Text('Category: ${question.category ?? 'N/A'}', style: TextStyle(fontSize: 14, color: Colors.grey)),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Agree"),
//                         Text("Neutral"),
//                         Text("Disagree"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(7, (i) {
//                         final value = 3 - i;
//                         return Transform.scale(
//                           scale: 1.2,
//                           child: Radio(
//                             value: value,
//                             groupValue: question.selectedOption,
//                             onChanged: (val) {
//                               setState(() {
//                                 onAnswerSelected(question.questionID??'', value);
//                               });
//                             },
//                           ),
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
  late final PersonalityTestController controller;
  late String token = '';
  int currentPage = 0; // Page tracking for pagination
  int questionsPerPage = 10; // Display 10 questions per page
  List<Map<String, dynamic>> selectedAnswers = []; // Store answers here

  @override
  void initState() {
    super.initState();
    token = getIt<AuthService>().token ?? '';
    print(token);
    controller = getIt<PersonalityTestController>();

    if (token.isNotEmpty) {
      controller.loadPersonalityTest(token);
    }
  }

  void sendPersonalityTestResults() async {
    final String? token = getIt<AuthService>().token; // Get stored token

    if (token == null) {
      print("Error: No token found.");
      return;
    }

    final String apiUrl =
        "https://personality.api.careercanvas.pro/personality-test/result";

    try {
      print({"result": selectedAnswers});
      final response = await Dio().put(
        apiUrl,
        data: {"result": selectedAnswers},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      print("Response: ${response.data}");
    } on DioException catch (e) {
      print("Error sending data: ${e.response?.data ?? e.message}");
    }
  }

  void onAnswerSelected(String id, int selectedOption) {
    setState(() {
      Questions question = controller.personalityTest.value!.data!.questions!
          .firstWhere((q) => q.questionID == id);
      question.selectedOption = selectedOption;

      // Store the selected answer
      selectedAnswers.add({
        'questionID': question.questionID,
        'answer': selectedOption,
      });
    });
    print(selectedAnswers);
    sendPersonalityTestResults(); // Send data to API
  }

  void onNextPage() {
    setState(() {
      if (currentPage <
          (controller.personalityTest.value!.data!.questions!.length /
                  questionsPerPage)
              .floor()) {
        currentPage++;
      } else {
        Navigator.pushNamed(context, '/AnalyzingResultsScreen',
            arguments: selectedAnswers);
      }
    });
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Personality Test'),
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: onCancel,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(
              child: Text(controller.errorMessage.value,
                  style: TextStyle(color: Colors.red)));
        }
        if (controller.personalityTest.value == null ||
            controller.personalityTest.value!.data == null) {
          return const Center(child: Text('No questions available'));
        }

        final questions = controller.personalityTest.value!.data!.questions!;
        final startIndex = currentPage * questionsPerPage;
        final endIndex = (startIndex + questionsPerPage) > questions.length
            ? questions.length
            : startIndex + questionsPerPage;
        final questionsToDisplay = questions.sublist(startIndex, endIndex);

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questionsToDisplay.length,
                itemBuilder: (context, index) {
                  final question = questionsToDisplay[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),
                    color: scaffoldBackgroundColor,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Category: ${question.category ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Agree"),
                              Text("Neutral"),
                              Text("Disagree"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(7, (i) {
                              final value = 3 - i;
                              return Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: value,
                                  activeColor: primaryBlue,
                                  groupValue: question.selectedOption,
                                  onChanged: (val) {
                                    setState(() {
                                      onAnswerSelected(
                                          question.questionID ?? '', value);
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlinedButton(
                    onPressed: onCancel,
                    title: "Cancel",
                  ),
                  CustomTextButton(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    onPressed: onNextPage,
                    textStyle: getCTATextStyle(context, 16),
                    title: currentPage <
                            (controller.personalityTest.value!.data!.questions!
                                        .length /
                                    questionsPerPage)
                                .floor()
                        ? "Next"
                        : "Submit",
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
