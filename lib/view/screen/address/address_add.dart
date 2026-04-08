import 'package:e_commerce/controller/address_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/function/vaildinput_add_address.dart';
import 'package:e_commerce/view/widget/adderss/add/custom_card_switch.dart';
import 'package:e_commerce/view/widget/adderss/add/custom_elevated_button_saved.dart';
import 'package:e_commerce/view/widget/adderss/add/custom_screen_gps.dart';
import 'package:e_commerce/view/widget/adderss/add/custom_section_title.dart';
import 'package:e_commerce/view/widget/adderss/add/custom_text_form_field.dart';
import 'package:e_commerce/view/widget/adderss/coustom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressAdd extends StatelessWidget {
  const AddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressControllerImp());
    return Scaffold(

      appBar: customAppBar("Add Address"),
      body: GetBuilder<AddressControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCardSwitch(),
                  const SizedBox(height: 20),

                  // const SizedBox(height: 40),
                  Center(
                    child: CustomSectionTitle(title: "Address Information"),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    hintText: "Name Address",
                    controllerText: controller.nameAddress,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return validatorInputAddAddress(val!, 3, 30);
                    },
                    label: "Address",
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Address Description",
                    controllerText: controller.description,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return validatorInputAddAddress(val!, 5, 50);
                    },
                    label: "Description",
                    prefixIcon: Icons.description_outlined,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Example: 07x0000000",
                    controllerText: controller.phone,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      return validatorInputAddAddress(val!, 10, 15);
                    },
                    label: "Phone",
                    prefixIcon: Icons.phone,
                  ),

                  const SizedBox(height: 20),
                  controller.useGps
                      ? Center(
                          child: CustomSectionTitle(title: "Location From GPS"),
                        )
                      : Center(
                          child: CustomSectionTitle(title: "Location Details"),
                        ),
                  const SizedBox(height: 15),
                  controller.useGps
                      ? CustomScreenGps()
                      : Column(
                        children: [
                          CustomTextFormField(
                              hintText: "Example: Irbid, Amman",
                              controllerText: controller.city,
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                return validatorInputAddAddress(val!, 3, 10);
                              },
                              label: "City",
                              prefixIcon: Icons.location_city_outlined,
                            ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Example: Wasfi Al-Tal Street",
                            controllerText: controller.street,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              return validatorInputAddAddress(val!, 5, 30);
                            },
                            label: "Street",
                            prefixIcon: Icons.streetview_outlined,
                          ),
                          const SizedBox(height: 100),

                        ],
                      ),
                  SizedBox(height: 20,),

                  CustomElevatedButtonSaved(
                    onPressed: () {
                      controller.addAddress();
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print("--------------------------------------");
                      print(controller.phone);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
