import 'package:flutter/material.dart';

class Post {
  final String userName;
  final String location;
  final String community;
  final String content;
  final int likes;
  final int comments;

  Post({
    required this.userName,
    required this.location,
    required this.community,
    required this.content,
    required this.likes,
    required this.comments,
  });
}

class MyFeedTab extends StatefulWidget {
  @override
  _MyFeedTabState createState() => _MyFeedTabState();
}

class _MyFeedTabState extends State<MyFeedTab> {
  Future<List<Post>> fetchPosts() async {
    // Simulating API delay
    await Future.delayed(Duration(seconds: 0));
    return [
      Post(
        userName: "Fardeen Islam",
        location: "Dhaka, Bangladesh",
        community: "Reiki Healing",
        content:
            "This is what I learned in my recent course\n\n"
            "“The whole secret of existence lies in the pursuit of meaning, "
            "purpose, and connection. Finding harmony in the ebb and flow "
            "of experiences, we unlock profound beauty within our shared journey.”",
        likes: 16,
        comments: 24,
      ),
      // Add more sample posts
       Post(
        userName: "Fardeen Islam",
        location: "Dhaka, Bangladesh",
        community: "Reiki Healing",
        content:
            "This is what I learned in my recent course\n\n"
            "“The whole secret of existence lies in the pursuit of meaning, "
            "purpose, and connection. Finding harmony in the ebb and flow "
            "of experiences, we unlock profound beauty within our shared journey.”",
        likes: 16,
        comments: 24,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading posts"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No posts available"));
          }

          final posts = snapshot.data!;
          return ListView(
            children: [
              // Post Input Section
              _buildPostInput(),
              SizedBox(height: 16),
              ...posts.map((post) => _buildPostCard(post)).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPostInput() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Banking_ic_user1.jpeg'),
                  radius: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write your post here",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add your post in",
                  style: TextStyle(color: Colors.black54),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Publish Post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posted in ${post.community}",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  "view community",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Banking_ic_user1.jpeg'),
                  radius: 20,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.location,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(post.content),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(post.likes.toString()),
                    SizedBox(width: 16),
                    Icon(Icons.comment, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(post.comments.toString()),
                  ],
                ),
                Text(
                  "Share",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
