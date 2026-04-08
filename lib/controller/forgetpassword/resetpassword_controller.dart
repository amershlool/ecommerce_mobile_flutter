import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/resetpassword.dart';

abstract class ResetPasswordController extends GetxController{
  goToSuccessResetPassword(String verifyCode);
}
class ResetPasswordControllerImp extends ResetPasswordController{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  late TextEditingController password ;
  late TextEditingController rPassword ;
  String? email ;
  StatusRequest statusRequest = StatusRequest.none ;

  @override
  goToSuccessResetPassword(String verifyCode) async{
    if (password.text!= rPassword.text){
      return Get.defaultDialog(title: "Warnig",middleText: " الرقم السري غير متشابه");
    } else{
    if (formState.currentState!.validate()){
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic>  response = await resetPasswordData.postData(
        email!, password.text) as Map<String, dynamic>;
      statusRequest = handlingData(response);
      update();
      if (response['status'] == "success") {
        Get.offNamed(AppRoutes.successSignup);
      }else{
        Get.defaultDialog(
            title: "Warning",
            middleText: "Try Again"
        );
        statusRequest = StatusRequest.failure;
        update();

      }
    }}
  }
  @override
  void onInit() {
    email = Get.arguments['email'];
    password = TextEditingController();
    rPassword = TextEditingController();
super.onInit();
  }
  @override
  void dispose() {
    password.dispose();
    rPassword.dispose();
    super.dispose();
  }


}
