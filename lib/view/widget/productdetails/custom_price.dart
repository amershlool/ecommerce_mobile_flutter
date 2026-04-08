// import 'package:e_commerce/controller/product_details_controller.dart';
// import 'package:e_commerce/core/function/items/calculate_discounted_price.dart';
// import 'package:e_commerce/view/widget/productdetails/custom_price_new.dart';
// import 'package:e_commerce/view/widget/productdetails/custom_price_old.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CustomPrice extends StatelessWidget {
//   const CustomPrice({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ProductDetailsControllerImp controller = Get.put(
//       ProductDetailsControllerImp(),
//     );
//
//     return                   Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CustomPriceNew(
//           price: calculateDiscountedPrice(
//             controller.itemsModel.itemsPrice!,
//             controller.itemsModel.itemsDiscount!,
//           ).toStringAsFixed(2),
//         ),
//         if (controller.itemsModel.itemsDiscount != null &&
//             controller.itemsModel.itemsDiscount! > 0)
//           CustomPriceOld(
//             price: controller.itemsModel.itemsPrice!
//                 .toStringAsFixed(2),
//           ),
//       ],
//     );
//
//   }
// }
