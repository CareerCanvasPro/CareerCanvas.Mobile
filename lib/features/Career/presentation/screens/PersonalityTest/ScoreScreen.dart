
// class ScoreScreen extends StatelessWidget {
//   final int score;
//   final int relevantSkills;
//   final int totalSkills;

//   const ScoreScreen({
//     Key? key,
//     required this.score,
//     required this.relevantSkills,
//     required this.totalSkills,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "Great Work!",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             CircularPercentIndicator(
//               radius: 100.0,
//               lineWidth: 10.0,
//               animation: true,
//               percent: score / 100,
//               center: Text(
//                 "$score%",
//                 style: const TextStyle(
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               progressColor: Colors.green,
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               "Your Personalized Career Match",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               "$relevantSkills/$totalSkills Relevant Skills Aligned",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               "$score% Match Recommended Careers",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle career recommendations logic
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Redirecting to recommendations...')),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//               child: const Text(
//                 "Career Recommendation",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
