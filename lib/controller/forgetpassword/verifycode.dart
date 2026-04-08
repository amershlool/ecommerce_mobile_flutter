import 'package:e_commerce/data/datasource/remote/auth/verifycodesignup.dart';
import 'package:e_commerce/view/widget/custom_default_dialog_blocked.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/verifycode.dart';

abstract class VerifyCodeController extends GetxController{
  goToResetPassword(String verifyCode);
  resend(){}
}
class VerifyCodeControllerImp extends VerifyCodeController{
  VerifyCodeSinUpData verifyCodeSignData = VerifyCodeSinUpData(Get.find());

  String? email;
  VerifyCodeForGetPasswordData verifyCodeForGetPasswordData = VerifyCodeForGetPasswordData(Get.find());
  StatusRequest? statusRequest;
  @override
  goToResetPassword(verifyCode)async{
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response =
        await verifyCodeForGetPasswordData.postData (email!,verifyCode) as Map<String, dynamic>;
    print("========= signcontroler $response");
    statusRequest = handlingData(response);
    if (response['status'] == "success") {
      // data.addAll(response['data']);
      statusRequest = StatusRequest.success;
      update();
      Get.offNamed(AppRoutes.newPassword,arguments: {
        "email": email
      });

    } else {
      Get.defaultDialog(
          title: "VerificationSignUp1".tr, middleText: "VerificationSignUp2".tr);
      statusRequest = StatusRequest.failure;
      update();
      print("..........................................................");
    }
  }
  resend() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await verifyCodeSignData.resendData(email!);
    print("Resend Response: $response");

    statusRequest = handlingData(response);
    update();

    if (response['status'] == "blocked") {
      CustomDialogs.showBlockedDialog();


      return;
    }

    if (response['status'] == "final_warning") {
      Get.defaultDialog(
        title: "Warning".tr,
        middleText:
        "You have reached the maximum allowed number of verification code requests (5 times). This is your final attempt before your account gets blocked."
            " Please ensure you enter the information correctly.",
      );
      return;
    }

    if (response['status'] == "warning") {
      Get.defaultDialog(
        title: "Warning".tr,
        middleText:
        "You have requested the verification code 3 times. You have only 2 attempts left before temporary account blocking. "
            "Please be careful with the next attempt.",
      );
      return;
    }

    if (response['status'] == "success") {
      Get.defaultDialog(
        title: "Success",
        middleText: "Verification code has been sent successfully.",
      );
      return;
    }

    Get.defaultDialog(
      title: "Error",
      middleText: "Unexpected server response. Please try again.",
    );
  }

  @override
void onInit() {
    email = Get.arguments['email'];

    super.onInit();
  }



}