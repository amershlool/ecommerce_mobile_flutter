import 'package:e_commerce/controller/paymenMethod/paymentAdd_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataEntryForm extends StatelessWidget {
  const DataEntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.hotRed.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.credit_card_rounded,
                    color: AppColor.hotRed,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'معلومات البطاقة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.hotRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GetBuilder<PaymentMethodeAddControllerImp>(
              builder: (controller) {
                return Form(
                  key: controller.formState,
                  child: Column(children: [
                    //Card number field
                    Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'رقم البطاقة',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.hotRed,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: AppColor.hotRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                                color: Colors.grey[50],
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '1234 5678 9012 3456',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  suffixIcon: Icon(Icons.credit_card_rounded, color: Colors.grey[400]),
                                ),
                                onChanged: (value) {
                                  controller.cardNumberAdd.text = value ;
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
                              ),
                            ),

                          ],
                        )
                      ],
                    )
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
