import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomBuildHeader extends StatelessWidget {
  const CustomBuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColor.darkGray,
                  fontSize: 24,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Select your preferred payment method",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 40,
              width: 40,
              child: const Icon(
                Icons.close_rounded,
                size: 20,
                color: AppColor.hotRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
