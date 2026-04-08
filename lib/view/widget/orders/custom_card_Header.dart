import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomOrderCardHeader extends StatelessWidget {
  final String numberOrder;
  final String ordersTotalPrice;
  final String ordersStatus;

  const CustomOrderCardHeader({
    super.key,
    required this.numberOrder,
    required this.ordersTotalPrice,
    required this.ordersStatus,
  });

  Color getBackgroundColor() {
    switch (ordersStatus) {
      case "Pending":
        return Colors.orange.withAlpha(51);
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
    switch (ordersStatus) {
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: getBackgroundColor(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Number: #$numberOrder",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Price: ",
                    style: TextStyle(
                      color: getStatusColor(),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      ordersTotalPrice,
                      style: TextStyle(
                        color: getStatusColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'BalooBhaijaan',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getStatusColor(),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              ordersStatus,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
