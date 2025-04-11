import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';

class PersonalityTestField extends StatefulWidget {
  static const String routeName = "/PersonalityTestField";

  const PersonalityTestField({Key? key}) : super(key: key);
  @override
  _PersonalityTestFieldState createState() => _PersonalityTestFieldState();
}

class _PersonalityTestFieldState extends State<PersonalityTestField> {
  // Simulate API data
  final List<String> features = [
    "Artificial Intelligence",
    "Robotics",
    "Cloud Computing",
    "Software Development",
    "Data Science",
    "Environmental Tech",
    "Web Development",
    "UI/UX",
    "App Development",
    "Flutter",
  ];

  final List<String> selectedFeatures = [];

  void toggleFeature(String feature) {
    setState(() {
      if (selectedFeatures.contains(feature)) {
        selectedFeatures.remove(feature);
      } else {
        selectedFeatures.add(feature);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personality Test',
          style: getCTATextStyle(
            context,
            20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Your Interests',
              style: getCTATextStyle(
                context,
                16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'What subjects interest you the most? Select all the areas that excite you or align with your passions!',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF52525B),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  final isSelected = selectedFeatures.contains(feature);
                  return GestureDetector(
                    onTap: () => toggleFeature(feature),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? primaryBlue : Color(0xFFE4E4E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            feature,
                            textAlign: TextAlign.center,
                            style: getCTATextStyle(
                              context,
                              11,
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedFeatures.length >= 1
                  ? () {
                      Navigator.pushNamed(context, '/PersonalityTestField1');
                    }
                  : null,
              child: const Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryBlue,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
