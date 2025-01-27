import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mentor {
  final String name;
  final String role;
  final String location;
  final String imageUrl;
  final String status;

  Mentor(
      {required this.name,
      required this.role,
      required this.location,
      required this.imageUrl,
      required this.status});

  // Factory method to create a Mentor object from JSON
  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
        name: json['name'],
        role: json['role'],
        location: json['location'],
        imageUrl: json['imageUrl'],
        status: json['status']);
  }
}

class MyMentorsTab extends StatefulWidget {
  static const String routeName = "/MyMentorsTab";

  const MyMentorsTab({Key? key}) : super(key: key);
  @override
  _MyMentorsTabState createState() => _MyMentorsTabState();
}

class _MyMentorsTabState extends State<MyMentorsTab> {
  Future<List<Mentor>> fetchMentors() async {
    // Simulating API delay
    await Future.delayed(const Duration(seconds: 0));

    // Mock API response
    final mockResponse = [
      {
        'name': 'Ziauddin Ahmed, MD, FASN',
        'role':
            'Professor, Clinical Medicine, Lewis Katz School of Medicine at Temple University',
        'location': '@in.philadelphia',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
      {
        'name': 'Jane Doe',
        'role': 'Associate Professor, Harvard Medical School',
        'location': '@in.boston',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
      {
        'name': 'John Smith',
        'role': 'Director of Research, Stanford University',
        'location': '@in.palo.alto',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
      {
        'name': 'Ziauddin Ahmed, MD, FASN',
        'role':
            'Professor, Clinical Medicine, Lewis Katz School of Medicine at Temple University',
        'location': '@in.philadelphia',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
      {
        'name': 'Jane Doe',
        'role': 'Associate Professor, Harvard Medical School',
        'location': '@in.boston',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
      {
        'name': 'John Smith',
        'role': 'Director of Research, Stanford University',
        'location': '@in.palo.alto',
        'imageUrl': 'assets/images/Banking_ic_user1.jpeg',
        'status': 'Online'
      },
    ];

    // Convert mock response to List<Mentor>
    return mockResponse.map((json) => Mentor.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mentor>>(
      future: fetchMentors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading mentors"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No mentors available"));
        }

        final mentors = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: mentors.length,
          itemBuilder: (context, index) {
            final mentor = mentors[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MentorCard(context, mentor: mentor),
            );
          },
        );
      },
    );
  }
}

class MentorCard extends StatelessWidget {
  final Mentor mentor;
  MentorCard(BuildContext context, {required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage(mentor.imageUrl),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mentor.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                mentor.role,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                mentor.location,
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.blue),
          onPressed: () {
            Navigator.pushNamed(context, '/ChatScreen', arguments: {
              'name': mentor.name,
              'role': mentor.role,
              'location': mentor.location,
              'imageUrl': mentor.imageUrl,
              'status': mentor.status,
            }); // Navigate to catscreen
          },
        ),

        //const Icon(Icons.arrow_forward, color: Colors.blue,),
      ],
    );
  }
}
