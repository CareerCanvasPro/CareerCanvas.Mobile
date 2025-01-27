import 'package:career_canvas/features/Networking/presentation/screens/Mentions/MentionCommunityScreen.dart';
import 'package:flutter/material.dart';

class Post {
  final String userName;
  final String location;
  final String courseTitle;
  final String content;
  final int likes;
  final int comments;
  final String communityName;

  Post({
    required this.userName,
    required this.location,
    required this.courseTitle,
    required this.content,
    required this.likes,
    required this.comments,
    required this.communityName,
  });
}

class Mentionstab extends StatelessWidget {
  final List<Post> posts = [
    Post(
      userName: "Freya",
      location: "Singapore",
      courseTitle: "The whole secret of existence course",
      content:
          "\"The whole secret of existence lies in the pursuit of meaning, purpose, and connection. It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life.\"",
      likes: 16,
      comments: 24,
      communityName: "Reiki Healing",
    ),
    Post(
      userName: "Ethan",
      location: "Canada",
      courseTitle: "Journey to Self-Discovery",
      content:
          "\"Through self-discovery, we embrace our true essence and learn to connect deeply with others, unlocking our shared potential.\"",
      likes: 22,
      comments: 10,
      communityName: "Self-Discovery Tribe",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Posted in ${post.communityName}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MentionCommunityScreen(
        communityName: "Reiki Healing",
        description:
            "Reiki healing channels universal energy, restoring balance and promoting holistic well-being.",
        rating: "4.3",
        memberCount: "10K+",
      ),
                            ),
                          );
                        },
                        child: const Text(
                          "view community",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    post.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.location,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "This is what I learned in my recent course\n\nThanks @fareedislam for '${post.courseTitle}'\n\n${post.content}",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.black54,
                            onPressed: () {
                              // Handle like
                            },
                          ),
                          Text(post.likes.toString()),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.comment),
                            color: Colors.black54,
                            onPressed: () {
                              // Handle comment
                            },
                          ),
                          Text(post.comments.toString()),
                        ],
                      ),
                      const Text(
                        "Share",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// class MentionCommunityScreen extends StatelessWidget {
//   final String communityName;

//   const MentionCommunityScreen({Key? key, required this.communityName})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           communityName,
//           style: const TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Center(
//         child: Text(
//           "Welcome to $communityName community!",
//           style: const TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
