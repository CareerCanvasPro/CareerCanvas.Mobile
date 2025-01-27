import 'package:flutter/material.dart';

class PersonalityTestScreen extends StatefulWidget {
   static const String routeName = "/PersonalityTestScreen";

  const PersonalityTestScreen({Key? key}) : super(key: key);
  @override
  _PersonalityTestScreenState createState() => _PersonalityTestScreenState();
}

class _PersonalityTestScreenState extends State<PersonalityTestScreen> {
  // Simulate API data
  final List<String> features = [
    "Artificial Intelligence",
    "Robotics",
    "Cloud Computing",
    "Software Development",
    "Data Science",
    "Environmental Tech"
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
        title: const Text('Personality Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            const Text(
              'Explore Your Interests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'What subjects interest you the most? Select all the areas that excite you or align with your passions!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
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
                          color: isSelected ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        feature,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedFeatures.length >= 3
                  ? () {
                        Navigator.pushNamed(context, '/PersonalityTestScreen1');

                    }
                  : null,
              child: const Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: selectedFeatures.length >= 3 ? Colors.blue : Colors.grey,
                minimumSize: const Size(double.infinity, 50),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
