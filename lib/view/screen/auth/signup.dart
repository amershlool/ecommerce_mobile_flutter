import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/auth/signupcontrooler.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageasset.dart';
import 'package:e_commerce/core/function/validinputsignup.dart';
import 'package:e_commerce/view/widget/auth/custombutton.dart';
import 'package:e_commerce/view/widget/auth/customtextandtitle.dart';
import 'package:e_commerce/view/widget/auth/customtextfiledloginandsigin.dart';
import 'package:e_commerce/view/widget/auth/texttap.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImplement());

    return Scaffold(
      body: GetBuilder<SignUpControllerImplement>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: AppColor.boxDecoration,
            child: SafeArea(
              child: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(AppImageAsset.logo),
                    CustomTextAndTitle(text: "text5".tr, title: "title3".tr),
                    const SizedBox(height: 5),
                    CustomTextFiledSigInAndSignup(
                      validator: (val) {
                        return validatorInput(val!, 6, 30, "username");
                      },
                      keyboardType: TextInputType.name,
                      hintText: "hint4".tr,
                      label: "label4".tr,
                      prefixIcon: const Icon(Icons.person_outline),
                      myController: controller.userName,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiledSigInAndSignup(
                      validator: (val) {
                        return validatorInput(val!, 6, 30, "email");
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: "hint1".tr,
                      label: "label1".tr,
                      prefixIcon: const Icon(Icons.email_outlined),
                      myController: controller.email,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiledSigInAndSignup(
                      validator: (val) {
                        return validatorInput(val!, 6, 30, "phone");
                      },
                      keyboardType: TextInputType.number,
                      hintText: "hintPhone".tr,
                      label: "labilePhone".tr,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      myController: controller.phone,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiledSigInAndSignup(
                      validator: (val) {
                        return validatorInput(val!, 6, 30, "");
                      },
                      keyboardType: TextInputType.number,
                      hintText: "hint2".tr,
                      label: "label2".tr,
                      prefixIcon: const Icon(Icons.lock_outline),
                      myController: controller.password,
                      obscureText: false,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiledSigInAndSignup(
                      validator: (val) {
                        return validatorInput(val!, 6, 30, "");
                      },
                      keyboardType: TextInputType.number,
                      hintText: "hint3".tr,
                      label: "label3".tr,
                      prefixIcon: const Icon(Icons.lock_clock_outlined),
                      myController: controller.confirmPassword,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CustomButtonAuth(
                      onPressed: () {
                        if (controller.password.text.trim() ==
                            controller.confirmPassword.text.trim()) {
                          controller.signUp();
                        } else {
                          Get.snackbar(
                            "خطأ",
                            "كلمة المرور غير متطابقة",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(10),
                          );
                        }
                      },
                      childText: "button3".tr,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "text6".tr,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 5),
                        TextTap(
                          text: "button4".tr,
                          onTap: () {
                            controller.goToLogin();
                          },
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
