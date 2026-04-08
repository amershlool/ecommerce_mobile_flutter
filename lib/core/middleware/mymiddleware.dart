import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/serveces/services.dart';

class MyMiddleware extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPref.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.homepage);
    }
    if (myServices.sharedPref.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.logIn);
    }
    return null;
  }
}
