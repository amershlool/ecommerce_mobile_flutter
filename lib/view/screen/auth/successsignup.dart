import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/auth/successcontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/auth/custombutton.dart';
import 'package:e_commerce/view/widget/auth/customtextandtitle.dart';

class SuccessSignup extends StatelessWidget {
  const SuccessSignup({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessControllerImplement successControllerImplement =
        Get.put(SuccessControllerImplement());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: AppColor.boxDecoration,
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
               Center(
                child: CustomTextAndTitle(
                    text: "text13".tr, title: "text14".tr),
              ),
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.check_circle_outline,
                size: 200,
                color: Colors.lightGreen,
                weight: 100,
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButtonAuth(
                  onPressed: () {
                    successControllerImplement.goToLogin();
                  },
                  childText: "button4".tr)
            ],
          ),
        ),
      ),
    );
  }
}
