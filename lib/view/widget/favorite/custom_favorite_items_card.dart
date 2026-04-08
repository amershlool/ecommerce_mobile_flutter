import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/tarns_late_database.dart';
import 'package:e_commerce/data/model/favorite_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFavoriteItemsCard extends GetView<FavoriteViewControllerImp> {
  final FavoriteModel favoriteModel;

  const CustomFavoriteItemsCard( {super.key, required this.favoriteModel});

  @override
  Widget build(BuildContext context) {
    CartControllerImp cartControllerImp = Get.find();

    return InkWell(
      onTap: () {
       // controller.goToPageProductDetails(favoriteModel);
      },
      child: Card(
        color: AppColor.hotRed.withAlpha(204),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Hero(
                        tag: "${favoriteModel.favoriteItemsid}",
                        child: CachedNetworkImage(
                          imageUrl:
                              "${AppLink.imageItems}/${favoriteModel.itemsImageURl}",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 63,
                      right: 130,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColor.hotRed,
                          size: 30,
                        ),
                        onPressed: () {
                          controller.removeFavorite(
                            favoriteModel.favoriteId!.toString(),
                            // favoriteModel.itemsId.toString()
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(153),
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
                            color: Colors.green,
                            size: 18,
                          ),
                          onPressed: () async {
                            await cartControllerImp.addToCart(favoriteModel.favoriteItemsid.toString(),"");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "${transLateDataBase(favoriteModel.itemsNameEn, favoriteModel.itemsNameAr)}",
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                    "${transLateDataBase(favoriteModel.itemsDescriptionEn, favoriteModel.itemsDescriptionAr)}",
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 12,
                      color: Colors.grey[800],
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              const SizedBox(height: 5),
              ...[
                if (favoriteModel.itemsDiscount != null &&
                    favoriteModel.itemsDiscount! > 0)
                  Row(
                    children: [
                      Text(
                        "\$${favoriteModel.itemsPrice}",
                        style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "\$${favoriteModel.finalPrice}",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                if (favoriteModel.itemsDiscount == null ||
                    favoriteModel.itemsDiscount == 0)
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "\$${favoriteModel.itemsPrice}",
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
