import 'package:flutter/material.dart';

class CustomBuildDivider extends StatelessWidget {
  const CustomBuildDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Divider(height: 1, color: Colors.grey.shade400),
    );
  }
}
