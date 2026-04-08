import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController{
logout();
}
class SettingsControllerImp extends SettingsController{
  MyServices myServices = Get.find();
  @override
  logout(){
    myServices.sharedPref.clear();
    Get.offAllNamed(AppRoutes.logIn);
  }

}