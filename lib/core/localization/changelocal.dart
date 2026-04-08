
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/serveces/services.dart';

class LocalController extends GetxController{
  Locale? language;
  MyServices myServices = Get.find();
  void changeLang (String langCode){
    Locale locale = Locale(langCode);
    myServices.sharedPref.setString("lang", langCode);
    Get.updateLocale(locale);
  }
  @override
  void onInit() {
    String ? sharedPrefLang = myServices.sharedPref.getString("lang");
    if (sharedPrefLang == "ar"){
      language = const Locale("ar");
    }else if (sharedPrefLang == "en"){
      language = const Locale("en");
    }else{
      language =Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }

}