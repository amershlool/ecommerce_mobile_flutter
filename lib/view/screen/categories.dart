import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/data/model/categories_model.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_category_card.dart';
import 'package:e_commerce/view/widget/custom_header_section.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomSideMenu(),

      appBar: CustomAppbar(
        isSearch: false,
        titleAppbar: "Categories",
        onPressedIconSearch: () {},
        onPressedIconAction: () {
          Get.toNamed(AppRoutes.myFavorite);
        },
        iconAction: Icons.favorite_border_outlined,
        onChanged: (val) {},
        textEditingController: TextEditingController(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            CustomHeaderSection(
              title: "Discover our diverse products",
              body: "To take care of your beauty from the inside and outside",
              withAlpha: 50,
            ),
            // Categories Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GetBuilder<HomeControllerImp>(
                builder: (controller) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemBuilder: (context, index) {
                      final category = CategoriesModel.fromJson(
                        controller.categories[index],
                      );
                      return InkWell(
                        onTap: () {
                          controller.goToItems(
                            controller.categories,
                            index,
                            category.categoriesId.toString(),
                          );
                        },
                        child: CategoryCard(
                          imageUrl: category.categoriesImageURL!,
                          title: category.categoriesNameEn!,
                          description: category.categoriesDescriptionEn!,
                          index: index,
                          productCount:
                              controller.countItems[index].totalItems!,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
