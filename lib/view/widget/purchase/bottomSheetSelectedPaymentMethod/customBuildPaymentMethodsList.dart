import 'package:e_commerce/controller/checkout_controller.dart';
import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/purchase/getBrandColor.dart';
import 'package:e_commerce/core/function/purchase/getBrandGradient.dart';
import 'package:e_commerce/core/function/purchase/getBrandIcon.dart';
import 'package:e_commerce/view/widget/purchase/bottomSheetSelectedPaymentMethod/customBuildEmptyState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomBuildPaymentMethodsList extends StatelessWidget {
  const CustomBuildPaymentMethodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodeViewControllerImp>(
      builder: (controller) {
        if (controller.data.isEmpty) {
          return CustomBuildEmptyState();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: controller.data.length,

          itemBuilder: (context, index) {
            final card = controller.data[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  final  checkoutController = Get.find<CheckoutControllerImp>();
                  checkoutController.choosePaymentCard(card);
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: getBrandGradient(card.brand!),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: getBrandColor(
                                  card.brand!,
                                ).withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              getBrandIcon(card.brand!),
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Card Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    card.brand!.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.darkGray,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "•••• •••• •••• ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    card.last4!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.grey.shade500,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Expires ${card.expMonth!
                                        .toString()
                                        .padLeft(2, '0')}/${card.expYear!
                                        .toString().substring(2)}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
