import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonSaved extends StatelessWidget {
  final void Function() onPressed;

  const CustomElevatedButtonSaved({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:  [AppColor.hotRed2,AppColor.hotRed],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.save_outlined, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
