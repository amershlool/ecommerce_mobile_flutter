import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListNameCategories extends StatelessWidget {
  const CustomListNameCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedProductsControllerImp>(builder: (controller){
      return
        SizedBox(
          height: 50,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),

            itemCount: controller.homeControllerImp.categories.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: FilterChip(label: Text("All "),
                    selected: controller.selectedCategory == 'All',
                    onSelected: (selected){
                      controller.selectedCategory = 'All';
                      controller.update();
                    },
                    selectedColor: AppColor.hotRed.withAlpha(150),
                    labelStyle: TextStyle(
                      fontWeight: controller.selectedCategory == "All" ? FontWeight.bold : null,
                      color: controller.selectedCategory == "All"
                          ? Colors.white
                          : AppColor.hotRed,
                    ),
                    checkmarkColor: Colors.white,

                  ),
                );
              }
              final category = CategoriesModel.fromJson(
                controller.homeControllerImp.categories[index-1],
              );
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(category.categoriesNameEn.toString()),
                  selected:
                  controller.selectedCategory == category.categoriesNameEn,
                  onSelected: (selected) {
                    controller.selectedCategory = category.categoriesNameEn
                        .toString();
                    controller.update();

                  },
                  selectedColor: AppColor.hotRed.withAlpha(150),
                  labelStyle: TextStyle(
                    fontWeight:
                    controller.selectedCategory ==
                        category.categoriesNameEn.toString()
                        ? FontWeight.bold
                        : null,
                    color:
                    controller.selectedCategory ==
                        category.categoriesNameEn.toString()
                        ? Colors.white
                        : AppColor.hotRed,
                  ),
                  checkmarkColor: Colors.white,
                ),
              );
            },
          ),
        );

    });

  }
}
