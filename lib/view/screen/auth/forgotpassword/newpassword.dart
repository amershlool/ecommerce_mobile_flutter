import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/forgetpassword/resetpassword_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/validinputsignup.dart';
import 'package:e_commerce/view/widget/auth/customtextfiledloginandsigin.dart';
import 'package:e_commerce/view/widget/forgotpassword/custombuttonforgot.dart';
import 'package:e_commerce/view/widget/forgotpassword/customtext.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
        Get.put(ResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text(
          "appbar3".tr,
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white60,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>
          HandlingDataRequest(statusRequest: controller.statusRequest, widget:

          Container(
        width: double.infinity,
        decoration: AppColor.boxDecoration,
        child: Form(
          key: controller.formState,
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: CustomTextForgot(test: "text12".tr, fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextFiledSigInAndSignup(
                validator: (val){
                  return validatorInput(val!, 6, 30, "");
                },
                keyboardType: TextInputType.number,
                hintText: "hint2".tr,
                label: "label2".tr,
                prefixIcon: const Icon(Icons.lock_outline),
                myController: controller.password,
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiledSigInAndSignup(
                validator: (val){
                  return validatorInput(val!, 6, 30, "");
                },
                keyboardType: TextInputType.number,
                hintText: "hint3".tr,
                label: "label3".tr,
                prefixIcon: const Icon(Icons.lock_clock_outlined),
                myController: controller.rPassword,
                obscureText: false,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: CustomButtonForgot(
                  text: 'button5'.tr,
                  onPressed: () {
                    controller.goToSuccessResetPassword(controller.password.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),)
    ));
  }
}
