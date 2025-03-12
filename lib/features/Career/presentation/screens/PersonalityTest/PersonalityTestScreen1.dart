import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PersonalityTestScreen1 extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen1";
  PersonalityTestScreen1({
    Key? key,
  }) : super(key: key);

  @override
  _PersonalityTestScreen1State createState() => _PersonalityTestScreen1State();
}

class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
  late final PersonalityTestController controller;
  late String token = '';
  int currentPage = 0; // Page tracking for pagination
  int questionsPerPage = 10; // Display 10 questions per page
  List<Map<String, dynamic>> selectedAnswers = []; // Store answers here

  @override
  void initState() {
    super.initState();
    // token = getIt<AuthService>().token ?? '';
    // print(token);
    controller = getIt<PersonalityTestController>();

    if (TokenInfo.token.isNotEmpty) {
      controller.loadPersonalityTest(TokenInfo.token);
    }
  }

//   void sendPersonalityTestResults() async {
//   final String? token = getIt<AuthService>().token;

//   if (token == null) {
//     print("Error: No token found.");
//     return;
//   }

//   final String apiUrl =
//       "https://personality.api.careercanvas.pro/personality-test/result";

//   try {
//     final Map<String, dynamic> requestBody = {
//       "result": selectedAnswers,
//     };

//     print(requestBody);

//     final response = await Dio().post(
//       apiUrl,
//       data: requestBody,
//       options: Options(
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//       ),
//     );

//     print("Response: ${response.data}");

//     // Check if API response indicates success
//     if (response.statusCode == 200 && response.data["message"] == "Result updated successfully") {
//       // Show a popup and then navigate
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Successfully Submitted"),
//             content: Text("Your response has been submitted successfully. The result will be added to your profile."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the popup
//                   Navigator.pushNamed(context, '/SuccessScreen'); // Navigate to success screen
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Handle unexpected response
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unexpected response: ${response.data['message']}"))
//       );
//     }
//   } on DioException catch (e) {
//     print("Error sending data: ${e.response?.data ?? e.message}");

//     // Show error message and navigate to failure screen
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error: ${e.response?.data['message'] ?? 'Something went wrong'}"))
//     );
//     Navigator.pushNamed(context, '/FailureScreen');
//   }
// }

  void sendPersonalityTestResults() async {
    final String apiUrl =
        "https://personality.api.careercanvas.pro/personality-test/result";

    try {
      final Map<String, dynamic> requestBody = {
        "result": selectedAnswers,
      };

      print(requestBody);

      final response = await Dio().post(
        apiUrl,
        data: requestBody,
        options: Options(
          headers: {
            "Authorization": "Bearer ${TokenInfo.token}",
            "Content-Type": "application/json",
          },
        ),
      );

      print("Response: ${response.data}");

      // Delay state updates until after the frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (response.statusCode == 200 &&
            response.data["message"] == "Result updated successfully") {
          CustomDialog.showCustomDialog(
            context,
            title: "Successfully Submitted",
            content:
                "Your response has been submitted successfully. The result will be added to your profile.",
            buttonText: "OK",
            onPressed: () {
              Navigator.pop(context); // Close the popup
              getIt<UserProfileController>().getUserProfile();
              Navigator.pushNamed(
                context,
                '/HomePage',
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Unexpected response: ${response.data['message']}")));
        }
      });
    } on DioException catch (e) {
      print("Error sending data: ${e.response?.data ?? e.message}");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Fluttertoast.showToast(
          msg:
              "Error: ${e.response?.data['message'] ?? 'Something went wrong'}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
        Navigator.pushNamed(context, '/HomePage');
      });
    }
  }

  void onAnswerSelected(String id, int selectedOption) {
    setState(() {
      Questions question = controller.personalityTest.value!.data!.questions!
          .firstWhere((q) => q.questionID == id);
      question.selectedOption = selectedOption;

      // Remove previous selection for this question if it exists
      selectedAnswers.removeWhere((answer) => answer['questionID'] == id);

      // Add the newly selected answer
      selectedAnswers.add({
        'questionID': question.questionID,
        'answer': selectedOption,
      });
    });
  }

  void onAnswerSelectedold(String id, int selectedOption) {
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
    sendPersonalityTestResults(); // Send data to API
  }

  double currentProgress = 0.167;

  void calculateProgress(
      int currentPage, int questionsPerPage, int totalQuestions) {
    int completedQuestions = (currentPage + 1) * questionsPerPage;
    double progress = (completedQuestions / totalQuestions)
        .clamp(0.0, 1.0); // Ensure it's within 0-1 range
    currentProgress = progress;
  }

  void onNextPage() {
    final totalQuestions =
        controller.personalityTest.value?.data?.questions ?? [];
    final startIndex = currentPage * questionsPerPage;
    final endIndex = (startIndex + questionsPerPage) > totalQuestions.length
        ? totalQuestions.length
        : startIndex + questionsPerPage;

    // Check if only the questions on the current page are answered
    bool allCurrentPageAnswered = totalQuestions
        .sublist(startIndex, endIndex)
        .every((q) => q.selectedOption != null);

    if (!allCurrentPageAnswered) {
      // Show popup if any question on the current page is unanswered
      CustomDialog.showCustomDialog(
        context,
        title: "Incomplete Page",
        content: "Please answer all questions on this page before proceeding.",
        buttonText: "OK",
        onPressed: () {
          Navigator.pop(context); // Close popup
        },
      );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Incomplete Page"),
      //       content: Text(
      //           "Please answer all questions on this page before proceeding."),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.pop(context); // Close popup
      //           },
      //           child: Text("OK"),
      //         ),
      //       ],
      //     );
      //   },
      // );
      return; // Stop further execution
    }

    // If more pages exist, go to next page
    if (currentPage < (totalQuestions.length / questionsPerPage).floor() - 1) {
      setState(() {
        currentPage++;
        calculateProgress(currentPage, questionsPerPage, totalQuestions.length);
      });
      scrollController.animateTo(
        scrollController.initialScrollOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      // If it's the last page, validate all questions before submission
      bool allAnswered = totalQuestions.every((q) => q.selectedOption != null);

      if (!allAnswered) {
        // Show popup if any question is unanswered
        CustomDialog.showCustomDialog(
          context,
          title: "Incomplete Page",
          content: "Please answer all questions to get your score.",
          buttonText: "OK",
          onPressed: () {
            Navigator.pop(context); // Close popup
          },
        );
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text("Incomplete Test"),
        //       content: Text("Please answer all questions to get your score."),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.pop(context); // Close popup
        //           },
        //           child: Text("OK"),
        //         ),
        //       ],
        //     );
        //   },
        // );
        return; // Stop further execution
      }

      // All questions answered, submit the results
      sendPersonalityTestResults();
    }
  }

  void onNextPageold() {
    setState(() {
      if (currentPage <
          (controller.personalityTest.value!.data!.questions!.length /
                      questionsPerPage)
                  .floor() -
              1) {
        currentPage++;
      } else {
        Navigator.pushNamed(context, '/HomePage', //'/AnalyzingResultsScreen',
            arguments: selectedAnswers);
      }
    });
  }

  void onCancel() {
    Navigator.pop(context);
  }

  ScrollController scrollController = ScrollController();

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

        // if (questionsToDisplay.length == 0) {
        //   return Center(
        //     child: Text(
        //       "You have answered all the questions. Please press the Submit button now to get result.",
        //       style: getCTATextStyle(
        //         context,
        //         16,
        //         color: Colors.black,
        //       ),
        //     ),
        //   );
        // }

        return Column(
          children: [
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                primaryBlue,
              ),
              value: currentProgress,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questionsToDisplay.length,
                controller: scrollController,
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
                          // const SizedBox(height: 8),
                          // Text(
                          //   'Category: ${question.category ?? 'N/A'}',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          const SizedBox(height: 16),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Agree"),
                          //     Text("Neutral"),
                          //     Text("Disagree"),
                          //   ],
                          // ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate the scale factor based on the available width
                              final screenWidth = constraints.maxWidth;
                              const totalRadioButtons = 7;
                              const spacingBetweenButtons =
                                  8.0; // Adjust spacing as needed
                              const padding = 16.0; // Adjust padding as needed

                              // Calculate the available width for each radio button
                              final availableWidthPerButton = (screenWidth -
                                      (totalRadioButtons - 1) *
                                          spacingBetweenButtons -
                                      2 * padding) /
                                  totalRadioButtons;

                              // Define a base size for the radio button (you can adjust this)
                              const baseRadioButtonSize = 24.0;

                              // Calculate the scale factor
                              final scale =
                                  availableWidthPerButton / baseRadioButtonSize;

                              return Column(
                                children: [
                                  // Texts above the radio buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Agree"),
                                      SizedBox(
                                          width: (screenWidth - 2 * padding) /
                                              3), // Spacing for "Neutral"
                                      Text("Neutral"),
                                      SizedBox(
                                          width:
                                              (screenWidth - 2 * padding) / 3 -
                                                  7), // Spacing for "Disagree"
                                      Text("Disagree"),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Space between texts and radio buttons
                                  // Radio buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children:
                                        List.generate(totalRadioButtons, (i) {
                                      final value = 3 - i;
                                      return Transform.scale(
                                        scale: scale,
                                        child: Radio(
                                          value: value,
                                          activeColor: primaryBlue,
                                          groupValue: question.selectedOption,
                                          onChanged: (val) {
                                            setState(() {
                                              onAnswerSelected(
                                                  question.questionID ?? '',
                                                  value);
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              );
                            },
                          )
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: List.generate(7, (i) {
                          //       final value = 3 - i;
                          //       return Transform.scale(
                          //         scale: 1.5,
                          //         child: Radio(
                          //           value: value,
                          //           activeColor: primaryBlue,
                          //           groupValue: question.selectedOption,
                          //           onChanged: (val) {
                          //             setState(() {
                          //               onAnswerSelected(
                          //                   question.questionID ?? '', value);
                          //             });
                          //           },
                          //         ),
                          //       );
                          //     }),
                          //   ),
                          // ),
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
                                    .floor() -
                                1
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
