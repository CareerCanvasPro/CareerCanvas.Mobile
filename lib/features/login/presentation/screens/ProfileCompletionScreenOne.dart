import 'dart:io';

import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenTwo.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCompletionScreenOne extends StatefulWidget {
  ProfileCompletionScreenOne({
    super.key,
  });

  static const String routeName = '/profileCompletionOne';

  @override
  State<ProfileCompletionScreenOne> createState() =>
      _ProfileCompletionScreenOneState();
}

class _ProfileCompletionScreenOneState
    extends State<ProfileCompletionScreenOne> {
  // Controllers for input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  String type = '';
// late String _imagePath =
//       'ImagePath/ImageAssets.dart';
  late String _imagePath =
      'package:career_canvas/core/ImagePath/ImageAssets.dart'; // Initialize with an empty string

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primaryBlue,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        // final image = File(croppedFile.path);
        // debugPrint("Image picked: ${image.path}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('imagePath', pickedFile.path);
        setState(() {
          _imagePath = croppedFile.path;
        });
      }
    }
    // if (pickedFile != null) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('imagePath', pickedFile.path);
    //   setState(() {
    //     _imagePath = pickedFile.path;
    //   });
    // }
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _addEducationField(); // Add one initial skills section

    _imagePath = '';
    _loadImage();
    // Access the passed arguments when the screen is initialized
    final Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      type = arguments['type'] ?? 'Unknown';
    }
  }

  // List to hold controllers for each dynamic skills field
  List<Map<String, TextEditingController>> _skillsControllers = [];

  // Method to add a new skills field
  void _addEducationField() {
    setState(() {
      _skillsControllers.add({
        'fullName': TextEditingController(),
        'dob': TextEditingController(),
        'address': TextEditingController(),
        'mobile': TextEditingController(),
        'email': TextEditingController(),
        'contactInfo': TextEditingController(),
      });
    });
  }

  // Method to remove the last skills field
  void _removeEducationField() {
    if (_skillsControllers.isNotEmpty) {
      setState(() {
        _skillsControllers.removeLast();
      });
    }
  }

  // Method to retrieve all values from skills fields
  List<Map<String, String>> _getAllEducationValues() {
    return _skillsControllers.map((controllerMap) {
      return {
        'fullName': controllerMap['fullName']?.text ?? '',
        'dob': controllerMap['dob']?.text ?? '',
        'address': controllerMap['address']?.text ?? '',
        'mobile': controllerMap['mobile']?.text ?? '',
        'email': controllerMap['email']?.text ?? '',
        'contactInfo': controllerMap['contactInfo']?.text ?? '',
      };
    }).toList();
  }

  final Map<String, String?> uploadedFiles = {};

  Widget _buildEducationCard(int index) {
    final controllers = _skillsControllers[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
        // color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(child: buildProfileImage()),
            const SizedBox(height: 16),
            // Input Fields with Controllers
            _buildTextField('Full Name', controllers['fullName']!),
            // const SizedBox(height: 10),
            // _buildTextField('Date of Birth', controllers['dob']! ),
            const SizedBox(height: 10),
            _buildTextField('Present Address', controllers['address']!),
            const SizedBox(height: 10),
            _buildTextField('+880 1775560632', controllers['mobile']!),
            const SizedBox(height: 10),
            _buildTextField('razibul@gmail.com', controllers['email']!),
            const SizedBox(height: 10),
            // _buildTextField('Contact Information', controllers['contactInfo']! ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    fullNameController.dispose();
    dobController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    contactInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
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
            buildProgressBar(progress: 0.2),
            const SizedBox(height: 16),
            // Welcome Text
            const Text(
              'Hello! Complete your profile to onboard',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _skillsControllers.length,
              itemBuilder: (context, index) {
                return _buildEducationCard(index);
              },
            ),
            // const SizedBox(height: 4),
            // Footer
            _buildFooter(context),
          ],
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
        GestureDetector(
          onTap: _pickImage, // Pick image when tapped
          child: CircleAvatar(
            radius: 50, // Set the radius of the outer CircleAvatar
            backgroundColor:
                Colors.grey.shade300, // Background color of the CircleAvatar
            child: _imagePath.isNotEmpty && File(_imagePath).existsSync()
                ? ClipOval(
                    child: Image.file(
                      File(_imagePath),
                      width: 100, // Set the width of the image
                      height: 100, // Set the height of the image
                      fit: BoxFit.cover, // Ensure the image fits properly
                    ),
                  )
                : const Icon(
                    Icons.person, // Default icon if no image is set
                    size: 50,
                    color: Colors.grey,
                  ),
          ),
        ),

        // CircleAvatar(
        //   radius: 50,
        //   backgroundColor: Colors.grey.shade300,
        //   child: const Icon(Icons.person, size: 50, color: Colors.grey),
        // ),
        // GestureDetector(
        //             onTap: _pickImage,
        //             child: CircleAvatar(
        //               backgroundImage:
        //                   _imagePath.isNotEmpty && File(_imagePath).existsSync()
        //                       ? FileImage(File(_imagePath))
        //                           as ImageProvider<Object>?
        //                       : AssetImage(ImageAssets.dp),
        //               radius: 24,
        //               backgroundColor: Color.fromARGB(255, 255, 254, 254),
        //               foregroundColor: AppColors.secondaryColor,
        //             ),
        //           ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: _pickImage,
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Text(
          //   'Earn 5 coins',
          //   style: TextStyle(color: Colors.green, fontSize: 14),
          // ),
          SvgPicture.asset(
            'assets/svg/icons/icon_coin_5.svg',
          ),
          Row(
            children: [
              // TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     'Skip',
              //     style: TextStyle(color: primaryBlue, fontSize: 16),
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {
                  // Action for skip button
                  debugPrint("Skip button clicked");
                  Navigator.pushNamed(
                    context,
                    ProfileCompletionScreenTwo.routeName,
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
                  final allValues = _getAllEducationValues();
                  print(allValues);
                  // Example: Access user inputs
                  debugPrint("Full Name: ${fullNameController.text}");
                  debugPrint("Date of Birth: ${dobController.text}");
                  debugPrint("Address: ${addressController.text}");
                  debugPrint("Mobile: ${mobileController.text}");
                  debugPrint("Email: ${emailController.text}");
                  debugPrint("Contact Info: ${contactInfoController.text}");
                  Navigator.pushNamed(context, '/profileCompletiontwo');
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
      ),
    );
  }
}
