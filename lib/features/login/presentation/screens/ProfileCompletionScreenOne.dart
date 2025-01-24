import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCompletionScreenOne extends StatefulWidget {
   ProfileCompletionScreenOne({super.key,});

  static const String routeName = '/profileCompletionOne';

  @override
  State<ProfileCompletionScreenOne> createState() => _ProfileCompletionScreenOneState();
}

class _ProfileCompletionScreenOneState extends State<ProfileCompletionScreenOne> {
  // Controllers for input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
String type = '';

  @override
  void initState() {
    super.initState();
    // Access the passed arguments when the screen is initialized
    final Map<String, dynamic>? arguments = Get.arguments;
    if (arguments != null) {
      type = arguments['type'] ?? 'Unknown';
    }
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
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.white,
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
                  SizedBox(width: 2,),
                  Text("Career\nCanvas")
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Progress Bar
            buildProgressBar(progress: 0.5),
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
            // Profile Image
            buildProfileImage(),
            const SizedBox(height: 24),
            // Input Fields with Controllers
            _buildTextField('Full Name', fullNameController),
            const SizedBox(height: 16),
            _buildTextField('Date of Birth', dobController),
            const SizedBox(height: 16),
            _buildTextField('Present Address', addressController),
            const SizedBox(height: 16),
            _buildTextField('+880 1775560632', mobileController),
            const SizedBox(height: 16),
            _buildTextField('razibul@gmail.com', emailController),
            const SizedBox(height: 16),
            _buildTextField('Contact Information', contactInfoController),
            const SizedBox(height: 4),
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
