import 'package:e_commerce/core/function/get_device_info.dart';
import 'package:e_commerce/core/function/print_all_shared_pref_values.dart';
import 'package:e_commerce/data/datasource/remote/token_data.dart';
import 'package:e_commerce/view/widget/auth/users_not_found.dart';
import 'package:e_commerce/view/widget/custom_default_dialog_blocked.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();

  goToSignup();

  goToForgotPassword();

  showPassword();
}

class LoginControllerImplement extends LoginController {
  LoginData loginData = LoginData(Get.find());
  late TextEditingController email;
  late TextEditingController password;
  RxBool isChangeVisibilities = false.obs;
  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      Map<String, dynamic> response =
          await loginData.postData(email.text, password.text)
              as Map<String, dynamic>;
      print("========= loginController $response");
      statusRequest = handlingData(response);
      update();

      if (response['status'] == "success") {
        print(
          "=============== on if -> response['status'] == success =================",
        );
        myServices.sharedPref.setString(
          "userid",
          response['data']['users_id'].toString(),
        );
        myServices.sharedPref.setString(
          "username",
          response['data']['users_name'],
        );
        myServices.sharedPref.setString(
          "email",
          response['data']['users_email'],
        );
        myServices.sharedPref.setString(
          "phone",
          response['data']['users_phone'],
        );
        myServices.sharedPref.setString("step", '2');

        printAllSharedPrefValues();

        String? token = await FirebaseMessaging.instance.getToken();
        String? userId = myServices.sharedPref.getString("userid");
        String deviceInfo = await getDeviceInfo();

        if (token != null && userId != null && userId != "0"){
          TokenData tokenData = TokenData(Get.find());
          tokenData.saveToken(userId, token, deviceInfo);
        }
        await FirebaseMessaging.instance.subscribeToTopic("users");
        Get.offNamed(AppRoutes.homepage);
      } else if (response['status'] == "notapprove") {
        Get.toNamed(
          AppRoutes.verificationSignUp,
          arguments: {"email": response['data']['users_email']},
        );

        statusRequest = StatusRequest.failure;
        update();
      } else if (response['status'] == "failure") {
        showSnackbarErrorLogin(
          "فشل تسجيل الدخول",
       "بيانات الاعتماد غير صحيحة. يرجى التحقق من اسم المستخدم وكلمة المرور والمحاولة مرة أخرى.",
        );
        statusRequest = StatusRequest.failure;
        update();
      } else {
        CustomDialogs.showBlockedDialog();

        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  @override
  goToSignup() {
    Get.offNamed(AppRoutes.signup);
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      //  String? token = value;
    });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgotPassword() {
    Get.toNamed(AppRoutes.forgot);
  }

  @override
  showPassword() {
    isChangeVisibilities.value = !isChangeVisibilities.value;
    print("$isChangeVisibilities");
  }
}
