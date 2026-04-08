import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/orders/view_order_details_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_coupon_card.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_draghandle.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_header_with_status.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_info_customer_information.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_orders_summary.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_section_title.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_time_line.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_orders_product_items.dart';
import 'package:flutter/material.dart';

class CustomOrderDetailsBottomSheet extends StatelessWidget {
  final String orderId;
  final List<OrdersDetailsModel> ordersDetails;

  const CustomOrderDetailsBottomSheet({
    super.key,
    required this.orderId,
    required this.ordersDetails,
  });

  @override
  Widget build(BuildContext context) {
    final orderInfo = ordersDetails.first;
    return FractionallySizedBox(
      heightFactor: 0.89,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // Header with status
            CustomHeaderWithStatus(
              orderStatus: orderInfo.ordersStatus == -1
                  ? "Pending"
                  : orderInfo.ordersStatus == 0
                  ? "Processing"
                  : orderInfo.ordersStatus == 1
                  ? "Out for Delivery"
                  : orderInfo.ordersStatus == 2
                  ? "Delivered"
                  : "Cancelled",
              orderNumber: orderInfo.ordersId.toString(),
              orderTotal: orderInfo.ordersPrice!.toStringAsFixed(2),
              date: orderInfo.orderDatetime!,
            ),
            // Drag handle
            CustomDragHandle(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTimeLine(
                      isCompleted1: orderInfo.ordersStatus! >= 0,
                      isCompleted2: orderInfo.ordersStatus! >= 0,
                      isCompleted3: orderInfo.ordersStatus! >= 1,
                      isCompleted4: orderInfo.ordersStatus! >= 2,
                      isCancelled: orderInfo.ordersStatus! >= 3,
                    ),
                    const SizedBox(height: 15),

                    // Products Section
                    CustomSectionTitleSheet(title: 'Purchases'),
                    ...ordersDetails.map(
                      (product) => CustomOrdersProductItems(
                        nameItems: product.itemsNameEn.toString(),
                        quantityItems: product.quantityItems.toString(),
                        priceItems: product.totalPriceSingleItem.toString(),
                        itemsImageUrl:
                            "${AppLink.imageItems}/${product.itemsImageURl}",
                        productDescription: product.itemsDescriptionEn
                            .toString(),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Order Summary
                    CustomOrdersSummary(
                      label: "Total Price Items",
                      price: orderInfo.totalPriceItems.toString(),
                      isGrandTotal: false,
                    ),
                    if (orderInfo.couponDiscount != null) ...[
                      CustomOrdersSummary(
                        label: "Discount ",
                        price: "${orderInfo.couponDiscount}",
                        isGrandTotal: false,
                        unit: '%',
                      ),
                    ],
                    if (orderInfo.ordersPriceDelivery != 0) ...[
                      CustomOrdersSummary(
                        label: "Delivery Fee",
                        price: orderInfo.ordersPriceDelivery.toString(),
                        isGrandTotal: false,
                      ),
                    ],
                    Divider(
                      color: AppColor.coldOrange,
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),

                    CustomOrdersSummary(
                      label: "Grand Total",
                      price: orderInfo.ordersPrice!.toStringAsFixed(2),
                      isGrandTotal: true,
                    ),
                    Divider(
                      color: AppColor.coldOrange,
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),

                    const SizedBox(height: 20),
                    // Customer Info
                    CustomSectionTitleSheet(title: 'Customer information'),
                    const SizedBox(height: 16),
                    CustomInfoCustomerInformation(
                      icon: Icons.person_outline,
                      label: "Name",
                      value: orderInfo.usersName.toString(),
                    ),
                    if (orderInfo.addressPhone != null) ...[
                      CustomInfoCustomerInformation(
                        icon: Icons.phone_android,
                        label: "Phone",
                        value: orderInfo.addressPhone.toString(),
                      ),
                      CustomInfoCustomerInformation(
                        icon: Icons.location_on,
                        label: "Location",
                        value:
                            "${orderInfo.addressStreet}-${orderInfo.addressCity}",
                      ),
                    ],
                    CustomInfoCustomerInformation(
                      icon: Icons.calendar_today,
                      label: "Order Date",
                      value: orderInfo.orderDatetime.toString(),
                    ),

                    // Coupon Section
                    if ((orderInfo.couponName ?? "").isNotEmpty) ...[
                      CustomCouponCard(couponName: orderInfo.couponName!),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
