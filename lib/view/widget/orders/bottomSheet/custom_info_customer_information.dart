import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomInfoCustomerInformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;


  const CustomInfoCustomerInformation(
      {super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColor.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: AppColor.grey),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}
