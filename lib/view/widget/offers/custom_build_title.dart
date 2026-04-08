import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomBuildTitle extends StatelessWidget {
  final String title;
  final double underlineLength;

  const CustomBuildTitle({
    super.key,
    required this.title, required this.underlineLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColor.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            height: 2,
            width: underlineLength,
            decoration: BoxDecoration(
              color: AppColor.hotRed,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
