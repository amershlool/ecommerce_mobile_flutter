import 'package:flutter/material.dart';

List<Color> getBrandGradient(String brand) {
switch (brand.toLowerCase()){
  case 'visa':
    return [
      const Color(0xFF1A1F71),
      const Color(0xFF4364F7),
      const Color(0xFF6FB1FC),
    ];
  case 'mastercard':
    return [
      const Color(0xFFEB001B),
      const Color(0xFFF79E1B),
      Colors.orange,
    ];
  case 'amex':
    return [
      const Color(0xFF002663),
      const Color(0xFF2D5FDE),
      const Color(0xFF6FB1FC),
    ];
  case 'discover':
    return [
      const Color(0xFFFF6000),
      Colors.orangeAccent,
      const Color(0xFFFFD700),
    ];
  default:
    return [
      Colors.grey.shade700,
      Colors.grey.shade500,
      Colors.grey.shade400,
    ];

}
}