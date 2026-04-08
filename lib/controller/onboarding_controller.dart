import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/static/static.dart';

abstract class OnBoardingController extends GetxController {
  nextPage();

  onPageChanged(int index);
}

class OnBoardingControllerImplement extends OnBoardingController {
  MyServices myServices = Get.find();
  late PageController pageController;
  int currentPage = 0;

  @override
  nextPage() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myServices.sharedPref.setString("step", "1");
      Get.toNamed(AppRoutes.startAuth);
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
