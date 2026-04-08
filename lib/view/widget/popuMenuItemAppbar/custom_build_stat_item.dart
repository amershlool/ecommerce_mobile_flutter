import 'package:flutter/material.dart';

class CustomBuildStatItem extends StatelessWidget {
  final String title;
  final String value;
  const CustomBuildStatItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10.0,
          ),
        ),
      ],
    );
    ;
  }
}
