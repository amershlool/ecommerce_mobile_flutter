import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/onboarding_controller.dart';
import '../../../core/constant/color.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImplement> {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.white30, width: 1),
            elevation: 10,
            minimumSize: const Size(130, 50),
            backgroundColor: AppColor.hotRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
        onPressed: () {
          controller.nextPage();
        },
        child:  Text(
            "button1".tr ,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),

        );
  }
}
