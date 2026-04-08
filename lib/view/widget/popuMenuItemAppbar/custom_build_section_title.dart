import 'package:flutter/material.dart';

class CustomBuildSectionTitle extends StatelessWidget {
  final String title ;
  const CustomBuildSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
          letterSpacing: 1.2,
        ),
      ),
    );

  }
}
