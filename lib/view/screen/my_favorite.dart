import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/data/model/favorite_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_header_section.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_build_cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavorite extends StatelessWidget {
  FavoriteViewControllerImp favoriteViewControllerImp = Get.find();

  MyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    favoriteViewControllerImp.getData();
    return Scaffold(
      drawer: CustomSideMenu(),
      body: SafeArea(
        child: GetBuilder<FavoriteViewControllerImp>(
          builder: (controller) => ListView(
            padding: EdgeInsets.all(5),
            children: [
              CustomAppbar(
                isSearch: true,
                titleAppbar: "titleAppbar".tr,
                onPressedIconSearch: () {
                  controller.onSearch();
                },
                onPressedIconAction: () {
                  Get.toNamed(AppRoutes.cart);
                },
                iconAction: Icons.shopping_cart_outlined,
                onChanged: (val) {
                  controller.checkSearch(val);
                },
                textEditingController: controller.search!,
              ),
              Column(
                children: [
                  controller.isSearch
                      ? HandlingDataView(
                          statusRequest: controller.statusRequest,
                          widget: ListFavoriteSearch(
                            listDataModel: controller.dataSearch,
                          ),
                        )
                      : HandlingDataView(
                          statusRequest: controller.statusRequest,
                          widget: Column(
                            children: [
                              GetBuilder<FavoriteViewControllerImp>(
                                builder: (controller) => CustomHeaderSection(
                                  title:
                                      "Favorite product ${controller.data.length}",
                                  body:
                                      "Your favorite products are waiting for you. Don’t miss the chance to explore them!",
                                  withAlpha: 0,
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.56,
                                    ),
                                itemCount: controller.data.length,
                                itemBuilder: (context, index) {
                                  var product = controller.data[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        controller.goToProductDetails(
                                          product.favoriteItemsid!,
                                        );
                                      },
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 600),
                                        child: CustomBuildCartProduct(
                                          imageUrl:
                                              "${AppLink.imageItems}/${product.itemsImageURl!}",
                                          isNew: product.isNew == 1
                                              ? true
                                              : false,
                                          discount: product.itemsDiscount! > 0,
                                          isDiscount: product.itemsDiscount
                                              .toString(),
                                          onPressedFav: () {
                                            controller.removeFavorite(
                                              product.favoriteItemsid
                                                  .toString(),
                                            );
                                            controller.getData();
                                          },
                                          inStock: product.inStock! > 0,
                                          productName: product.itemsNameEn!,
                                          brandName: product.itemBrand!,
                                          initialRating: double.parse(
                                            product.rating!,
                                          ),
                                          reviewCount: product.itemReviewCount
                                              .toString(),
                                          finalPrice: double.parse(
                                            product.finalPrice!,
                                          ),
                                          originalPrice: double.parse(
                                            product.itemsPrice!,
                                          ),
                                          onPressedAddToCart: () {},
                                          isFavorite: controller
                                              .checkIfFavorite(
                                                product.favoriteItemsid
                                                    .toString(),
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListFavoriteSearch extends GetView<FavoriteViewControllerImp> {
  final List<FavoriteModel> listDataModel;

  const ListFavoriteSearch({super.key, required this.listDataModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDataModel.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = listDataModel[index];

        return InkWell(
          onTap: () {
            // controller.goToPageProductDetails(item);
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // الصورة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.imageItems}/${item.itemsImageURl}",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // النصوص
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemsNameEn ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.itemsNameEn ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${item.itemsPrice ?? '0'} \$",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.hotRed2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: AppColor.hotRed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
