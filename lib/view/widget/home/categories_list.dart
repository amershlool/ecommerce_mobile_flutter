import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/tarns_late_database.dart';
import 'package:e_commerce/data/model/categories_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesList extends GetView<HomeControllerImp> {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = CategoriesModel.fromJson(
            controller.categories[index],
          );
          return InkWell(
            onTap: () {
              controller.goToItems(
                controller.categories,
                index,
                category.categoriesId!.toString(),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColor.darkGray.withAlpha(5),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(20),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SvgPicture.network(
                      "${AppLink.imageCategories}/${category.categoriesImageURL}",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 70,
                  child: Text(
                    transLateDataBase(
                      category.categoriesNameEn,
                      category.categoriesNameAr,
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
