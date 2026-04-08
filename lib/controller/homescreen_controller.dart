import 'package:e_commerce/view/screen/cart.dart';
import 'package:e_commerce/view/screen/home.dart';
import 'package:e_commerce/view/screen/offers.dart';
import 'package:e_commerce/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentPage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentPage = 0;
  List<Widget> listPage = [HomePage(), Offers(), Cart(), Settings()];
  List titleBottomAppbar = ["Home".tr, "Offers".tr, "cart".tr, "Settings".tr];
  List<IconData> iconBottomAppbarOutLined = [
    Icons.home_outlined,
    Icons.local_offer_outlined,
    Icons.shopping_cart_outlined,
    Icons.settings_outlined,
  ];
  List<IconData> iconBottomAppbar = [
    Icons.home,
    Icons.local_offer,
    Icons.shopping_cart,
    Icons.settings,
  ];

  @override
  changePage(int i) {
    currentPage = i;
    update();
    return currentPage;
  }
  @override
  void onInit() {
    changePage(currentPage);
    super.onInit();
  }
}
