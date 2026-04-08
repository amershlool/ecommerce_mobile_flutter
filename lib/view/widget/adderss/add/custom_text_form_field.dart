import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controllerText ;
  final TextInputType  keyboardType ;
  final String? Function(String?) validator;
  final String label;
  final IconData prefixIcon;



  const CustomTextFormField({super.key, required this.hintText, required this.controllerText, required this.keyboardType, required this.validator, required this.label, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(70),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controllerText,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          color: AppColor.grey,
          fontSize: 16,
          fontFamily: 'Cairo',
        ),

        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.grey.withAlpha(179),
            fontFamily: 'Cairo',
          ),
          errorStyle: TextStyle(color: Colors.brown,fontSize: 13,fontWeight: FontWeight.bold,fontFamily: 'PlayfairDisplay'),

          prefixIcon: Icon(prefixIcon, color: AppColor.hotRed, size: 22),
          floatingLabelStyle: const TextStyle(
            color: AppColor.hotRed,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          labelStyle: const TextStyle(
            color: AppColor.grey,
            fontFamily: 'Cairo',
          ),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColor.hotRed2,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.hotRed,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
