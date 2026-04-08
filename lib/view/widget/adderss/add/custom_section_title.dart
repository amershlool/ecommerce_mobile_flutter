import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title ;
  const CustomSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo', // استخدام خط Cairo
        fontSize: 20, // حجم خط أكبر لعنوان القسم
      ),
    );
  }
}
