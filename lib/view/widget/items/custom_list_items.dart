import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/items_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageasset.dart';
import 'package:e_commerce/core/function/items/calculate_discounted_price.dart';
import 'package:e_commerce/core/function/tarns_late_database.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/screen/productDetailsNew.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomListItems extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;

  const CustomListItems({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
              () =>  ProductdetailsNew() ,
          arguments: {"itemsId":itemsModel.itemsId},
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Stack(
          children: [
            if (itemsModel.itemsDiscount!.toInt() > 0)
              Positioned(
                bottom: 170,
                right: 5,
                child: Image.asset(AppImageAsset.sale, height: 60),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Hero(
                            tag: "${itemsModel.itemsId}",
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppLink.imageItems}/${itemsModel.itemsImageURl}",
                              height: 100,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        // Favorites icon
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(2, 5),
                                ),
                              ],
                            ),
                            child: GetBuilder<FavoriteViewControllerImp>(
                              builder: (controller) => IconButton(
                                icon: Icon(
                                  controller.checkIfFavorite(itemsModel.itemsId.toString())
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColor.hotRed,
                                  size: 18,
                                ),
                                onPressed: () {
                                  if (controller.checkIfFavorite(itemsModel.itemsId.toString())) {
                                    controller.removeFavorite(
                                      itemsModel.itemsId.toString(),
                                    );
                                  } else {
                                    controller.addFavorite(
                                     itemsModel.itemsId.toString()
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(2, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: AppColor.hotRed,
                                size: 18,
                              ),
                              onPressed: () {
                                controller.cartControllerImp.addToCart(
                                  itemsModel.itemsId!.toString(),"0",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${transLateDataBase(itemsModel.itemsNameEn, itemsModel.itemsNameAr)}",
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.5),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${transLateDataBase(itemsModel.itemsDescriptionEn, itemsModel.itemsDescriptionAr)}",
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // الأسعار والخصومات
                  if (itemsModel.itemsDiscount != null &&
                      itemsModel.itemsDiscount! > 0)
                    Row(
                      children: [
                        Text(
                          "\$${itemsModel.itemsPrice}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "\$${calculateDiscountedPrice(itemsModel.itemsPrice!, itemsModel.itemsDiscount!).toStringAsFixed(2)}",
                          style: TextStyle(
                            color: AppColor.hotRed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "\$${itemsModel.itemsPrice?.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: AppColor.hotRed,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
