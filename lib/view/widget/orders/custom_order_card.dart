import 'package:e_commerce/view/widget/orders/custom_card_Header.dart';
import 'package:e_commerce/view/widget/orders/custom_order_details_row.dart';
import 'package:e_commerce/view/widget/orders/custom_order_stepper.dart';
import 'package:e_commerce/view/widget/orders/custom_row_button.dart';
import 'package:flutter/material.dart';

class CustomOrderCard extends StatelessWidget {
  final String numberOrder;
  final String ordersTotalPrice;
  final String ordersStatus;
  final String ordersDate;
  final String? ordersCouponName;
  final String ordersItemsCount;
  final void Function()? onPressed;
  final void Function()? onPressedRe;

  const CustomOrderCard({
    super.key,
    required this.numberOrder,
    required this.ordersTotalPrice,
    required this.ordersStatus,
    required this.ordersDate,
    required this.ordersCouponName,
    required this.ordersItemsCount,
    required this.onPressed,
    required this.onPressedRe,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          CustomOrderCardHeader(
            numberOrder: numberOrder,
            ordersTotalPrice: ordersTotalPrice,
            ordersStatus: ordersStatus =="-1"? "Pending":ordersStatus== "0"
                ? "Processing"
                : ordersStatus == "1"
                ? "Out for Delivery"
                : ordersStatus == "2"
                ? "Delivered"
                : "Cancelled",
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomOrderStepper(status: ordersStatus),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 16),
                CustomOrderDetailsRow(
                  icon: Icons.calendar_today,
                  label: 'Placed On ',
                  value: ordersDate,
                ),
                const SizedBox(height: 12),
                if (ordersCouponName != "null") ...[
                  CustomOrderDetailsRow(
                    icon: Icons.discount_outlined,
                    label: 'Discount Coupon ',
                    value: ordersCouponName!,
                    valueColor: Colors.green.shade600,
                  ),
                  const SizedBox(height: 12),
                ],

                CustomOrderDetailsRow(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Items Count ',
                  value: ordersItemsCount,
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 16),
                CustomRowButton(onPressed: onPressed, onPressedRe: onPressedRe, orderStatus: ordersStatus, ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
