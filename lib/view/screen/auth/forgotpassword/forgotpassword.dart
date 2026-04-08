import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/forgetpassword/forgetpassword_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/validinputsignup.dart';
import 'package:e_commerce/view/widget/auth/custombutton.dart';
import 'package:e_commerce/view/widget/auth/customtextfiledloginandsigin.dart';
import 'package:e_commerce/view/widget/forgotpassword/custombuttonforgot.dart';
import 'package:e_commerce/view/widget/forgotpassword/customtext.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
        Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text(
          "appbar".tr,
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white60,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(builder: (controller)=>
         HandlingDataRequest(statusRequest: controller.statusRequest, widget:
          Container(
        decoration: AppColor.boxDecoration,
        child: Form(
          key:controller.formState,
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: CustomTextForgot(
                  test: 'text8'.tr,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextFiledSigInAndSignup(
                validator: (val){
                  return validatorInput(val!, 6, 40, "email");
                },
                hintText: "hint1".tr,
                label: "label1".tr,
                prefixIcon: const Icon(Icons.email),
                myController: controller.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextForgot(
                test: "text7".tr,
                fontSize: 16,
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
                    controller.checkEmail();
                  },
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Center(
                child: Text(
                  "text3".tr,
                  style: const TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ),
              CustomButtonAuth(
                  onPressed: () {
Get.offNamed(AppRoutes.signup);
},
                  childText: "button3".tr),
            ],
          ),
        ),
      ),)
    ));
  }
}
