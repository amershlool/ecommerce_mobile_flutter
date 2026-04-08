import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/screen/productDetailsNew.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_build_cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CustomProductsGrid extends StatelessWidget {
  const CustomProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedProductsControllerImp>(
      builder: (controller) {
        return Expanded(
          child: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            padding: const EdgeInsets.all(12),
            itemCount: controller.data.length,

            itemBuilder: (context, index) {
              final product = controller.data[index];
              double discountValue =
                  double.tryParse(product.itemsDiscount?.toString() ?? "0") ??
                  0;

              return InkWell(
                onTap: () {
                  Get.to(
                    () => ProductdetailsNew(),
                    arguments: {"itemsId": product.itemsId},
                  );
                },
                child: GetBuilder<FavoriteViewControllerImp>(
                  builder: (controller) {
                    return CustomBuildCartProduct(
                      imageUrl:
                          "${AppLink.imageItems}/${product.itemsImageURl}",
                      isNew: product.isNew == 1 ? true : false,
                      discount: discountValue > 0,
                      onPressedFav: () {
                        if (!controller.checkIfFavorite(
                          product.itemsId.toString(),
                        )) {
                          controller.addFavorite(product.itemsId.toString());
                          controller.update();
                        } else {
                          controller.removeFavorite(product.itemsId.toString());
                          controller.update();
                        }
                      },

                      inStock: product.inStock == 1 ? true : false,
                      productName: "${product.itemsNameEn}",
                      brandName: "${product.itemBrand}",
                      initialRating: product.rating!,
                      reviewCount: "500",
                      finalPrice: product.finalPrice!,
                      originalPrice: product.itemsPrice!,

                      isDiscount: discountValue.toStringAsFixed(0),
                      onPressedAddToCart: () {
                        CartControllerImp cartControllerImp = Get.find();
                        cartControllerImp.addToCart(
                          product.itemsId.toString(),
                          "0",
                        );
                      },
                      isFavorite: controller.checkIfFavorite(
                        product.itemsId.toString(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
