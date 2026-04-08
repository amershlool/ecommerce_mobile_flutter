import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextWelcome  extends StatelessWidget {
  final String textName;
  final String textSubTitleName;

  const CustomTextWelcome ({
    super.key,
    required this.textName,
    required this.textSubTitleName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${"TextWlcTitle".tr}",
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                    height: 1.3,
                  ),
                ),
                TextSpan(
                  text: " ${textName}!",
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColor.hotRed2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Text(
            textSubTitleName,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 3,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  AppColor.hotRed.withAlpha(150),
                  AppColor.hotRed2,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

