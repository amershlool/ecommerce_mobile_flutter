import 'package:e_commerce/core/serveces/services.dart';
import 'package:get/get.dart';

transLateDataBase(columnNameEn, columnNameAr) {
  MyServices myServices = Get.find();
  if (myServices.sharedPref.getString("lang") == "ar") {
    return columnNameAr;
  } else {
    return columnNameEn;
  }
}
