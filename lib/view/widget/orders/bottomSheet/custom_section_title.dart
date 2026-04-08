import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomSectionTitleSheet extends StatelessWidget {
  final String title;

  const CustomSectionTitleSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: AppColor.darkGray.withAlpha(50),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        gradient: LinearGradient(
          colors: [AppColor.coldOrange2, AppColor.coldOrange],
        begin: Alignment.bottomRight,
          end: Alignment.topLeft
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.darkGray,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
      ),
    );
  }
}
