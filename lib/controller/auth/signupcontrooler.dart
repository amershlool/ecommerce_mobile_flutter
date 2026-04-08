import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/auth/signup.dart';
import 'package:e_commerce/data/datasource/remote/auth/verifycodesignup.dart';
import 'package:e_commerce/view/screen/auth/login.dart';

abstract class SignUpController extends GetxController {
  signUp();

  goToLogin();

  goToVerification();
}

class SignUpControllerImplement extends SignUpController {
  late TextEditingController userName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  StatusRequest statusRequest =StatusRequest.none;
  List data = [];
  SignupData signupData = SignupData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  VerifyCodeSinUpData verifyCodeSignData = VerifyCodeSinUpData(Get.find());

  @override
  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic> response = await signupData.getDataSignUp(
          userName.text, email.text, password.text, phone.text) as Map<String, dynamic>;
      statusRequest = handlingData(response);
      update();
      if (response['status'] == "success") {
        goToVerification();
      } else {
        Get.defaultDialog(
            title: "Warning",
            middleText: "Phone Number Or Email Already Exists"
        );
        statusRequest = StatusRequest.failure;
        update();

      }
    }
  }

  @override
  goToLogin() {
    Get.off(() => const Login());
  }

  @override
  void onInit() {
    userName = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  goToVerification() {
    Get.toNamed(AppRoutes.verificationSignUp, arguments: {"email": email.text});
  }
}
