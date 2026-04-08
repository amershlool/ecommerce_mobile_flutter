import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/onboarding_controller.dart';
import '../../../core/constant/color.dart';
import '../../../data/datasource/static/static.dart';
class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImplement>(
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  onBoardingList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 900),
                    width: controller.currentPage == index ? 15 : 6,
                    height: 6,
                    margin:const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: controller.currentPage==index? AppColor.hotRed:AppColor.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),

                ),

              ],
            ));
  }
}
