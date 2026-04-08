import 'package:e_commerce/controller/paymenMethod/paymentAdd_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarPayment extends GetView<PaymentMethodeAddControllerImp> {

  const BottomNavigationBarPayment({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.hotRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.add_card, color: Colors.white),
          label: const Text(
            'إضافة بطاقة',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.addPaymentMethods);
          },
        ),
      ),
    );
  }
}
