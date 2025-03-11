import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/features/Networking/presentation/screens/networkingScreen.dart';
import 'package:career_canvas/features/Search/presentation/screens/SearchPage.dart';
import 'package:career_canvas/features/Skill/presentations/screens/SkillPage.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      CareerScreen(),
      UserProfile(),
      SearchPage(),
      SkillsPage(),
      NetworkingScreen(),
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
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/icons/career_screen_icon.svg',
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/icons/career_screen_icon.svg',
              colorFilter: ColorFilter.mode(
                primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            label: 'Career',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/icons/user_icon.svg',
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/icons/user_icon.svg',
              colorFilter: ColorFilter.mode(
                primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            label: 'About Me',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/icons/search_icon.svg",
              height: 20,
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/svg/icons/search_icon.svg",
              height: 20,
              colorFilter: ColorFilter.mode(
                primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/icons/icon_skills_page.svg",
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/svg/icons/icon_skills_page.svg",
              colorFilter: ColorFilter.mode(
                primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/icons/icon_networking_page.svg",
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/svg/icons/icon_networking_page.svg",
              colorFilter: ColorFilter.mode(
                primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            label: 'Network',
          ),
        ],
      ),
    );
  }
}
