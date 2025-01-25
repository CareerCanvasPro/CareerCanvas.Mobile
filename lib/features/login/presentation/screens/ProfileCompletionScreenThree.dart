import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:flutter/material.dart';

import '../../../../core/ImagePath/ImageAssets.dart';

class ProfileCompletionScreenThree extends StatefulWidget {
  static const String routeName = '/profileCompletionThree';

  @override
  _ProfileCompletionScreenThreeState createState() =>
      _ProfileCompletionScreenThreeState();
}

class _ProfileCompletionScreenThreeState
    extends State<ProfileCompletionScreenThree> {
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
  final List<String?> _uploadedFiles =
      []; // List to store file paths for uploads
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
        'workFromDate': TextEditingController(),
        'workTill': TextEditingController(),
      });
      _uploadedFiles
          .add(null); // Add an empty slot for the new experience section
    });
  }

  // Method to remove the last experience field
  void _removeExperienceField() {
    if (_experienceControllers.isNotEmpty) {
      setState(() {
        _experienceControllers.removeLast();
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

  // Method to retrieve all values from experience fields
  List<Map<String, String>> _getAllExperienceValues() {
    return _experienceControllers.map((controllerMap) {
      return {
        'currentOccupation': controllerMap['currentOccupation']?.text ?? '',
        'organizationName': controllerMap['organizationName']?.text ?? '',
        'designation': controllerMap['designation']?.text ?? '',
        'workFromDate': controllerMap['workFromDate']?.text ?? '',
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
                'Expected Work From', controllers['workFromDate']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Work Till', controllers['workTill']!),
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
                buildProgressBar(progress: 0.6),
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
                Navigator.pushNamed(context, '/profileCompletionFour');
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
                Navigator.pushNamed(context, '/profileCompletionFour');
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
