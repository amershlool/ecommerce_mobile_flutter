import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonConfirm extends StatelessWidget {
  final void Function() onPressed;

  const CustomElevatedButtonConfirm({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.hotRed2, AppColor.hotRed],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 50,
            // width: 30,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.done, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Confirm Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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
