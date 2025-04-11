import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:flutter/material.dart';

class EntjDetailsScreen extends StatelessWidget {
  const EntjDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final traits = [
      ['Introvert', 'Extrovert'],
      ['Perceiving', 'Judging'],
      ['Intuition', 'Sensing'],
      ['Feeling', 'Thinking'],
    ];

    final careerOptions = [
      "Leadership",
      "Entrepreneurship",
      "Politics",
      "Leadership",
      "Entrepreneurship",
      "Politics",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        title: const Text("ENTJ's Details"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("Commander (analysts)"),
            const DescriptionText(),
            const SizedBox(height: 16),
            ...traits.map(
              (pair) => TraitBar(leftLabel: pair[0], rightLabel: pair[1]),
            ),
            const SizedBox(height: 24),
            const SectionTitle("Idea Career"),
            const SizedBox(height: 12),
             Wrap(
              spacing: 8,
              runSpacing: 8,
              children: careerOptions
                  .map((item) => CareerBox(label: item))
                  .toList(),
            ),
            // GridView.count(
            //   shrinkWrap: true,
            //   crossAxisCount: 3,
            //   crossAxisSpacing: 8,
            //   mainAxisSpacing: 8,
            //   childAspectRatio: 2.5,
            //   physics: const NeverScrollableScrollPhysics(),
            //   children: careerOptions
            //       .map((item) => CareerBox(label: item))
            //       .toList(),
            // ),
            const SizedBox(height: 24),
            const SectionTitle("Work environment"),
            const DescriptionText(),
            const SizedBox(height: 16),
            const SectionTitle("Strengths"),
            const DescriptionText(),
            const SizedBox(height: 16),
            const SectionTitle("Others"),
            const DescriptionText(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Bold, imaginative, and strong-willed leaders, always finding a way - or making one.",
      style: TextStyle(fontSize: 14),
    );
  }
}

class TraitBar extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;

  const TraitBar({
    required this.leftLabel,
    required this.rightLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 72, child: Text(leftLabel)),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[300],
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.6, // Customize as needed
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryColor, AppColors.primaryColor],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 72, child: Text(rightLabel, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
class CareerBox extends StatelessWidget {
  final String label;

  const CareerBox({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class CareerBoxs extends StatelessWidget {
  final String label;

  const CareerBoxs({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      onPressed: () {},
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}
