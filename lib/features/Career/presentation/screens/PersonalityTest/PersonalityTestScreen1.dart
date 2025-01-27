import 'package:flutter/material.dart';

class PersonalityTestScreen1 extends StatefulWidget {
  static const String routeName = "/PersonalityTestScreen1";

  const PersonalityTestScreen1({Key? key}) : super(key: key);

  @override
  _PersonalityTestScreen1State createState() => _PersonalityTestScreen1State();
}

class _PersonalityTestScreen1State extends State<PersonalityTestScreen1> {
  // Example questions list
  List<Map<String, dynamic>> questions = [
    {
      'questionText': 'What excites you most about learning new technology?',
      'options': [
        'Building practical solutions',
        'Understanding how things work',
        'Exploring creative applications',
        'Using it to help others',
      ],
      'selectedOption': null,
    },
    {
      'questionText': 'Which skill do you enjoy developing the most?',
      'options': [
        'Problem-solving and critical thinking',
        'Artistic or design-based creativity',
        'Communication and teamwork',
        'Data analysis and logical reasoning',
      ],
      'selectedOption': null,
    },
    {
      'questionText': 'What excites you most about learning new technology?',
      'options': [
        'Building practical solutions',
        'Understanding how things work',
        'Exploring creative applications',
        'Using it to help others',
      ],
      'selectedOption': null,
    },
    {
      'questionText': 'Which skill do you enjoy developing the most?',
      'options': [
        'Problem-solving and critical thinking',
        'Artistic or design-based creativity',
        'Communication and teamwork',
        'Data analysis and logical reasoning',
      ],
      'selectedOption': null,
    },
    {
      'questionText': 'What excites you most about learning new technology?',
      'options': [
        'Building practical solutions',
        'Understanding how things work',
        'Exploring creative applications',
        'Using it to help others',
      ],
      'selectedOption': null,
    },
    {
      'questionText': 'Which skill do you enjoy developing the most?',
      'options': [
        'Problem-solving and critical thinking',
        'Artistic or design-based creativity',
        'Communication and teamwork',
        'Data analysis and logical reasoning',
      ],
      'selectedOption': null,
    },
  ];

  int currentQuestionIndex = 0;

  void onAnswerSelected(String selectedOption) {
    setState(() {
      questions[currentQuestionIndex]['selectedOption'] = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personality Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
              });
            } else {
              Navigator.pop(context); // Pops back to the previous screen
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              question['questionText'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(question['options'].length, (index) {
              final option = question['options'][index];
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: question['selectedOption'],
                onChanged: (value) {
                  onAnswerSelected(value!);
                },
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  OutlinedButton(
                     style: ElevatedButton.styleFrom(
                foregroundColor:  Colors.blue,
                minimumSize: const Size(100, 50),

              ),
                    onPressed: () {
                      setState(() {
                        currentQuestionIndex--;
                      });
                    },
                    child: const Text('Back'),
                  ),
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                foregroundColor:  Colors.blue,
                minimumSize: const Size(100, 50),

              ),
                  onPressed: () {
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    } else {
                      Navigator.pushNamed(context, '/AnalyzingResultsScreen');

                      // // Handle submission logic here
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Test completed!')),
                      // );
                    }
                  },
                  child: Text(
                    currentQuestionIndex < questions.length - 1
                        ? 'Next'
                        : 'Submit',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
