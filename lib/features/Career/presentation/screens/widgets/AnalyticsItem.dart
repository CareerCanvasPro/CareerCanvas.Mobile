
import 'package:flutter/material.dart';

class AnalyticsItem extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const AnalyticsItem({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            )),
        if (subtitle.isNotEmpty)
          Text(subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              )),
      ],
    );
  }
}
