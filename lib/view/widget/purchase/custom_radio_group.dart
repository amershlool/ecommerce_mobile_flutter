import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final String currentValue ;
  final List<String> options ;
  final void Function(String)? onChanged ;
  const CustomRadioGroup({super.key, required this.currentValue, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {

      return Column(
        children: options.map((option) {
          return RadioListTile<String>(
            title: Text(option,style: TextStyle(fontFamily: 'PlayfairDisplay',fontWeight: FontWeight.bold),),
            value: option,
            groupValue: currentValue,
            onChanged: (val) => onChanged!(val!),
            activeColor: AppColor.hotRed,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          );
        }).toList(),
      );
    }

  }

