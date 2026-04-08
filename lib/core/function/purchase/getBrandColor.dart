import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';

Color getBrandColor (String brand){
  switch(brand.toLowerCase()){
    case 'visa':
      return const Color(0xFF1A1F71);
    case 'mastercard':
      return const Color(0xFFEB001B);
    case 'amex':
      return const Color(0xFF002663);
    case 'discover':
      return const Color(0xFFFF6000);
    default:
      return AppColor.hotRed;

  }
}