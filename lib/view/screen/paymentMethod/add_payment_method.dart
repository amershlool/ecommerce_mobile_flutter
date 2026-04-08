import 'package:e_commerce/controller/paymenMethod/paymentAdd_controller.dart';
import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/adderss/coustom_appbar.dart';
import 'package:e_commerce/view/widget/payment_method/add/buildTitle.dart';
import 'package:e_commerce/view/widget/payment_method/add/build_text_field.dart';
import 'package:e_commerce/view/widget/payment_method/add/button_back.dart';
import 'package:e_commerce/view/widget/payment_method/add/button_save_credit_card.dart';
import 'package:e_commerce/view/widget/payment_method/add/card_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class AddPaymentMethod extends GetView<PaymentMethodeAddControllerImp> {
  const AddPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentMethodeViewControllerImp(), permanent: true);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: customAppBar("Add New Card"),
      body: GetBuilder<PaymentMethodeAddControllerImp>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      CreditCardWidget(
                        cardNumber: controller.cardNumberAdd.text,
                        expiryDate: controller.expiryDate.text,
                        cardHolderName: controller.cardHolderName.text,
                        cvvCode: controller.cvvCode.text,
                        showBackView: controller.isCvvFocused,
                        cardBgColor: AppColor.hotRed,
                        onCreditCardWidgetChange: (_) {},
                        isHolderNameVisible: true,
                        isSwipeGestureEnabled: true,
                        enableFloatingCard: true,
                      ),
                      if (controller.cardNumberAdd.text.isNotEmpty ||
                          controller.expiryDate.text.isNotEmpty ||
                          controller.cardHolderName.text.isNotEmpty)
                        const CardStatusIndicator(),
                      const SizedBox(height: 5),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: controller.formState,
                            child: Column(
                              children: [
                                BuildTitle(title: "معلومات البطاقة"),
                                const SizedBox(height: 20),
                                BuildTextField(
                                  label: "رقم البطاقة",
                                  hintText: "1234 5678 9012 3456",
                                  icon: Icons.credit_card_rounded,
                                  onChanged: (value) {
                                    controller.cardNumberAdd.text = value;
                                    controller.update();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال رقم البطاقة';
                                    }
                                    if (value.replaceAll(' ', '').length < 16) {
                                      return 'رقم البطاقة يجب أن يكون 16 رقماً';
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                  maxLength: 16,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BuildTextField(
                                        label: "تاريخ الانتهاء",
                                        hintText: "MM/YY",
                                        icon: Icons.calendar_today_rounded,
                                        onChanged: (value) {
                                          controller.expiryDate.text = value;
                                          controller.update();
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إدخال تاريخ الانتهاء';
                                          }
                                          if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                                            return 'الصيغة الصحيحة: MM/YY';
                                          }
                                          return null;
                                        },
                                        obscureText: false,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: BuildTextField(
                                        label: "CVV",
                                        hintText: "123",
                                        icon: Icons.lock_outline_rounded,
                                        obscureText: true,
                                        onChanged: (value) {
                                          controller.cvvCode.text = value;
                                          controller.update();
                                        },
                                        onFocus: () {
                                          controller.isCvvFocused = true;
                                          controller.update();
                                        },
                                        onUnfocus: () {
                                          controller.isCvvFocused = false;
                                          controller.update();
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إدخال CVV';
                                          }
                                          if (value.length < 3) {
                                            return 'CVV يجب أن يكون 3 أرقام';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                BuildTextField(
                                  label: "اسم صاحب البطاقة",
                                  hintText: "AMER AL-SHLOOL",
                                  icon: Icons.person_outline_rounded,
                                  onChanged: (value) {
                                    controller.cardHolderName.text = value;
                                    controller.update();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال اسم صاحب البطاقة';
                                    }
                                    if (value.length < 3) {
                                      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Expanded(child: ButtonBack()),
                      const SizedBox(width: 16),
                      Expanded(child: ButtonSaveCreditCard()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
