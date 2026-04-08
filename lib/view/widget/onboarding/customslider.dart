import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/onboarding_controller.dart';
import '../../../data/datasource/static/static.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImplement> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);

      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(

            onBoardingList[i].image!,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            //title
            onBoardingList[i].title!.tr,
            style: Theme.of(context).textTheme.headlineMedium
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              //subtitle
              onBoardingList[i].subtitle!.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
