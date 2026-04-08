import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/customBuildDivider.dart';
import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/customBuildHeader.dart';
import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/customBuildPaymentMethodsList.dart';
import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/custom_build_footer.dart';
import 'package:flutter/material.dart';

class CustomSelectedPaymentMethodBottomSheet extends StatelessWidget {
  const CustomSelectedPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Column(
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          CustomBuildHeader(),
          const SizedBox(height: 5),
          CustomBuildDivider(),
          CustomBuildPaymentMethodsList(),
          CustomBuildFooter(),
        ],
      ),
    );
  }
}
