import 'package:e_commerce/controller/paymenMethod/paymentAdd_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSaveCreditCard extends GetView<PaymentMethodeAddControllerImp> {
  const ButtonSaveCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.hotRed,
        elevation: 2,
        padding: EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: AppColor.hotRed.withValues(alpha: 0.3),
      ),
      onPressed: () {
        controller.checkingCustomer();
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.save_rounded, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
