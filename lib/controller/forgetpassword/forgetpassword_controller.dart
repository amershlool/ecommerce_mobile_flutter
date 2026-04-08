import 'package:e_commerce/view/widget/custom_default_dialog_blocked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/checkemail.dart';
abstract class ForgetPasswordController extends GetxController {
  checkEmail();
  goToResetPassword();
}
class ForgetPasswordControllerImp extends ForgetPasswordController{
  CheckemailData checkemailData = CheckemailData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late  TextEditingController email ;
   StatusRequest statusRequest =StatusRequest.none ;



  @override
  checkEmail()async {
    if (formState.currentState!.validate()){
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic>  response = await checkemailData.postData(email.text) as Map<String, dynamic>;
      print("========= checkemailDataController $response");
      statusRequest = handlingData(response);
      update();
      if (response['status'] == "success") {
        Get.offNamed(AppRoutes.verificationPassword, arguments: {
          "email": email.text
        });

      } else if (response['status'] == "isBlock") {
        CustomDialogs.showBlockedDialog();

      } else {
        Get.defaultDialog(
            title: "Warning",
            middleText: "البريد الإلكتروني غير موجود"
        );
        statusRequest = StatusRequest.failure;
        update();
      }


    }

  }

  @override
  goToResetPassword() {}
@override
  void onInit() {
email = TextEditingController();
super.onInit();
  }
  @override
  void dispose() {
email.dispose();
super.dispose();
  }

}