import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomNoAddressCard extends StatelessWidget {
  final void Function()? onPressed;

  const CustomNoAddressCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.min,

        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColor.coldOrange.withAlpha(51),

              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.map_outlined,
              color: AppColor.hotRed,
              size: 80,
            ),
          ),
          const SizedBox(height: 30),

          Text(
            "No Saved Delivery Addresses!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.darkGray,
              fontFamily: 'PlayfairDisplay',
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 15),

          Text(
            "It looks like you haven't saved any delivery address yet. Add a new one for a smooth and fast shopping experience!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.grey,
              fontFamily: 'PlayfairDisplay',
              fontSize: 18,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.hotRed,

              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
            ),
            icon: const Icon(Icons.add_location_alt_rounded, size: 26),
            label: Text(
              "Add a New Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'PlayfairDisplay', // خط PlayfairDisplay
              ),
            ),
          ),
        ],
      ),
    );
  }
}
