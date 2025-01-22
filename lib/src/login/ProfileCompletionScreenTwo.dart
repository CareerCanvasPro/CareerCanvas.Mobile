import 'package:career_canvas/src/login/LoginScreen.dart';
import 'package:career_canvas/src/utils/ScreenHeightExtension.dart';
import 'package:flutter/material.dart';

import '../ImagePath/ImageAssets.dart';

class ProfileCompletionScreenTwo extends StatefulWidget {
  static const String routeName = '/profileCompletiontwo';

  @override
  _ProfileCompletionScreenTwoState createState() =>
      _ProfileCompletionScreenTwoState();
}

class _ProfileCompletionScreenTwoState
    extends State<ProfileCompletionScreenTwo> {
  final _formKey = GlobalKey<FormState>();
// List to hold the education form fields
  List<Widget> _educationFields = [];

  // Method to add a new education field
  void _addEducationField() {
    setState(() {
      _educationFields.add(EducationField());
    });
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
                buildProgressBar(progress: 0.5),
                SizedBox(height: 10),
                Text(
                  'hello! Complete your profile for onboard!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                // Form fields

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Current Education'),
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Institute Name'),
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Field of Education'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Expected Graduation Date'),
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Academic Achievements'),
                      ),
                      SizedBox(height: 20),
                      // File Upload Button
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Implement upload functionality
                            },
                            child: Text('Upload Certificates'),
                          ),
                          Spacer(),
                          Text('pdf, doc'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Dynamic list of education fields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _educationFields,
                ),

                SizedBox(height: 20),

                // Add Education Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _addEducationField,
                    child: Text('+ Add Education'),
                  ),
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

  Widget buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(Icons.person, size: 50, color: Colors.grey),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              // Placeholder for profile image upload
              debugPrint("Profile image upload clicked");
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 18,
              ),
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
                Navigator.pushNamed(context, '/home');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profileCompletiontwo');
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

class EducationField extends StatelessWidget {
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _graduationDateController =
      TextEditingController();
  final TextEditingController _achievementsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _educationController,
          decoration: InputDecoration(labelText: 'Current Education'),
        ),
        TextFormField(
          controller: _instituteController,
          decoration: InputDecoration(labelText: 'Institute Name'),
        ),
        TextFormField(
          controller: _fieldController,
          decoration: InputDecoration(labelText: 'Field of Education'),
        ),
        TextFormField(
          controller: _graduationDateController,
          decoration: InputDecoration(labelText: 'Expected Graduation Date'),
        ),
        TextFormField(
          controller: _achievementsController,
          decoration: InputDecoration(labelText: 'Academic Achievements'),
        ),
        SizedBox(height: 20),
        // File Upload Button
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Implement upload functionality
              },
              child: Text('Upload Certificates'),
            ),
            Spacer(),
            Text('pdf, doc'),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
