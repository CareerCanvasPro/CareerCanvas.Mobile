import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnalyzingResultsScreen extends StatefulWidget {
  static const String routeName = "/AnalyzingResultsScreen";

  const AnalyzingResultsScreen({Key? key}) : super(key: key);

  @override
  _AnalyzingResultsScreenState createState() => _AnalyzingResultsScreenState();
}

class _AnalyzingResultsScreenState extends State<AnalyzingResultsScreen> {
  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    // Simulate API call with a delay
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the score screen with dynamic data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          score: 80, // Dynamic score (replace with API response data)
          relevantSkills: 38,
          totalSkills: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.public,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              "Analyzing Your Results...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "We're reviewing your answers to curate personalized suggestions just for you. Hang tight—it won't take long!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final int score;
  final int relevantSkills;
  final int totalSkills;

  const ScoreScreen({
    Key? key,
    required this.score,
    required this.relevantSkills,
    required this.totalSkills,
  }) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Great Work!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              animation: true,
              percent: score / 100,
              center: Text(
                "$score%",
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              "Your Personalized Career Match",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              "$relevantSkills/$totalSkills Relevant Skills Aligned",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "$score% Match Recommended Careers",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                // Handle career recommendations logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Redirecting to recommendations...')),
                );
                Navigator.pushNamed(context, '/JobRecommendationScreen');
              },
              // style: ElevatedButton.styleFrom(
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              // ),
              child: const Text(
                "Career Recommendation",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
