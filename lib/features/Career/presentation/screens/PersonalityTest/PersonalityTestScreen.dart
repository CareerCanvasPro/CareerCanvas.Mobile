import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/AuthService.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/AnalyzingResultsScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/PersonalityTest/ScoreScreen.dart';
import 'package:career_canvas/features/Career/presentation/screens/widgets/AnalyticsItem.dart';
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int relevantSkills;
  final int totalSkills;

  const ScoreScreen({
    Key? key,
    required this.score,
    required this.relevantSkills,
    required this.totalSkills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Great Work!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Image.asset(ImageAssets.success),
            const SizedBox(height: 24),
            const Text(
              "Your Personalized Career Match",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              "$relevantSkills/$totalSkills Relevant Skills Aligned",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "$score% Match Recommended Careers",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                // Handle career recommendations logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Redirecting to recommendations...')),
                );
                Navigator.pushNamed(context, '/JobRecommendationScreen');
              },
              child: const Text(
                "Career Recommendation",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalityTestScreen extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen";
  PersonalityTestScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PersonalityTestScreenState createState() => _PersonalityTestScreenState();
}

class _PersonalityTestScreenState extends State<PersonalityTestScreen> {
  late final PersonalityTestController controller;
  late String token = '';
  int currentPage = 0; // Page tracking for pagination
  int questionsPerPage = 10; // Display 10 questions per page
  List<Map<String, dynamic>> selectedAnswers = []; // Store answers here

  // @override
  // void initState()  {
  //   super.initState();
  //   token = getIt<AuthService>().token ?? '';
  //   // print(token);
  //   controller =  getIt<PersonalityTestController>();

  //   if (token.isNotEmpty) {
  //      controller.loadPersonalityTest(TokenInfo.token);
  //   }
  // }
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    token = getIt<AuthService>().token ?? '';
    controller = getIt<PersonalityTestController>();

    if (token.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Safe to update state here
        await controller.loadPersonalityTest(TokenInfo.token);
      });
    }
  }

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
        //onNextPages();
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

  Future<void> onNextPages() async {
    await Future.delayed(const Duration(seconds: 3));

    final selectedAnswers = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>;

    // Calculate score based on selectedAnswers
    int totalScore = 0;
    int relevantSkills = 0;

    for (var answer in selectedAnswers) {
      // Handle null by using ?? 0 to default to 0 if null
      int selectedOption = (answer['selectedOption'] as int?) ?? 0;

      totalScore += selectedOption;

      // Ensure logic correctly handles positive, negative, and zero values
      if (selectedOption > 0) {
        relevantSkills++; // Count only positive responses
      }
    }

    // Calculate percentage score (clamping between 0.0 and 100.0)
    double scorePercentage = (totalScore / (selectedAnswers.length * 7)) * 100;
    scorePercentage = scorePercentage.clamp(
        0.0, 100.0); // Ensure it stays between 0.0 and 100.0

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          score: scorePercentage.toInt(),
          relevantSkills: relevantSkills,
          totalSkills: selectedAnswers.length,
        ),
      ),
    );
  }

  Future<void> onNextPage() async {
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

      return; // Stop further execution
    }

    // If more pages exist, go to next page
    if (currentPage < (totalQuestions.length / questionsPerPage).floor() - 1) {
      setState(() {
        currentPage++;
        calculateProgress(currentPage, questionsPerPage, totalQuestions.length);
      });
      await scrollController.animateTo(
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

        return; // Stop further execution
      }

      // All questions answered, submit the results
      sendPersonalityTestResults();
    }
  }

  void onNextPageoldOld() {
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
        print(questions);
        final startIndex = currentPage * questionsPerPage;
        final endIndex = (startIndex + questionsPerPage) > questions.length
            ? questions.length
            : startIndex + questionsPerPage;
        final questionsToDisplay = questions.sublist(startIndex, endIndex);
// Update the completed page count
        int completedPages =
            currentPage + 1; // This will show current page as completed
        double totalPages = questions.length / 10; // Total number of pages

        return Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 6.0),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Linear progress indicator with completed/total info
                        Row(
                          children: [
                            Expanded(
                              child: LinearPercentIndicator(
                                lineHeight: 10,
                                animation: true,
                                percent: completedPages / totalPages,
                                backgroundColor: Colors.grey.shade300,
                                progressColor: primaryBlue,
                                barRadius: Radius.circular(10),
                                animateFromLastPercent: true,
                              ),
                            ),
                            Text(
                              '$completedPages of ${totalPages.toInt()}', // Completed / Total pages
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // A more neutral color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questionsToDisplay.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  // Calculate the global question number based on the start index
                  final globalQuestionNumber =
                      startIndex + index + 1; // +1 because index is 0-based

                  final question = questionsToDisplay[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    color: scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$globalQuestionNumber. ${question.question ?? ''}", // Show the global question number
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth =
                                  constraints.maxWidth - (2 * 18);
                              const totalRadioButtons = 7;
                              final availableWidthPerButton =
                                  screenWidth / totalRadioButtons;
                              const maxScale = 1.3;

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Agree",
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Neutral",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Disagree",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:
                                        List.generate(totalRadioButtons, (i) {
                                      final value = 3 - i;
                                      final scaleFactor =
                                          maxScale - ((3 - value.abs()) * 0.2);
                                      return SizedBox(
                                        width: availableWidthPerButton,
                                        child: Center(
                                          child: Transform.scale(
                                            scale: scaleFactor,
                                            child: Radio(
                                              value: value,
                                              activeColor: primaryBlue,
                                              groupValue:
                                                  question.selectedOption,
                                              onChanged: (val) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  setState(() {
                                                    onAnswerSelected(
                                                        question.questionID ??
                                                            '',
                                                        value);
                                                  });
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: onCancel,
                    title: "Back",
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextButton(
                    onPressed: onNextPage,
                    backgroundColor: primaryBlue,
                    textStyle: getCTATextStyle(context, 12),
                    title: currentPage <=
                            (controller.personalityTest.value!.data!.questions!
                                            .length /
                                        questionsPerPage)
                                    .floor() -
                                1
                        ? "Next"
                        : "Submit",
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        );
      }),
    );
  }
}
