import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageasset.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/alertexit.dart';
import 'package:e_commerce/view/widget/auth/custombutton.dart';
import 'package:e_commerce/view/widget/auth/customtextandtitle.dart';

class StartAuth extends StatelessWidget {
  const StartAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: AppColor.boxDecoration,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextAndTitle(text: "text1".tr, title: "title1".tr),
                Center(
                  child: Image.asset(
                    AppImageAsset.loginpic1,
                    height: 400,
                  ),
                ),
                SizedBox(height: 40,),
                CustomButtonAuth(
                  onPressed: () {
                    Get.toNamed(AppRoutes.logIn);
                  },
                  childText: 'button4'.tr,
                ),
                CustomButtonAuth(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                  childText: 'button3'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
