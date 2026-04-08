import 'package:e_commerce/controller/paymenMethod/delete_paymentMethod_controller.dart';
import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/brand_to_cardType.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/payment_method/dialog_delete_payment_method.dart';
import 'package:e_commerce/view/widget/payment_method/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class PaymentMethods extends GetView<PaymentMethodeViewControllerImp> {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomSideMenu(),
      backgroundColor: Colors.grey[100],
      appBar: CustomAppbar(
        titleAppbar: "Payment Method",
        onPressedIconSearch: () {},
        onPressedIconAction: () {},
        iconAction: Icons.favorite_border_outlined,
        onChanged: (val) {},
        textEditingController: TextEditingController(),
        isSearch: false,
      ),
      body: HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: GetBuilder<PaymentMethodeViewControllerImp>(
          builder: (controller) {
            return ListView.builder(
              padding: const EdgeInsets.all(2),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final card = controller.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogDeletePaymentMethod(
                            cardNumber: controller.data[index].last4!,
                            onDelete: () async {
                              DeletePaymentMethodControllerImp
                              deletePaymentMethodControllerImp = Get.put(
                                DeletePaymentMethodControllerImp(),
                              );
                              deletePaymentMethodControllerImp
                                  .deletePaymentMethod(card.paymentMethodId!);
                            },
                          );
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        CreditCardWidget(
                          enableFloatingCard: false,
                          showBackView: false,
                          cardType: brandToCardTypeSwitch(card.brand),
                          cardNumber: "0000 0000 0000 ${card.last4}",
                          obscureInitialCardNumber: true,
                          expiryDate: "${card.expMonth}/${card.expYear}",
                          cardHolderName: card.name!,
                          onCreditCardWidgetChange: (_) {},
                          cardBgColor: AppColor.hotRed,
                          isHolderNameVisible: true,
                          height: 200,
                          cvvCode: '***',
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              controller.selectedCardDefault(
                                index,
                                card.paymentMethodId!,
                              );
                              controller.update();
                            },
                            child: Icon(
                              controller.selectedCardIndexDefault == index
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBarPayment(),
    );
  }
}
