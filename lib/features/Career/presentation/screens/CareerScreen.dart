import 'package:flutter/material.dart';

// Job Model
class Job {
  final int id;
  final String role;
  final String company;
  final String location;
  final List<String> tags;
  final String salary;

  Job({
    required this.id,
    required this.role,
    required this.company,
    required this.location,
    required this.tags,
    required this.salary,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      salary: json['salary'] ?? '',
    );
  }
}

// JobService: API Service for fetching jobs
class JobService {
  Future<List<Job>> fetchJobs() async {
    // Simulate an API delay
    await Future.delayed(const Duration(seconds: 0));

    // Mock API response
    final response = [
      {
        "id": 1,
        "role": "UI/UX Designer",
        "company": "Google Inc.",
        "location": "California, USA",
        "tags": ["Design", "Full time", "Senior Designer"],
        "salary": "\$15K/Mo"
      },
      {
        "id": 2,
        "role": "UX Researcher",
        "company": "Twitter Inc.",
        "location": "California, USA",
        "tags": ["Research", "Full time", "Mid-level"],
        "salary": "\$12K/Mo"
      },
      {
        "id": 3,
        "role": "Frontend Developer",
        "company": "Meta Platforms",
        "location": "Seattle, USA",
        "tags": ["Development", "Full time", "Junior Developer"],
        "salary": "\$10K/Mo"
      }
    ];

    // Convert the response to a list of Job objects
    return response.map((job) => Job.fromJson(job)).toList();
  }
}

// CareerScreen
class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});

  static const String routeName = "/careerScreen";

  final JobService jobService = JobService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Personalised Career Guided',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Assessment', style: TextStyle(fontSize: 14)),
                    Text('Manual Input (Goal)', style: TextStyle(fontSize: 14)),
                    Text('Who am I', style: TextStyle(fontSize: 14)),
                    Text('Personalise Experience', style: TextStyle(fontSize: 14)),
                    Text('Timeline', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Jobs for you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            FutureBuilder<List<Job>>(
              future: jobService.fetchJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading jobs"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No jobs available"));
                }

                final jobs = snapshot.data!;
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: JobCard(job: job),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Latest Job', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            FutureBuilder<List<Job>>(
              future: jobService.fetchJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading jobs"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No jobs available"));
                }

                final jobs = snapshot.data!;
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: JobCard(job: job),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// JobCard Widget
class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, size: 40),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.role, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('${job.company} • ${job.location}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: job.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.grey[200],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('25 minutes ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(job.salary, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
