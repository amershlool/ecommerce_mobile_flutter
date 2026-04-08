import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';

class CustomButtonCart extends StatelessWidget {
  final String textConfirm;
  final String textShopping;
  final void Function()? onPressedShopping;
  final void Function()? onPressedConfirm;

  const CustomButtonCart({
    super.key,
    required this.textConfirm,
    required this.textShopping,
    required this.onPressedShopping,
    required this.onPressedConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              width: 155,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(3)),
                border: Border.all(
                  color: AppColor.hotRed.withAlpha(200),
                  width: 1.5,
                ),
                color: AppColor.hotRed.withAlpha(20),
              ),
              child: MaterialButton(
                onPressed: onPressedShopping,
                child:  Text(
                  textShopping,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlayfairDisplay',
                    color: AppColor.hotRed,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Container(
              width: 155,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all( Radius.circular(3)),
                gradient: LinearGradient(
                  colors: [AppColor.hotRed, AppColor.hotRed2],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressedConfirm,
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    child: Text(
                      textConfirm,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
