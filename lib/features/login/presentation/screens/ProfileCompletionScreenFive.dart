import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:flutter/material.dart';

import '../../../../core/ImagePath/ImageAssets.dart';

class ProfileCompletionScreenFive extends StatefulWidget {
  static const String routeName = '/profileCompletionFive';

  @override
  _ProfileCompletionScreenFiveState createState() =>
      _ProfileCompletionScreenFiveState();
}

class _ProfileCompletionScreenFiveState
    extends State<ProfileCompletionScreenFive> {
  //final _formKey = GlobalKey<FormState>();
// List to hold the experience form fields
  final TextEditingController currentOccupationController =
      TextEditingController();
  final TextEditingController organizationNameController = TextEditingController();
  final TextEditingController designationController =
      TextEditingController();
  final TextEditingController workFromDateController =
      TextEditingController();
  final TextEditingController workTillController =
      TextEditingController();

// List to hold controllers for each dynamic experience field
  List<Map<String, TextEditingController>> _experienceControllers = [];
 
  @override
  void initState() {
    super.initState();
    _addExperienceField(); // Add one initial experience section
  }

  // Method to add a new experience field
  void _addExperienceField() {
    setState(() {
      _experienceControllers.add({
        'currentOccupation': TextEditingController(),
        'organizationName': TextEditingController(),
        'designation': TextEditingController(),
        'workFrom': TextEditingController(),
        'workTill': TextEditingController(),
      });
     
    });
  }

  // Method to remove the last experience field
  void _removeExperienceField() {
    if (_experienceControllers.isNotEmpty) {
      setState(() {
        _experienceControllers.removeLast();
      });
    }
  }

  // Method to retrieve all values from experience fields
  List<Map<String, String>> _getAllExperienceValues() {
    return _experienceControllers.map((controllerMap) {
      return {
        'currentOccupation': controllerMap['currentOccupation']?.text ?? '',
        'organizationName': controllerMap['organizationName']?.text ?? '',
        'designation': controllerMap['designation']?.text ?? '',
        'workFrom': controllerMap['workFrom']?.text ?? '',
        'workTill': controllerMap['workTill']?.text ?? '',
      };
    }).toList();
  }

  final Map<String, String?> uploadedFiles = {};

  Widget _buildExperienceCard(int index) {
    final controllers = _experienceControllers[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                'Current Occupation', controllers['currentOccupation']!),
            const SizedBox(height: 16),
            _buildTextField('Organization Name', controllers['organizationName']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Designation', controllers['designation']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Expected Work From', controllers['workFrom']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Work Till', controllers['workTill']!),
            const SizedBox(height: 16),

           
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Career Canvas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: context.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.logo, // Replace with your logo path
                        height: 50,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Career\nCanvas")
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Progress Bar
                buildProgressBar(progress: 1),
                SizedBox(height: 10),
                Text(
                  'hello! Complete your profile for onboard!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                // Form fields
                // Dynamic list of experience fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _experienceControllers.length,
                  itemBuilder: (context, index) {
                    return _buildExperienceCard(index);
                  },
                ),

                // Add and Remove Experience Buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: _addExperienceField,
                      child: Text('+ Add Experience'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: _removeExperienceField,
                      child: Text('- Remove Experience'),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Action buttons
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
      ),
    );
  }

  Widget buildProgressBar({required double progress}) {
    return Stack(
      children: [
        Container(
          height: 5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress, // Dynamic progress
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Earn 5 coins',
          style: TextStyle(color: Colors.green, fontSize: 14),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                // Action for skip button
                debugPrint("Skip button clicked");
                Navigator.pushNamed(context, '/userScreen');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final allValues = _getAllExperienceValues();
                print(allValues);
                Navigator.pushNamed(context, '/profile');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
