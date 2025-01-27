import 'package:career_canvas/features/Networking/presentation/screens/Mentions/MentionsTab.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back, color: Colors.black),
          title: Row(
            children: [
              Icon(Icons.group, color: Colors.black),
              SizedBox(width: 8),
              Text(
                "Networking",
                style: TextStyle(color: Colors.black),
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
