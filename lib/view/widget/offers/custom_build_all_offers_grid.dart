import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomBuildAllOffersGrid extends StatelessWidget {
  final int countGrid;

  const CustomBuildAllOffersGrid({super.key, required this.countGrid});

  @override
  Widget build(BuildContext context) {
    CartControllerImp cartControllerImp = Get.find();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<OffersControllerImp>(
        builder: (controller) {
          if (controller.dataOffers.isEmpty) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: countGrid,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          }
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: countGrid,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              var item = controller.dataOffers[index];
              return InkWell(
                onTap: () {
                  controller.goToProductsDetails(item.itemsId!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Stack(
                            children: [
                              // الصورة مع Shimmer
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  "${AppLink.imageItems}/${item.itemsImageURl}",
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.fitHeight,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 100,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 100),
                                ),
                              ),
                            ],
                          ),

                          // اسم المنتج
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8,
                            ),
                            child: Text(
                              item.itemsNameEn!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          // الأسعار وزر الكارت
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${item.finalPrice} \$",
                                        style: TextStyle(
                                          color: AppColor.hotRed2,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "${item.itemsPrice}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // زر الكارت
                                InkWell(
                                  onTap: () {
                                    cartControllerImp.addToCart(
                                      item.itemsId.toString(),"0",
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.hotRed,
                                    radius: 16,
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (item.itemsDiscount != null && item.itemsDiscount! > 0)
                        Positioned(
                          top: 8,
                          left: -25,
                          child: Transform.rotate(
                            angle: -0.8,
                            child: Container(
                              width: 80,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "-${item.itemsDiscount}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(204),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: GetBuilder<FavoriteViewControllerImp>(
                            builder: (controllerFav) {
                              return InkWell(
                                onTap: () {
                                  if (controllerFav.checkIfFavorite(
                                    item.itemsId.toString(),
                                  )) {
                                    controllerFav.removeFavorite(
                                      item.itemsId.toString(),
                                    );
                                  } else {
                                    controllerFav.addFavorite(
                                      item.itemsId.toString(),
                                    );
                                  }

                                  controller.dataOffers[index] = item;
                                  controller.update();
                                },
                                child: Icon(
                                  controllerFav.checkIfFavorite(
                                        item.itemsId.toString(),
                                      )
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColor.hotRed,
                                  size: 20,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
