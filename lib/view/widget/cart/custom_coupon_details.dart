import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCouponDetails extends StatelessWidget {
  final String couponName;
  final void Function()? onPressedRemove;
  final String couponExpireDate;

  const CustomCouponDetails({
    super.key,
    required this.couponName,
    required this.onPressedRemove,
    required this.couponExpireDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
    DateFormat('dd MMM yyyy').format(DateTime.parse(couponExpireDate));

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.local_offer,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coupon Code: $couponName',
                  style: TextStyle(
                    color: AppColor.darkGray,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.orange.shade600,
                    ),
                    const SizedBox(width: 4),
                   Text(
                      formattedDate,
                      style: TextStyle(
                        color: AppColor.darkGray.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressedRemove,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Colors.red,
              minimumSize: const Size(20, 20),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            child: const Icon(
              Icons.close,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
