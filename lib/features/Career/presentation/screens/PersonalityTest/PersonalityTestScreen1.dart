import 'package:career_canvas/core/models/TextQuestion.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';

class PersonalityTestScreen1 extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen1";

  const PersonalityTestScreen1({Key? key}) : super(key: key);

  @override
  _PersonalityTestScreen1State createState() => _PersonalityTestScreen1State();
}

class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
  // Example questions list
  List<TestQuestion> questions = [];

  int currentQuestionIndex = 0;

  List<TestQuestion> currentQuestions = [];

  @override
  void initState() {
    super.initState();
    final q = dummyQuestions.map((ques) {
      return TestQuestion.fromMap(ques);
    }).toList();
    questions.addAll(q);
    setCurrentQuestions();
  }

  setCurrentQuestions() {
    if (currentQuestionIndex < 1) {
      currentQuestions = questions.sublist(0, 10);
    } else {
      currentQuestions = questions.sublist(
        currentQuestionIndex * 10,
        (currentQuestionIndex * 10) + 10,
      );
    }
  }

  void onAnswerSelected(String id, int selectedOption) {
    setState(() {
      questions.where((qu) => qu.questionID == id).toList().first.answer =
          selectedOption;
      currentQuestions
          .where((qu) => qu.questionID == id)
          .toList()
          .first
          .answer = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Personality Test'),
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
                setCurrentQuestions();
              });
            } else {
              Navigator.pop(context); // Pops back to the previous screen
            }
          },
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / (questions.length / 10).floor(),
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                currentQuestions[index].question,
                                style: getCTATextStyle(
                                  context,
                                  14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Agree",
                                  ),
                                  Text(
                                    "Neutral",
                                  ),
                                  Text(
                                    "Disagree",
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        value: 3,
                                        activeColor: Colors.green,
                                        hoverColor: Colors.green,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              3,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Radio(
                                        value: 2,
                                        activeColor: Colors.green,
                                        hoverColor: Colors.green,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              2,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Radio(
                                        value: 1,
                                        activeColor: Colors.green,
                                        hoverColor: Colors.green,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              1,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Radio(
                                      value: 0,
                                      activeColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                      groupValue:
                                          currentQuestions[index].answer,
                                      onChanged: (value) {
                                        setState(() {
                                          onAnswerSelected(
                                            currentQuestions[index].questionID,
                                            0,
                                          );
                                        });
                                      },
                                    ),
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Radio(
                                        value: -1,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              -1,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Radio(
                                        value: -2,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              -2,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        value: -3,
                                        groupValue:
                                            currentQuestions[index].answer,
                                        onChanged: (value) {
                                          setState(() {
                                            onAnswerSelected(
                                              currentQuestions[index]
                                                  .questionID,
                                              -3,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: currentQuestions.length,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: currentQuestionIndex > 0
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        if (currentQuestionIndex > 0)
                          OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              minimumSize: const Size(100, 50),
                            ),
                            onPressed: () {
                              setState(() {
                                currentQuestionIndex--;
                                setCurrentQuestions();
                              });
                            },
                            child: const Text('Back'),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: primaryBlue,
                            minimumSize: const Size(100, 50),
                          ),
                          onPressed: () {
                            if (currentQuestions
                                .where((qu) => qu.answer == null)
                                .toList()
                                .isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Answer All the questions',
                                  ),
                                ),
                              );
                            } else {
                              if (currentQuestionIndex <
                                  (questions.length / 10).floor() - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                  setCurrentQuestions();
                                });
                              } else {
                                Navigator.pushNamed(
                                    context, '/AnalyzingResultsScreen');
                              }
                            }
                          },
                          child: Text(
                            currentQuestionIndex < questions.length - 1
                                ? 'Next'
                                : 'Submit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
