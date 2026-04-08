import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_appBar_featured_product.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_bottom_cart_summary.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_filters_and_items_count.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_list_name_categories.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_products_grid.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    FeaturedProductsControllerImp featuredProductsControllerImp= Get.find();
    return Scaffold(
      appBar:
      customAppBarFeaturedProducts(
        "Featured Products",
            () {
          print("Cart");
        },
            () {
          print("Favorite");
        },
      ),
      body: Column(
        children: [
          // Search bar
          CustomSearchBarFeaturedProducts(
            textEditingController: featuredProductsControllerImp.textEditingController ,
            hintText: 'Search Product',
          ),
          // Categories
          CustomListNameCategories(),

          // Filters and item count
          CustomFiltersAndItemsCount(),

          // Products grid
          CustomProductsGrid(),
        ],
      ),

      // Bottom Cart Summary
      bottomNavigationBar: CustomBottomCartSummary(),
    );
  }
}
