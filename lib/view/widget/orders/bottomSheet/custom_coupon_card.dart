import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomCouponCard extends StatelessWidget {
  final String couponName;
  const CustomCouponCard({super.key, required this.couponName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.hotRed,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.local_offer, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discount Coupon',
                  style: TextStyle(fontSize: 12, color: AppColor.darkGray),
                ),
                Text(
                  couponName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkGray,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
        ],
      ),
    );
  }
}
