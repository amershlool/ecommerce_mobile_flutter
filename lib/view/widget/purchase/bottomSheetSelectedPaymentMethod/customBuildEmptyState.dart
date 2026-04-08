import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/custom_build_add_new_card_button.dart';
import 'package:flutter/material.dart';

class CustomBuildEmptyState extends StatelessWidget {
  const CustomBuildEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return       Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            "No Payment Methods",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add a payment method to continue",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          CustomBuildAddNewCardButton(),
        ],
      ),
    );

  }
}
