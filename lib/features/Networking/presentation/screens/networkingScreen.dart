import 'package:career_canvas/features/Networking/presentation/screens/Mentions/MentionsTab.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Community/CommunityTab.dart';
import 'Feeds/MyFeedTab.dart';
import 'Mentors/MyMentorsTab.dart';

class NetworkingScreen extends StatelessWidget {
  NetworkingScreen({super.key});

  static const String routeName = "/networking";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/icon_networking_page.svg",
                height: 30,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: 8),
              Text(
                "Networking",
                style: getCTATextStyle(
                  context,
                  24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "feed"),
              Tab(text: "Mentors"),
              Tab(text: "Community"),
              Tab(text: "Mentions"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Feed Tab
            MyFeedTab(),
            // Mentors Tab
            MyMentorsTab(),

            // Community Tab
            CommunityTab(),
            // Mentions Tab
            Mentionstab()
          ],
        ),
      ),
    );
  }
}
