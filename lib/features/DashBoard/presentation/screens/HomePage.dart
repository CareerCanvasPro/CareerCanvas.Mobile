import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/dashboardScreen.dart';
import 'package:career_canvas/features/Networking/presentation/screens/networkingScreen.dart';
import 'package:career_canvas/features/Skill/presentations/screens/SkillPage.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';

import '../../../../src/profile/presentation/profile_view.dart';
import '../../../Career/presentation/screens/CareerScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isUploadingData = false;

  UserProfileData? userProfile;
  late UserProfileController userProfileController;

  @override
  void initState() {
    super.initState();
    userProfileController = getIt<UserProfileController>();

    _pages = [
      DashboardScreen(),
      CareerScreen(),
      SkillsPage(),
      NetworkingScreen(),
      UserProfile(),
    ];
  }

  // Define pages for each BottomNavigationBarItem
  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: scaffoldBackgroundColor,
        elevation: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center), label: 'Career'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Skills'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Networking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
