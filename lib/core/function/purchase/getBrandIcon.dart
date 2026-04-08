import 'package:flutter/material.dart';

IconData getBrandIcon(String brand) {
  switch (brand.toLowerCase()) {
    case 'visa':
      return Icons.credit_card_rounded;
    case 'mastercard':
      return Icons.payment_rounded;
    case 'amex':
      return Icons.diamond_rounded;
    case 'discover':
      return Icons.explore_rounded;
    default:
      return Icons.credit_score_rounded;
  }
}
