import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';

import 'build_detail_row.dart';
import 'custom_show_languge_Dialoh.dart';

void showInvoiceItemsDetailsSheetBottom(
    BuildContext context, {
      required String productName,
      required double unitPrice,
      required int quantity,
      required String imagePath,
      required String nameUser,
      required double itemTotalPrice,
    }) {
  String currentInvoiceLanguage = "العربية";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Text(
              "Product Details",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColor.hotRed2,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
            const Divider(color: AppColor.grey, thickness: 0.5, height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl:"${AppLink.imageItems}/$imagePath" ,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        productName,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColor.darkGray,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayfairDisplay',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // customShowLanguageDialog(context, currentInvoiceLanguage);
                        },
                        borderRadius: BorderRadius.circular(10),
                        splashColor: AppColor.hotRed.withOpacity(0.1),
                        highlightColor: AppColor.hotRed.withOpacity(0.05),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.language, color: AppColor.hotRed, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                "لغة الفاتورة: $currentInvoiceLanguage",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColor.darkGray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down, color: AppColor.grey, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.hotRed.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.hotRed.withOpacity(0.3), width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "عزيزي $nameUser، هذه فاتورتك لهذا المنتج:",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColor.darkGray,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const Divider(color: AppColor.hotRed, thickness: 1, height: 25),
                          buildDetailRow(
                            context,
                            label: "اسم المنتج:",
                            value: productName,
                            valueColor: AppColor.darkGray,
                            isBold: true,
                          ),
                          buildDetailRow(
                            context,
                            label: "سعر الوحدة:",
                            value: "${unitPrice.toStringAsFixed(2)} \$",
                            valueColor: AppColor.hotRed,
                          ),
                          buildDetailRow(
                            context,
                            label: "الكمية المشتراة:",
                            value: quantity.toString(),
                            valueColor: AppColor.darkGray,
                          ),
                          const Divider(color: AppColor.hotRed, thickness: 1, height: 25),
                          buildDetailRow(
                            context,
                            label: "إجمالي هذا المنتج:",
                            value: "${itemTotalPrice.toStringAsFixed(2)} \$",
                            valueColor: AppColor.hotRed2,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Description:",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.darkGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "This is a detailed description of the Meskar pwdra product. It is known for its high quality and unique features that make it an excellent choice for daily use. (هنا يمكنك إضافة وصف أكثر تفصيلاً للمنتج)",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColor.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
