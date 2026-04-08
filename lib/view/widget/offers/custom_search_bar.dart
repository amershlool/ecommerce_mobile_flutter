import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10,left: 10,bottom: 20),
      child: Form(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColor.darkGray.withAlpha(150),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            decoration: InputDecoration(

              hintText: "Search for offers",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              prefixIcon: Icon(Icons.search, color: AppColor.hotRed),
              suffixIcon: Icon(Icons.filter_list, color: AppColor.hotRed),
            ),
          ),
        ),
      ),
    );
  }
}
