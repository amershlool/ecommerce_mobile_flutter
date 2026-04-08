import 'package:e_commerce/view/widget/profile/custom_item_action.dart';
import 'package:flutter/material.dart';

class CustomQuickActions extends StatelessWidget {
  const CustomQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomItemAction(
                icon: Icons.qr_code_scanner_rounded,
                title: "كود الخصم",
                color: const Color(0xFFCC0000),
              ),
              CustomItemAction(
                icon: Icons.account_balance_wallet_rounded,
                title: "المحفظة",
                color: const Color(0xFFFF6B6B),
              ),
              CustomItemAction(
                icon: Icons.local_offer_rounded,
                title: "العروض",
                color: const Color(0xFFFFD166),
              ),
              CustomItemAction(
                icon: Icons.help_center_rounded,
                title: "الدعم",
                color: const Color(0xFFFF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
