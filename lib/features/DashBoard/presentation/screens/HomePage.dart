import 'package:career_canvas/features/DashBoard/presentation/screens/dashboardScreen.dart';
import 'package:career_canvas/features/Networking/presentation/screens/networkingScreen.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src/profile/profile_view.dart';
import '../../../Career/presentation/screens/CareerScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define pages for each BottomNavigationBarItem
  final List<Widget> _pages = [
    DashboardScreen(),
    CareerScreen(),
    SkillsPage(),
    NetworkingScreen(),
    UserProfile(),
  ];

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

class SkillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/icons/icon_skills_page.svg",
              height: 30,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 8),
            Text(
              "Skills",
              style: getCTATextStyle(
                context,
                24,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Center(child: Text("Skills Page Content")),
    );
  }
}
