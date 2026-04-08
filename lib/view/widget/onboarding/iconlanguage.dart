import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/localization/changelocal.dart';
import 'package:e_commerce/view/widget/language/custombuttonlanguage.dart';

class IconLanguage extends GetView<LocalController> {
  const IconLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('titleLang'.tr,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 20),
                    CustomButtonLang(
                        text: "العربية",
                        onPressed: () {
                          controller.changeLang("ar");
                          Get.back();
                        }),
                    CustomButtonLang(
                        text: "English",
                        onPressed: () {
                          controller.changeLang("en");
                          Get.back();
                        }),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.language,
          size: 35,
          color: AppColor.hotRed,
        ),
      ),
    );
  }
}
