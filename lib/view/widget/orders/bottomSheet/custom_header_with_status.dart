import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CustomHeaderWithStatus extends StatelessWidget {
  final String orderStatus;

  final String orderNumber;

  final String orderTotal;
  final String date;

  const CustomHeaderWithStatus({
    super.key,
    required this.orderStatus,
    required this.orderNumber,
    required this.orderTotal,
    required this.date,
  });

  Color getBackgroundColor() {
    switch (orderStatus) {
      case "Pending":
        return Colors.orange.withAlpha(100);
      case "Processing":
        return AppColor.hotRed.withAlpha(51);
      case "Out for Delivery":
        return Colors.blue.withAlpha(51);
      case "Delivered":
        return Colors.green.withAlpha(51);
      case "Cancelled":
        return Colors.grey.withAlpha(51);
      default:
        return Colors.green.withAlpha(51);
    }
  }

  Color getStatusColor() {
    switch (orderStatus) {
      case "Pending":
        return Colors.orange.withAlpha(150);
      case "Processing":
        return AppColor.hotRed;
      case "Out for Delivery":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        // color: AppColor2.primary.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        gradient: LinearGradient(
          colors: [AppColor.hotRed, AppColor.hotRed2],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Order details',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: getBackgroundColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  orderStatus,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),

              Text(
                Jiffy.parse(date).fromNow(),
                style: TextStyle(
                  fontFamily: 'BalooBhaijaan',
                  color: AppColor.darkGray,
                ),
              ),

              const Spacer(),
              Column(
                children: [
                  Text(
                    "#$orderNumber",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkGray,
                    ),
                  ),
                  Text(
                    'Total: $orderTotal jd',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColor.hotRed2,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
