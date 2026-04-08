// دالة مساعدة _buildDetailRow
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

Widget buildDetailRow(BuildContext context, {
  required String label,
  required String value,
  Color? valueColor,
  bool isBold = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColor.darkGray,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: valueColor ?? AppColor.darkGray,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
