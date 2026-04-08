import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/auth/verifiycodesignupcontroller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/auth/texttap.dart';
import 'package:e_commerce/view/widget/forgotpassword/customopt.dart';
import 'package:e_commerce/view/widget/forgotpassword/customtext.dart';

class VerificationSignUp extends StatelessWidget {
  const VerificationSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments["email"];

    Get.put(VerificationSignUpControllerImplement());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text(
          "appbar2".tr,
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white60,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<VerificationSignUpControllerImplement>(
        builder: (controller) => HandlingDataRequest(statusRequest: controller.statusRequest, widget:
             Container(
                width: double.infinity,
                decoration: AppColor.boxDecoration,
                child: ListView(
                  padding: const EdgeInsets.all(30),
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: CustomTextForgot(test: "text9".tr, fontSize: 30),
                    ),
                    Center(child: CustomTextForgot(test: email, fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomOpt(
                      onSubmit: (String verificationCode) {
                        controller.goToSuccessSignUp(verificationCode);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextForgot(test: "text10".tr, fontSize: 15),
                        TextTap(
                            fontWeight: FontWeight.bold,
                            text: "text11".tr,
                            onTap: () {
                              controller.resend();
                            },
                            color: Colors.white60,
                            fontFamily: "BalooBhaijaan",
                            fontSize: 15),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    ));
  }
}
