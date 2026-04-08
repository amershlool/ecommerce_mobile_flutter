import 'package:e_commerce/controller/settings_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageasset.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends GetView<SettingsControllerImp> {
  final bool showIs;

  const Settings({super.key, this.showIs = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showIs
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: AppColor.hotRed,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text(
                "Settings".tr,
                style: TextStyle(
                  color: AppColor.hotRed,
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 30,
                ),
              ),
              centerTitle: true,
            )
          : null,

      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: Get.width / 2.5,
                decoration: BoxDecoration(
                  color: AppColor.hotRed,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                top: Get.width / 4,
                child: CircleAvatar(
                  backgroundColor: AppColor.hotRed,
                  backgroundImage: AssetImage(AppImageAsset.profile3),
                  radius: 60,
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "Account".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.edit),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.changePassword);
                    },
                    title: Text(
                      "ChangePassword".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.lock_outline),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.paymentMethods);
                      print("PaymentMethods");
                    },
                    title: Text(
                      "PaymentMethods".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.payment),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.ordersHistory);
                    },
                    title: Text(
                      "OrderHistory".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.history),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "GeneralPreferences".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.settings_outlined),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "DisableNotifications".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: false,
                        onChanged: (value) {},
                        activeTrackColor: AppColor.hotRed.withAlpha(250),
                        inactiveTrackColor: AppColor.grey.withAlpha(100),
                        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.addressView);
                    },
                    title: Text(
                      "Addresses".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.location_on_outlined),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "AboutUs".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.info_outline),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () async {
                      await launchUrl(Uri.parse("tel:+962772936230"));
                    },
                    title: Text(
                      "ContactUs".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.headset_mic_outlined),
                  ),
                  Divider(),

                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    title: Text(
                      "LogOut".tr,
                      style: TextStyle(fontFamily: 'PlayfairDisplay'),
                    ),
                    trailing: Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
