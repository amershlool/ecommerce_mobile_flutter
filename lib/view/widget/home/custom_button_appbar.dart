import 'package:e_commerce/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonAppbar extends GetView<HomeScreenControllerImp> {
  final void Function()? onPressed;

  final String textButton;

  final Color colorItemSelected;

  final Color colorItemUnSelected;

  final Color colorTextSelected;

  final Color colorTextUnSelected;

  final bool active;

  final int index;

  const CustomButtonAppbar({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.colorItemSelected,
    required this.colorTextSelected,
    required this.colorItemUnSelected,
    required this.colorTextUnSelected,
    required this.active,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active
                ? controller.iconBottomAppbar[index]
                : controller.iconBottomAppbarOutLined[index],
            color: active ? colorItemSelected : colorItemUnSelected,
          ),
          Text(
            textButton,
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              color: active ? colorTextSelected : colorTextUnSelected,
            ),
          ),
        ],
      ),
    );
  }
}
