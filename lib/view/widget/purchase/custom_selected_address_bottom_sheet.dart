import 'package:e_commerce/controller/address_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/data/model/address_model.dart';
import 'package:e_commerce/view/widget/purchase/custom_no_address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelectedAddressBottomSheet extends StatelessWidget {
  final List<AddressModel> addresses;
  final void Function(AddressModel adress) onSelected;

  const CustomSelectedAddressBottomSheet({
    super.key,
    required this.addresses,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressControllerImp>(
      builder: (controoler) => Container(
        child: addresses.isEmpty
            ? CustomNoAddressCard(
                onPressed: () {
                  Get.toNamed(AppRoutes.addressAdd);
                },
              )
            : Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColor.hotRed2.withAlpha(200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Choose delivery address",
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                        color: AppColor.hotRed2,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColor.coldOrange.withAlpha(200),
                                width: 1,
                              ),
                            ),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                onSelected(address);
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Get.back();
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: AppColor.hotRed,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address.addressName!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.hotRed2,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${address.addressStreet}, ${address.addressCity}, Jordan',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor.grey,
                                              fontFamily: 'PlayfairDisplay',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "0${address.addressPhone.toString()}",
                                            style: TextStyle(
                                              color: AppColor.darkGray,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: AppColor.grey,
                                      size: 24,
                                    ),
                                    // أيقونة اختيار (يمكن تغييرها عند الاختيار الفعلي)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
