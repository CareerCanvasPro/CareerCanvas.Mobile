import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/personalitytest/presentation/getx/controller/PersonalityTestController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalityTestScreen extends StatefulWidget {
  @override
  _PersonalityTestScreenState createState() => _PersonalityTestScreenState();
}

class _PersonalityTestScreenState extends State<PersonalityTestScreen> {
  late final PersonalityTestController controller;
  late String token;

  @override
  void initState() {
    super.initState();
    // Retrieve the token passed via Get.arguments
    token = Get.arguments['token'] ?? '';

    // Use get_it to get the controller instance
    controller = getIt<PersonalityTestController>();

    if (token.isNotEmpty) {
      controller.loadPersonalityTest(
          token); // Load personality test data when the screen is initialized
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personality Test')),
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

        return ListView.builder(
          itemCount: controller.personalityTest.value!.data!.questions!.length,
          itemBuilder: (context, index) {
            final question =
                controller.personalityTest.value!.data!.questions![index];
            return Card(
              color: scaffoldBackgroundColor,
              elevation: 2,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(question.question ?? 'No question'),
                subtitle: Text('Category: ${question.category ?? 'N/A'}'),
                trailing: Text('Score: ${question.score ?? '0'}'),
              ),
            );
          },
        );
      }),
    );
  }
}
