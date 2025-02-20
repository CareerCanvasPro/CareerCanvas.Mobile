import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/features/DashBoard/presentation/screens/dashboardScreen.dart';
import 'package:career_canvas/features/Networking/presentation/screens/networkingScreen.dart';
import 'package:career_canvas/features/Skill/presentations/screens/SkillsScreen.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../src/profile/profile_view.dart';
import '../../../Career/presentation/screens/CareerScreen.dart';

class HomePage extends StatefulWidget {
  final UserProfileData? userProfile;
  const HomePage({
    Key? key,
    this.userProfile,
  }) : super(key: key);

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isUploadingData = false;

  UserProfileData? userProfile;

  @override
  void initState() {
    super.initState();
    if (widget.userProfile != null) {
      userProfile = widget.userProfile;
    }
    // run after ui build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileDate(); // Get profile data
    });

    _pages = [
      DashboardScreen(),
      CareerScreen(),
      SkillsPage(),
      NetworkingScreen(),
      UserProfile(
        userProfileData: userProfile,
      ),
    ];
  }

  getProfileDate() async {
    if (userProfile == null) {
      return;
    }
    try {
      setState(() {
        isUploadingData = true;
      });
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiClient.userBase,
          connectTimeout: const Duration(seconds: 3000),
          receiveTimeout: const Duration(seconds: 3000),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      final response = await dio.get(
        "${ApiClient.userBase}/user/profile",
        options: Options(
          headers: {
            'Content-Type': "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      userProfile = UserProfileData.fromMap(response.data['data']);
      debugPrint(response.data['message']);
      isUploadingData = false;
      setState(() {});
    } on DioException catch (e) {
      setState(() {
        isUploadingData = false;
      });
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data["message"]);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        CustomDialog.showCustomDialog(
          context,
          title: "Error",
          content: e.response!.data["message"].toString(),
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        CustomDialog.showCustomDialog(
          context,
          title: "Error",
          content: e.message.toString(),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isUploadingData = false;
      });
      CustomDialog.showCustomDialog(
        context,
        title: "Error",
        content: e.toString(),
      );
    }
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
