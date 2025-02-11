import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/HomePage.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final TextEditingController skillsController = TextEditingController();
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
  }

  // Method to add a new skills field
  void _addSkilssField(String skill) {
    setState(() {
      _skills.add(skill);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(int index) {
    if (_skills.isNotEmpty && index < _skills.length) {
      setState(() {
        _skills.removeAt(index);
      });
    }
  }

  // Method to retrieve all values from skills fields
  List<Map<String, String>> _getAllSkilssValues() {
    return [];
  }

  final Map<String, String?> uploadedFiles = {};

  // Widget _buildSkilssCard(int index) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 16.0),
  //     elevation: 2,
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildTextField('Add Skill', skillsController),
  //           const SizedBox(height: 16),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Skills will be in a chieps style design with a x button to remove the skill
  Widget _buildSkilssCard(int index) {
    return Card(
      elevation: 3,
      // margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_skills[index]),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _removeSkilssField(index),
              icon: Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> skillsList = [
    'Flutter',
    'App Development',
    'Web Development',
    'UI/UX',
    "AI",
  ];
  List<String> searchSkills(String input) {
    return skillsList
        .where((element) => element.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
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
                if (_skills.isNotEmpty)
                  Wrap(
                    children: _skills
                        .map((e) => _buildSkilssCard(_skills.indexOf(e)))
                        .toList(),
                  ),
                // Form fields
                // Dynamic list of skills fields
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: _skills.length,
                //   itemBuilder: (context, index) {
                //     return _buildSkilssCard(index);
                //   },
                // ),

                SizedBox(height: 30),
                FieldSuggestion<String>(
                  search: (item, input) {
                    if (skillsController.text.isEmpty) return false;
                    return item.toLowerCase().contains(input.toLowerCase());
                  },
                  inputDecoration: InputDecoration(
                    hintText: 'Search Skills',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  boxStyle: BoxStyle(
                    backgroundColor: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  inputType: TextInputType.text,
                  suggestions: skillsList,
                  textController: skillsController,
                  // boxController: boxController, // optional
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () => _addSkilssField(
                            skillsList[index],
                          ),
                        );
                        skillsController.clear();
                      },
                      child: Card(
                        color: scaffoldBackgroundColor,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            skillsList[index],
                          ),
                        ),
                      ),
                    );
                  },
                  // itemBuilder: (BuildContext context, int index) {
                  //   return GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         textController.text = suggestions[index].email!;
                  //       });

                  //       textController.selection = TextSelection.fromPosition(
                  //         TextPosition(offset: textController.text.length),
                  //       );
                  //     },
                  //     child: Card(
                  //       child: ListTile(
                  //         title: Text(suggestions[index].username!),
                  //         subtitle: Text(suggestions[index].email!),
                  //         trailing: IconButton(
                  //           icon: const Icon(Icons.clear),
                  //           onPressed: () {
                  //             suggestions.removeAt(index);
                  //             boxController.refresh?.call();
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // },
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
                Navigator.pushNamed(context, HomePage.routeName);
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
                // final allValues = _getAllEducationValues();
                print(_skills);
                Navigator.pushNamed(context, HomePage.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(80, 48),
              ),
              child: Text(
                'Done',
                style: getCTATextStyle(context, 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
