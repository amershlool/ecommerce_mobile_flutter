import 'package:get/get.dart';
import 'package:e_commerce/core/constant/routesname.dart';

abstract class SuccessController extends GetxController{
  goToLogin();

}
class SuccessControllerImplement extends SuccessController{
  @override
  goToLogin() {
Get.offAllNamed(AppRoutes.logIn);
  }
}