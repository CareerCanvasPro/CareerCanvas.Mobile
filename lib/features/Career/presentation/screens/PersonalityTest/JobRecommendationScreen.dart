import 'package:career_canvas/core/ImagePath/ImageAssets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class JobRecommendationScreen extends StatefulWidget {
      static const String routeName = "/JobRecommendationScreen";

  const JobRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<JobRecommendationScreen> createState() =>
      _JobRecommendationScreenState();
}

class _JobRecommendationScreenState extends State<JobRecommendationScreen> {
  List<Map<String, dynamic>> recommendedJobs = [];
  List<Map<String, dynamic>> whatsNewJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobsData();
  }

  Future<void> fetchJobsData() async {
    // Simulating API call with delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock API response
    final apiResponse = {
      "recommendedJobs": [
        {
          "title": "UX Designer",
          "company": "Amazon",
          "location": "Seattle, US (Remote)",
          "posted": "1 day ago",
          "logo": FontAwesomeIcons.amazon
        },
        {
          "title": "VR Designer",
          "company": "Meta",
          "location": "London, UK (Remote)",
          "posted": "5 days ago",
          "logo": FontAwesomeIcons.meta
        },
        {
          "title": "UI Designer",
          "company": "Apple",
          "location": "Cupertino, US (Remote)",
          "posted": "1 day ago",
          "logo": FontAwesomeIcons.apple
        }
      ],
      "whatsNewJobs": [
        {
          "title": "Product Designer",
          "company": "Coinbase",
          "location": "San Francisco, US (Remote)",
          "posted": "9h ago",
          "logo": FontAwesomeIcons.wikipediaW
        },
        {
          "title": "Lead UX/UI Designer",
          "company": "Figma",
          "location": "London, UK (Remote)",
          "posted": "5h ago",
          "logo": FontAwesomeIcons.figma
        }
      ]
    };

    setState(() {
      recommendedJobs = apiResponse["recommendedJobs"]!;
      whatsNewJobs = apiResponse["whatsNewJobs"]!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recommended for you",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendedJobs.length,
                      itemBuilder: (context, index) {
                        final job = recommendedJobs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: JobCard(
                            title: job['title'],
                            company: job['company'],
                            location: job['location'],
                            posted: job['posted'],
                            logo: job['logo'],
                            isHorizontal: true,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "What's new",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "See All" action
                        },
                        child: const Text("See all"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(whatsNewJobs.length, (index) {
                      final job = whatsNewJobs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: JobCard(
                          title: job['title'],
                          company: job['company'],
                          location: job['location'],
                          posted: job['posted'],
                          logo: job['logo'],
                          isHorizontal: false,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String posted;
  final dynamic logo; // Accept both String (URL) or IconData
  final bool isHorizontal;

  const JobCard({
    Key? key,
    required this.title,
    required this.company,
    required this.location,
    required this.posted,
    required this.logo,
    this.isHorizontal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the logo is a URL or an IconData
    final Widget logoWidget = logo is String
        ? Image.network(
            logo,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          )
        : Icon(
            logo,
            size: 40,
          );

    return isHorizontal
        ? Container(
            width: 200,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoWidget,
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  location,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  posted,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          )
        : Row(
            children: [
              logoWidget,
              const SizedBox(width: 12),
              Expanded(
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
                    Text(
                      company,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                posted,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.bookmark_border),
            ],
          );
  }
}
