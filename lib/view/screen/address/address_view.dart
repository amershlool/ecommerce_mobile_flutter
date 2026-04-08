import 'package:e_commerce/controller/address_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/adderss/coustom_address_card.dart';
import 'package:e_commerce/view/widget/adderss/coustom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    AddressControllerImp addressControllerImp = Get.put(AddressControllerImp());
    return Scaffold(
      appBar: customAppBar("Address"),
      body: GetBuilder<AddressControllerImp>(
        builder: (controller) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15),
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: CustomAddressCard(
                onEdit: () {
                  controller.goToPageAddressEdit(controller.data[index]);
                },
                onDelete: () {
                  controller.deleteAdderss(
                    controller.data[index].addressId.toString(),
                  );
                },
                onTap: () {},
                titleAddress: controller.data[index].addressName!,
                subTitleAddress: controller.data[index].addressDescription!,
                street: controller.data[index].addressStreet!,
                city: controller.data[index].addressCity!,
                country: "Jordan",
                phoneNumber: "${controller.data[index].addressPhone}",
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        shape: const CircleBorder(),
        onPressed: () {
          addressControllerImp.goToPageAddressAdd();
        },
        backgroundColor: AppColor.hotRed,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
