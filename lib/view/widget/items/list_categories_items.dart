import 'package:e_commerce/controller/items_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/tarns_late_database.dart';
import 'package:e_commerce/data/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCategoriesItems extends GetView<ItemsControllerImp> {
  const ListCategoriesItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Categories(
            i: index,
            categoriesModel: CategoriesModel.fromJson(
              controller.categories[index],
            ),
          );
        },
      ),
    );
  }
}

class Categories extends GetView<ItemsControllerImp> {
  final CategoriesModel categoriesModel;
  final int i;

  const Categories({super.key, required this.categoriesModel, required this.i});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       controller.changeCat(i,categoriesModel.categoriesId!.toString());
      },
      child: Column(
        children: [
          GetBuilder<ItemsControllerImp>(builder: (controller)=>Container(
    padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
    decoration: controller.selectedCat == i
    ? BoxDecoration(
    border: Border(
    bottom: BorderSide(width: 3, color: AppColor.coldOrange),
    ),
    )
        : null,
    child: Text(
    "${transLateDataBase(categoriesModel.categoriesNameEn, categoriesModel.categoriesNameAr)}",
    style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay'),
    ),
    ),)
        ],
      ),
    );
  }
}
