import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:flutter/material.dart';

import '../../../../core/ImagePath/ImageAssets.dart';

class ProfileCompletionScreenFour extends StatefulWidget {
  static const String routeName = '/profileCompletionFour';

  @override
  _ProfileCompletionScreenFourState createState() =>
      _ProfileCompletionScreenFourState();
}

class _ProfileCompletionScreenFourState
    extends State<ProfileCompletionScreenFour> {
  //final _formKey = GlobalKey<FormState>();
// List to hold the skills form fields
  final TextEditingController hardSkillsController =
      TextEditingController();
  final TextEditingController firstSkillsController = TextEditingController();
  final TextEditingController secondSkillsController =
      TextEditingController();
  final TextEditingController thirdSkillsController =
      TextEditingController();
  final TextEditingController fourSkilssController =
      TextEditingController();

  // List to hold controllers for each dynamic skills field
  List<Map<String, TextEditingController>> _skillsControllers = [];
 
  @override
  void initState() {
    super.initState();
    _addSkilssField(); // Add one initial skills section
  }

  // Method to add a new skills field
  void _addSkilssField() {
    setState(() {
      _skillsControllers.add({
        'hardSkills': TextEditingController(),
        'firstSkills': TextEditingController(),
        'secondSkills': TextEditingController(),
        'thirdSkills': TextEditingController(),
        'fourSkilss': TextEditingController(),
      });
   
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField() {
    if (_skillsControllers.isNotEmpty) {
      setState(() {
        _skillsControllers.removeLast();
      });
    }
  }

  // Method to retrieve all values from skills fields
  List<Map<String, String>> _getAllSkilssValues() {
    return _skillsControllers.map((controllerMap) {
      return {
        'hardSkills': controllerMap['hardSkills']?.text ?? '',
        'firstSkills': controllerMap['firstSkills']?.text ?? '',
        'secondSkills': controllerMap['secondSkills']?.text ?? '',
        'thirdSkills': controllerMap['thirdSkills']?.text ?? '',
        'fourSkilss': controllerMap['fourSkilss']?.text ?? '',
      };
    }).toList();
  }

  final Map<String, String?> uploadedFiles = {};

  Widget _buildSkilssCard(int index) {
    final controllers = _skillsControllers[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                'Hard Skills', controllers['hardSkills']!),
            const SizedBox(height: 16),
            _buildTextField('First Skills', controllers['firstSkills']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Second Skills', controllers['secondSkills']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Expected Third Skills', controllers['thirdSkills']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Four Skilss', controllers['fourSkilss']!),
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
                buildProgressBar(progress: 0.8),
                SizedBox(height: 10),
                Text(
                  'hello! Complete your profile for onboard!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                // Form fields
                // Dynamic list of skills fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _skillsControllers.length,
                  itemBuilder: (context, index) {
                    return _buildSkilssCard(index);
                  },
                ),

                // Add and Remove Skilss Buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: _addSkilssField,
                      child: Text('+ Add Skilss'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: _removeSkilssField,
                      child: Text('- Remove Skilss'),
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
                Navigator.pushNamed(context, '/ProfileCompletionScreenFive');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final allValues = _getAllSkilssValues();
                print(allValues);
                Navigator.pushNamed(context, '/ProfileCompletionScreenFive');
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
