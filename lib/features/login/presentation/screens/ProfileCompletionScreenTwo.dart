import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:flutter/material.dart';

import '../../../../core/ImagePath/ImageAssets.dart';

class ProfileCompletionScreenTwo extends StatefulWidget {
  static const String routeName = '/profileCompletiontwo';

  @override
  _ProfileCompletionScreenTwoState createState() =>
      _ProfileCompletionScreenTwoState();
}

class _ProfileCompletionScreenTwoState
    extends State<ProfileCompletionScreenTwo> {
  //final _formKey = GlobalKey<FormState>();
// List to hold the education form fields
  final TextEditingController currentEducationController =
      TextEditingController();
  final TextEditingController instituteNameController = TextEditingController();
  final TextEditingController fieldOfEducationController =
      TextEditingController();
  final TextEditingController expectedGraduationDateController =
      TextEditingController();
  final TextEditingController academicAchievementsController =
      TextEditingController();

// List to hold controllers for each dynamic education field
  List<Map<String, TextEditingController>> _educationControllers = [];
  final List<String?> _uploadedFiles =
      []; // List to store file paths for uploads
  @override
  void initState() {
    super.initState();
    _addEducationField(); // Add one initial education section
  }

  // Method to add a new education field
  void _addEducationField() {
    setState(() {
      _educationControllers.add({
        'currentEducation': TextEditingController(),
        'instituteName': TextEditingController(),
        'fieldOfEducation': TextEditingController(),
        'graduationDate': TextEditingController(),
        'achievements': TextEditingController(),
      });
      _uploadedFiles
          .add(null); // Add an empty slot for the new education section
    });
  }

  // Method to remove the last education field
  void _removeEducationField() {
    if (_educationControllers.isNotEmpty) {
      setState(() {
        _educationControllers.removeLast();
        _uploadedFiles.removeLast();
      });
    }
  }

  Future<void> _uploadCertificate(int index) async {
    // Simulate file picking (replace with actual file picker logic)
    final String? filePath = await _pickFile();
    if (filePath != null) {
      setState(() {
        _uploadedFiles[index] =
            filePath; // Update the file path for the specific section
      });
    }
  }

  Future<String?> _pickFile() async {
    // Replace with actual file picker logic using a package like `file_picker`
    // For now, we'll simulate picking a file:
    return Future.value("certificate.pdf"); // Simulated file path
  }

  // Method to retrieve all values from education fields
  List<Map<String, String>> _getAllEducationValues() {
    return _educationControllers.map((controllerMap) {
      return {
        'currentEducation': controllerMap['currentEducation']?.text ?? '',
        'instituteName': controllerMap['instituteName']?.text ?? '',
        'fieldOfEducation': controllerMap['fieldOfEducation']?.text ?? '',
        'graduationDate': controllerMap['graduationDate']?.text ?? '',
        'achievements': controllerMap['achievements']?.text ?? '',
      };
    }).toList();
  }

  final Map<String, String?> uploadedFiles = {};

  Widget _buildEducationCard(int index) {
    final controllers = _educationControllers[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                'Current Education', controllers['currentEducation']!),
            const SizedBox(height: 16),
            _buildTextField('Institute Name', controllers['instituteName']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Field of Education', controllers['fieldOfEducation']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Expected Graduation Date', controllers['graduationDate']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Academic Achievements', controllers['achievements']!),
            const SizedBox(height: 16),

            // Upload Certificate Section
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _uploadCertificate(index),
                  child: const Text('Upload Certificate'),
                ),
                const SizedBox(width: 16),
                Text(
                  _uploadedFiles[index] ?? 'No file uploaded',
                  style: TextStyle(
                    color: _uploadedFiles[index] == null
                        ? Colors.grey
                        : Colors.green,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
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
                buildProgressBar(progress: 0.4),
                SizedBox(height: 10),
                Text(
                  'hello! Complete your profile for onboard!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                // Form fields
                // Dynamic list of education fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _educationControllers.length,
                  itemBuilder: (context, index) {
                    return _buildEducationCard(index);
                  },
                ),

                // Add and Remove Education Buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: _addEducationField,
                      child: Text('+ Add Education'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: _removeEducationField,
                      child: Text('- Remove Education'),
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
                Navigator.pushNamed(context, '/profileCompletionThree');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final allValues = _getAllEducationValues();
                print(allValues);
                Navigator.pushNamed(context, '/profileCompletionThree');
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
