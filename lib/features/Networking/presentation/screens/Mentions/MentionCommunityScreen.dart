
import 'package:flutter/material.dart';

class MentionCommunityScreen extends StatelessWidget {
  final String communityName;
  final String description;
  final String rating;
  final String memberCount;

  MentionCommunityScreen({
    Key? key,
    required this.communityName,
    required this.description,
    required this.rating,
    required this.memberCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          communityName,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Community Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        communityName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "$rating ($memberCount members)",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Join Community Action
                      },
                      child: const Text("Join Community"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Divider(),
          // Tabs for About, Feed, Challenges
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black54,
                    tabs: [
                      Tab(text: "About community"),
                      Tab(text: "Feed"),
                      Tab(text: "Challenges"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tab content
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: About Community
                        Center(
                          child: Text(
                            "Welcome to $communityName! Explore resources, discussions, and more.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // Tab 2: Feed
                        Center(
                          child: Text(
                            "Community Feed is coming soon.",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // Tab 3: Challenges
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView(
                            children: [
                              ChallengeCard(
                                title: "Empower the Reiki Healer: 5 Day Challenge",
                                subtitle:
                                    "Join us for a 5-day challenge to empower your Reiki practice. Each day is designed to heal and awaken.",
                                reward: "Get 500 coins",
                                participants: "200+ have joined",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Challenge Card Widget
class ChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String reward;
  final String participants;

  const ChallengeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.reward,
    required this.participants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reward: $reward",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      participants,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Take Challenge Action
                  },
                  child: const Text("Take Challenge"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

