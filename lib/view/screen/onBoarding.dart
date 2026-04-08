import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/onboarding_controller.dart';
import 'package:e_commerce/view/widget/onboarding/iconlanguage.dart';
import '../../core/constant/color.dart';
import '../widget/onboarding/custombutton.dart';
import '../widget/onboarding/customslider.dart';
import '../widget/onboarding/dotcontroller.dart';
class MyOnBoarding extends StatelessWidget {
  const MyOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImplement());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child:  Column(
          children: [
            const IconLanguage(),
            const SizedBox(
              height: 7,
            ),
            const Expanded(
              flex: 3,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const CustomDotControllerOnBoarding(),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Text(
                            "button2".tr,
                            style: const TextStyle(color: AppColor.grey),
                          )),
                      const SizedBox(
                        width: 160,
                      ),
                      const CustomButtonOnBoarding(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
