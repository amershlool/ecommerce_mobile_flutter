import 'package:e_commerce/core/serveces/services.dart';
import 'package:get/get.dart';

MyServices myServices = Get.find();
void printAllSharedPrefValues() {
  final keys = myServices.sharedPref.getKeys();

  for (var key in keys) {
    var value = myServices.sharedPref.get(key);
    print('$key : $value');
  }
}
