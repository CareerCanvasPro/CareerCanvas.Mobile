import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenFour.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController workFromDateController = TextEditingController();
  final TextEditingController workTillController = TextEditingController();

// List to hold controllers for each dynamic experience field
  List<Map<String, TextEditingController>> _experienceControllers = [];
  List<bool> _isCurrent = [];
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
      _isCurrent.add(false);
    });
  }

  // Method to remove the last experience field
  void _removeExperienceField(int index) {
    if (_experienceControllers.isNotEmpty &&
        index < _experienceControllers.length) {
      setState(() {
        _experienceControllers.removeAt(index);
        _isCurrent.removeAt(index);
      });
    }
  }

  // Method to retrieve all values from experience fields
  List<Map<String, dynamic>> _getAllExperienceValues() {
    List<Map<String, dynamic>> experiances =
        _experienceControllers.map((controllerMap) {
      return {
        'currentOccupation': controllerMap['currentOccupation']?.text ?? '',
        'organizationName': controllerMap['organizationName']?.text ?? '',
        'designation': controllerMap['designation']?.text ?? '',
        'workFromDate': controllerMap['workFromDate']?.text ?? '',
        'workTill': controllerMap['workTill']?.text ?? '',
      };
    }).toList();
    experiances.forEach((experience) {
      experience['isCurrent'] =
          _isCurrent[experiances.indexOf(experience)].toString();
    });
    return experiances;
  }

  final Map<String, String?> uploadedFiles = {};

  Widget _buildExperienceCard(int index) {
    final controllers = _experienceControllers[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0)
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    onPressed: () => _removeExperienceField(index),
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            _buildTextField(
                'Current Occupation', controllers['currentOccupation']!),
            const SizedBox(height: 16),
            _buildTextField(
                'Organization Name', controllers['organizationName']!),
            const SizedBox(height: 16),
            _buildTextField('Designation', controllers['designation']!),
            const SizedBox(height: 16),
            _buildTextField('Expected Work From', controllers['workFromDate']!),
            const SizedBox(height: 16),
            _buildTextField('Work Till', controllers['workTill']!),
            const SizedBox(height: 16),
            // Add a check box for the current experience
            Row(
              children: [
                Checkbox(
                  value: _isCurrent[index],
                  activeColor: primaryBlue,
                  onChanged: (value) {
                    setState(() {
                      _isCurrent[index] = value ?? false;
                    });
                  },
                ),
                // const SizedBox(width: 4),
                Text(
                  'Current Occupation',
                  style: getCTATextStyle(
                    context,
                    14,
                    color: Colors.black,
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
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        //title: Text('Career Canvas'),
        backgroundColor: scaffoldBackgroundColor,
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
                  'Hello! Please add your experience details below.',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _addExperienceField,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: scaffoldBackgroundColor,
                        side: BorderSide(color: primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text(
                        '+ Add Experience',
                        style: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
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
        SvgPicture.asset(
          'assets/svg/icons/icon_coin_5.svg',
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Action for skip button
                debugPrint("Skip button clicked");
                Navigator.pushNamed(
                  context,
                  ProfileCompletionScreenFour.routeName,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: scaffoldBackgroundColor,
                side: BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Skip',
                style: getCTATextStyle(
                  context,
                  16,
                  color: primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final allValues = _getAllExperienceValues();
                print(allValues);
                Navigator.pushNamed(
                  context,
                  ProfileCompletionScreenFour.routeName,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Next',
                style: getCTATextStyle(context, 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
