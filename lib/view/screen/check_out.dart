// check_out_page.dart
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/checkout_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/adderss/coustom_appbar.dart';
import 'package:e_commerce/view/widget/cart/custom_bottom_navigation_bar_cart.dart';
import 'package:e_commerce/view/widget/cart/custom_botton_coupon.dart';
import 'package:e_commerce/view/widget/cart/custom_show_full_invoice_bottom_sheet.dart';
import 'package:e_commerce/view/widget/purchase/custom_selected_address_bottom_sheet.dart';
import 'package:e_commerce/view/widget/purchase/custom_selected_paymentMethod_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/view/widget/purchase/custom_address_card.dart';
import 'package:e_commerce/view/widget/purchase/custom_build_card.dart';
import 'package:e_commerce/view/widget/purchase/custom_radio_group.dart';

class CheckOut extends GetView<CheckoutControllerImp> {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartControllerImp>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar("Confirm Purchase"),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomBuildCardCheckOut(
              title: "🚚 Delivery Method",
              child: GetBuilder<CheckoutControllerImp>(
                builder: (controller) => CustomRadioGroup(
                  currentValue: controller.deliveryMethod,
                  options: const ["Delivery", "From Store"],
                  onChanged: controller.chooseDeliveryMethod,
                ),
              ),
            ),
            const SizedBox(height: 5),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => controller.deliveryMethod == "Delivery"
                  ? CustomBuildCardCheckOut(
                      title: "📍 Delivery Address",
                      child:
                          controller.selectedAddress?.addressName == null ||
                              controller.selectedAddress!.addressName!.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Please choose the delivery address",
                                  style: TextStyle(
                                    color: AppColor.darkGray,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25),
                                        ),
                                      ),
                                      builder: (context) =>
                                          CustomSelectedAddressBottomSheet(
                                            addresses: controller
                                                .addressControllerImp
                                                .data,
                                            onSelected: (selected) {
                                              controller.chooseShippingAddress(
                                                selected,
                                              );
                                            },
                                          ),
                                    );
                                  },
                                  child: Text(
                                    "Choose",
                                    style: TextStyle(
                                      color: AppColor.hotRed2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : CustomAddressCard(
                              addressName:
                                  controller.selectedAddress!.addressName!,
                              addressCity:
                                  controller.selectedAddress!.addressCity!,
                              addressPhone:
                                  "0${controller.selectedAddress?.addressPhone}",
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  builder: (context) =>
                                      CustomSelectedAddressBottomSheet(
                                        addresses: controller
                                            .addressControllerImp
                                            .data,
                                        onSelected: (selected) {
                                          controller.chooseShippingAddress(
                                            selected,
                                          );
                                        },
                                      ),
                                );
                              },
                            ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 5),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => controller.deliveryMethod == "Delivery"
                  ? CustomBuildCardCheckOut(
                      title: "🕒 Delivery Time",
                      child: CustomRadioGroup(
                        currentValue: controller.deliveryTime,
                        options: const [
                          "Morning (8am - 12pm)",
                          "Afternoon (12pm - 4pm)",
                          "Evening (4pm - 8pm)",
                        ],
                        onChanged: controller.chooseDeliveryTime,
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 5),
            CustomBuildCardCheckOut(
              title: "💳 Payment Method",
              child: GetBuilder<CheckoutControllerImp>(
                builder: (controller) => CustomRadioGroup(
                  currentValue: controller.paymentMethod,
                  options: const ["Cash", "Credit Card"],
                  onChanged: controller.choosePaymentMethod,
                ),
              ),
            ),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) {
                if (controller.paymentMethod != "Credit Card") {
                  return const SizedBox();
                }

                return CustomBuildCardCheckOut(
                  title: "💳 Choose Payment Card",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          controller.selectedPaymentMethods == null
                              ? "Choose the payment card you want to use for this purchase."
                              : "Payment card selected successfully",
                          style: TextStyle(
                            color: controller.selectedPaymentMethods == null
                                ? AppColor.darkGray
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            builder: (context) {
                              return const CustomSelectedPaymentMethodBottomSheet();
                            },
                          );
                        },
                        child: Text(
                          controller.selectedPaymentMethods == null
                              ? "Choose"
                              : "Edit",
                          style: TextStyle(
                            color: AppColor.hotRed2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            CustomBuildCardCheckOut(
              title: "📝 Order Notes",
              child: TextFormField(
                controller: controller.notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any special instructions?",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: GetBuilder<CheckoutControllerImp>(
        builder: (checkoutController) =>
            CustomBottomNavigationBarCart(
          price: checkoutController.cartControllerImp.totalPrice
              .toStringAsFixed(2),
          discount: "${checkoutController.discountCoupon}%",
          totalPrice: checkoutController.getTotalPrice().toString(),
          shipping: checkoutController.priceShipping.toString(),
          onCheckout: () {
            checkoutController.checkOut();
          },
          onViewInvoice: () {
            _showProfessionalInvoice(
              context: context,
              cartController: cartController,
              checkoutController: checkoutController,
              userName:
                  "${checkoutController.myServices.sharedPref.getString("username")}",
              userEmail:
                  "${checkoutController.myServices.sharedPref.getString("email")}",
            );
          },
        ),
      ),
    );
  }

  void _showProfessionalInvoice({
    required BuildContext context,
    required CartControllerImp cartController,
    required CheckoutControllerImp checkoutController,
    required String userName,
    required String userEmail,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfessionalCartInvoice(
        cartItems: cartController.data,
        subtotal: cartController.totalPrice,
        discountAmount: cartController.totalDiscount,
        shippingCost: checkoutController.priceShipping,
        taxAmount: 0.0,
        totalAmount: checkoutController.getTotalPrice(),
        userName: userName,
        userEmail: userEmail,
        couponCode: checkoutController.couponName,
        couponDiscount: checkoutController.discountCouponAmount,
        onProceedToCheckout: () {
          Navigator.pop(context);
          checkoutController.checkOut();
        },
        onContinueShopping: () {
          Navigator.pop(context);
          cartController.goToShopping();
        },
      ),
    );
  }
}
