import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';

import '../../../../src/settings/settings_view.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  static const String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Master's Scholarship",
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    suffixIcon: Icon(Icons.tune, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.notifications, color: Colors.white),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/Banking_ic_user1.jpeg'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      // Added Expanded to prevent overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Razibul Hasan',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Flutter Developer, Career Canvas',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.track_changes, color: Colors.blue),
                title: Text('To Goal'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(Icons.download, color: Colors.blue),
                title: Text('Download your CV'),
                trailing: Icon(Icons.edit, color: Colors.blue),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.dashboard, color: Colors.grey),
                title: Text('Dashboard Widget'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.grey),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.grey),
                title: Text('Get Support'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.question_answer, color: Colors.grey),
                title: Text('FAQs'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.grey),
                title: Text('Privacy Policy'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.grey),
                title: Text('Theme'),
                onTap: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Logout from this Device',
                    style: TextStyle(color: Colors.red)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/images/Banking_ic_user1.jpeg'), // Add your profile image here
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check_circle,
                          color: Colors.green, size: 18),
                    ),
                  ),
                ],
              ),
              title: Text(
                "Fardeen Islam",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text("UI/UX Designer, Career Canvas"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "100% Completed",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   showUnselectedLabels: true,
      //   onTap: (index) {
      //      if (index == 0) {
      //       // Navigate to Networking Page
      //       Navigator.pushNamed(context, '/dashboard');
      //     }
      //     if (index == 4) {
      //       // Navigate to Networking Page
      //       Navigator.pushNamed(context, '/networking');
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'Career'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Skills'),
      //     BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Networking'),
      //   ],
      // ),
    );
  }
}
