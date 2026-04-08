import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/auth/logincontrooler.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageasset.dart';
import 'package:e_commerce/core/function/validinputsignup.dart';
import 'package:e_commerce/view/widget/auth/custombutton.dart';
import 'package:e_commerce/view/widget/auth/customtextandtitle.dart';
import 'package:e_commerce/view/widget/auth/customtextfiledloginandsigin.dart';
import 'package:e_commerce/view/widget/auth/texttap.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImplement loginControllerImplement =
        Get.put(LoginControllerImplement());
    return Scaffold(
      body: GetBuilder<LoginControllerImplement>(builder: (controller)=>
         HandlingDataRequest(statusRequest: controller.statusRequest, widget:
          Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: AppColor.boxDecoration,
        child: SafeArea(
          child: Form(
            key: loginControllerImplement.formState,
            child: ListView(
              children: [
                const SizedBox(height: 10),
                Image.asset(AppImageAsset.logo),
                const SizedBox(height: 20),
                CustomTextAndTitle(
                  text: "text2".tr,
                  title: "title2".tr,
                ),
                const SizedBox(height: 50),
                CustomTextFiledSigInAndSignup(
                  validator: (val) {
                    return validatorInput(val!, 6, 30, "email");
                  },
                  keyboardType: TextInputType.emailAddress,
                  hintText: "hint1".tr,
                  label: "label1".tr,
                  prefixIcon: const Icon(Icons.email_outlined),
                  myController: loginControllerImplement.email,
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                Obx(
                      () => CustomTextFiledSigInAndSignup(
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginControllerImplement.showPassword();
                      },
                      icon: Icon(
                        loginControllerImplement.isChangeVisibilities.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: (val) {
                      return validatorInput(val!, 6, 30, "");
                    },
                    keyboardType: TextInputType.text,
                    hintText: "hint2".tr,
                    label: "label2".tr,
                    prefixIcon: const Icon(Icons.lock_outline),
                    myController: loginControllerImplement.password,
                    obscureText:
                    !loginControllerImplement.isChangeVisibilities.value,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextTap(
                    text: "forgotPass".tr,
                    onTap: () {
                      loginControllerImplement.goToForgotPassword();
                    },
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 70),
                CustomButtonAuth(
                  onPressed: () {
                    loginControllerImplement.login();
                  },
                  childText: "button4".tr,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "text3".tr,
                      style:
                      const TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                    const SizedBox(width: 5),
                    TextTap(
                      text: "button3".tr,
                      onTap: () {
                        loginControllerImplement.goToSignup();
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
      ),)
    ));
  }
}
