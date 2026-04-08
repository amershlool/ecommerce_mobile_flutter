import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBarFeaturedProducts extends StatelessWidget {
  final TextEditingController textEditingController;

  final String hintText;

  const CustomSearchBarFeaturedProducts(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: textEditingController,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppColor.darkGray.withAlpha(200),fontWeight: FontWeight.bold),
                prefixIcon: Icon(Iconsax.search_normal,color: AppColor.hotRed,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,

                ),
                filled: true,
                fillColor: AppColor.darkGray.withAlpha(10),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                suffixIcon: value.text.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    textEditingController.clear();
                  },
                  icon: Icon(Icons.close,color: AppColor.hotRed,),
                )
                    : null,
              ),
            ),
          );
        },
      );
  }
}
