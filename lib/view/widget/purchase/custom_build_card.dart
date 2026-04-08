import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomBuildCardCheckOut extends StatelessWidget {
  final String title;

  final Widget child;

  const CustomBuildCardCheckOut({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
                color: AppColor.hotRed2,
              ),
            ),
            const SizedBox(height: 5),
            child,
          ],
        ),
      ),
    );
  }
}
