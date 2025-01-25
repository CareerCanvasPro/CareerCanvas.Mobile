import 'package:flutter/material.dart';



class CommunityTab extends StatefulWidget {
  @override
  _CommunityTabState createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  List<Map<String, String>> communities = [];

  @override
  void initState() {
    super.initState();
    fetchCommunities();
  }

  Future<void> fetchCommunities() async {
    // Simulate an API call
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      communities = [
        {
          'title': 'Reiki Healing',
          'image': 'assets/images/OIP.jpg',
        },
        {
          'title': 'Crystal Healing',
          'image': 'assets/images/OIP.jpg',
        },
        {
          'title': 'Crypto Currency',
          'image': 'assets/images/OIP.jpg', //D:\FlutterWork\app-frontend\assets\images\OIP.jpg
        },
        {
          'title': 'Crypto Currency',
          'image': 'assets/images/OIP.jpg', //D:\FlutterWork\app-frontend\assets\images\OIP.jpg
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: communities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: communities.length,
                itemBuilder: (context, index) {
                  final community = communities[index];
                  return CommunityCard(
                    title: community['title']!,
                    imagePath: community['image']!,
                  );
                },
              ),
            ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final String title;
  final String imagePath;

  CommunityCard({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      '4.3 (10K+ members)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {},
              child: Text(
                'View Community',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
