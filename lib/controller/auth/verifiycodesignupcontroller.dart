import 'package:e_commerce/view/widget/custom_default_dialog_blocked.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/auth/verifycodesignup.dart';

abstract class VerificationSignUpController extends GetxController {
  trueCode();

  resend();

  goToSuccessSignUp(String verifyCodeSignUp);
}

class VerificationSignUpControllerImplement
    extends VerificationSignUpController {
  VerifyCodeSinUpData verifyCodeSignData = VerifyCodeSinUpData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? email;

  @override
  goToSuccessSignUp(verifyCodeSignUp) async {
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response =
        await verifyCodeSignData.getDataSignUpVerifyCode(
              email!,
              verifyCodeSignUp,
            )
            as Map<String, dynamic>;
    print("========= signcontroler $response");
    statusRequest = handlingData(response);
    if (response['status'] == "success") {
      // data.addAll(response['data']);
      statusRequest = StatusRequest.success;
      update();
      Get.offNamed(AppRoutes.successSignup);
    } else {
      Get.defaultDialog(
        title: "VerificationSignUp1".tr,
        middleText: "VerificationSignUp2".tr,
      );
      statusRequest = StatusRequest.failure;
      update();
      print("..........................................................");
    }
  }

  @override
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
        "You have reached the maximum allowed number of verification code requests (10 times). This is your final attempt before your account gets blocked."
            " Please ensure you enter the information correctly.",
      );
      return;
    }

    if (response['status'] == "warning") {
      Get.defaultDialog(
        title: "Warning".tr,
        middleText:
        "You have requested the verification code 7 times. You have only 3 attempts left before temporary account blocking. "
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
  trueCode() {}

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
