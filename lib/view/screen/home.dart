import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/controller/trending_now_controller.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/view/screen/productDetailsNew.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/featuredProducts/custom_build_cart_product.dart';
import 'package:e_commerce/view/widget/home/categories_list.dart';
import 'package:e_commerce/view/widget/home/custom_banner.dart';
import 'package:e_commerce/view/widget/home/custom_text_welcome.dart';
import 'package:e_commerce/view/widget/home/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/tarns_late_database.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomeControllerImp controller = Get.put(HomeControllerImp());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FeaturedProductsControllerImp featuredProductsControllerImp = Get.put(
      FeaturedProductsControllerImp(),
    );
    TrendingNowControllerImp trendingNowControllerImp = Get.put(
      TrendingNowControllerImp(),
    );
    FavoriteViewControllerImp favoriteViewControllerImp = Get.find();
    CartControllerImp cartControllerImp = Get.find();
    trendingNowControllerImp.getData();
    featuredProductsControllerImp.getData();
    favoriteViewControllerImp.getData();
    cartControllerImp.viewCart();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppbar(
        isSearch: true,
        titleAppbar: "titleAppbar".tr,
        onPressedIconSearch: () {
          controller.onSearch();
        },
        onPressedIconAction: () {
          Get.toNamed(AppRoutes.myFavorite);
        },
        iconAction: Icons.favorite_border,
        onChanged: (val) {
          controller.checkSearch(val);
        },
        textEditingController: controller.search!,
      ),
      drawer: CustomSideMenu(),

      body: GetBuilder<HomeControllerImp>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.isSearch
                ? SearchResultList(listDataModel: controller.listDataSearch)
                : RefreshIndicator(
                    onRefresh: () => controller.getData(),
                    color: AppColor.hotRed,
                    child: CustomScrollView(
                      primary: true,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: CustomTextWelcome(
                            textName: controller.myServices.sharedPref
                                .getString("username")!,
                            textSubTitleName:
                                "Welcome back ! Get ready for an amazing shopping experience today ..",
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              CustomBanner(
                                title: controller.titleDirectAdvertising.toString(),
                                subtitle:controller.bodyDirectAdvertising.toString(),
                                onPressed: () {
                                  print("Claim Now");
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SectionHeader(
                              title: "Categories".tr,
                              onSeeAll: () {
                                Get.toNamed(AppRoutes.categories);
                              },
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 5)),
                        const SliverToBoxAdapter(child: CategoriesList()),
                        const SliverToBoxAdapter(child: SizedBox(height: 12)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SectionHeader(
                              title: "Featured Products",
                              onSeeAll: () {
                                Get.toNamed(AppRoutes.featuredProducts);
                              },
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 5)),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 360,
                            child: GetBuilder<FeaturedProductsControllerImp>(
                              builder: (controller) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.data.length,
                                  itemBuilder: (context, index) {
                                    final product = controller.data[index];
                                    double discountValue =
                                        double.tryParse(
                                          product.itemsDiscount?.toString() ??
                                              "0",
                                        ) ??
                                        0;

                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ProductdetailsNew(),
                                          arguments: {
                                            "itemsId": product.itemsId,
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        width: 200,
                                        child: GetBuilder<FavoriteViewControllerImp>(
                                          builder: (controllerFav) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                                bottom: 10,
                                              ),
                                              child: CustomBuildCartProduct(
                                                imageUrl:
                                                    "${AppLink.imageItems}/${product.itemsImageURl}",
                                                isNew: product.isNew == 1
                                                    ? true
                                                    : false,
                                                discount: discountValue > 0,
                                                onPressedFav: () {
                                                  if (controllerFav
                                                      .checkIfFavorite(
                                                        product.itemsId
                                                            .toString(),
                                                      )) {
                                                    controllerFav
                                                        .removeFavorite(
                                                          product.itemsId
                                                              .toString(),
                                                        );
                                                    controllerFav.getData();
                                                  } else {
                                                    controllerFav.addFavorite(
                                                      product.itemsId
                                                          .toString(),
                                                    );
                                                    controllerFav.getData();
                                                  }
                                                },
                                                inStock: product.inStock == 1
                                                    ? true
                                                    : false,
                                                productName:
                                                    "${product.itemsNameEn}",
                                                brandName:
                                                    "${product.itemBrand}",
                                                initialRating: product.rating!,
                                                reviewCount: product
                                                    .itemReviewCount
                                                    .toString(),
                                                finalPrice: product.finalPrice!,
                                                originalPrice:
                                                    product.itemsPrice!,

                                                isDiscount: discountValue
                                                    .toStringAsFixed(0),
                                                onPressedAddToCart: () {
                                                  CartControllerImp
                                                  cartControllerImp =
                                                      Get.find();
                                                  cartControllerImp.addToCart(
                                                    product.itemsId.toString(),"0"
                                                  );
                                                },
                                                isFavorite: controllerFav
                                                    .checkIfFavorite(
                                                      product.itemsId
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 12)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SectionHeader(
                              title: "Trending Now",
                              onSeeAll: () {
                                print("See All");
                              },
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 5)),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 360,
                            child: GetBuilder<TrendingNowControllerImp>(
                              builder: (controllerT) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controllerT.trendingNowList.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        controllerT.trendingNowList[index];
                                    double discountValue =
                                        double.tryParse(
                                          product.itemsDiscount?.toString() ??
                                              "0",
                                        ) ??
                                        0;

                                    return InkWell(
                                      onTap: () {
                                        print("Product Details");
                                        Get.to(
                                          () => ProductdetailsNew(),
                                          arguments: {
                                            "itemsId": product.itemsId,
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        width: 200,
                                        child: GetBuilder<FavoriteViewControllerImp>(
                                          builder: (controller) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                                bottom: 10,
                                              ),
                                              child: CustomBuildCartProduct(
                                                imageUrl:
                                                    "${AppLink.imageItems}/${product.itemsImageURl}",
                                                isNew: product.isNew == 1
                                                    ? true
                                                    : false,
                                                discount: discountValue > 0,
                                                onPressedFav: () {
                                                  if (!controller
                                                      .checkIfFavorite(
                                                        product.itemsId
                                                            .toString(),
                                                      )) {
                                                    controller.addFavorite(
                                                      product.itemsId
                                                          .toString(),
                                                    );
                                                    controller.update();
                                                  } else {
                                                    controller.removeFavorite(
                                                      product.itemsId
                                                          .toString(),
                                                    );
                                                    controller.update();
                                                  }
                                                },
                                                inStock: product.inStock == 1
                                                    ? true
                                                    : false,
                                                productName:
                                                    "${product.itemsNameEn}",
                                                brandName:
                                                    "${product.itemBrand}",
                                                initialRating: product.rating!,
                                                reviewCount: product
                                                    .itemReviewCount
                                                    .toString(),
                                                finalPrice: product.finalPrice!,
                                                originalPrice:
                                                    product.itemsPrice!,

                                                isDiscount: discountValue
                                                    .toStringAsFixed(0),
                                                onPressedAddToCart: () {
                                                  CartControllerImp
                                                  cartControllerImp =
                                                      Get.find();
                                                  cartControllerImp.addToCart(
                                                    product.itemsId.toString(),"0",
                                                  );
                                                },
                                                isFavorite: controller
                                                    .checkIfFavorite(
                                                      product.itemsId
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 26)),
                      ],
                    ),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PrimaryScrollController.of(context).animateTo(
            0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: AppColor.hotRed,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}

class SearchResultList extends GetView<HomeControllerImp> {
  final List<ItemsModel> listDataModel;

  const SearchResultList({super.key, required this.listDataModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      itemCount: listDataModel.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = listDataModel[index];
        final isLastItem = index == listDataModel.length - 1;

        return _buildSearchItem(item, isLastItem, context);
      },
    );
  }

  Widget _buildSearchItem(
    ItemsModel item,
    bool isLastItem,
    BuildContext context,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: EdgeInsets.only(bottom: isLastItem ? 24 : 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.goToPageProductDetails(item),
          borderRadius: BorderRadius.circular(20),
          onHover: (hovering) {},
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColor.darkGray.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage(item),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProductName(item),
                            const SizedBox(height: 5),

                            _buildCategoryName(item),
                            const SizedBox(height: 2),
                            _buildPriceAndActions(item, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // علامة التفضيل
                Positioned(top: 5, right: 20, child: _buildFavoriteButton()),

                // علامة الخصم إذا موجودة
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
                  right: 5,
                  bottom: 10,
                  child: InkWell(
                    onTap: () {
                      _addToCartAnimation(context);
                      // controller.addToCart(item);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColor.hotRed, AppColor.hotRed2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.hotRed.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(ItemsModel item) {
    return Hero(
      tag: 'search_image_${item.itemsId}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          height: 70,
          width: 70,
          imageUrl: "${AppLink.imageItems}/${item.itemsImageURl}",
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(color: Colors.white),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductName(ItemsModel item) {
    return Text(
      transLateDataBase(item.itemsNameEn, item.itemsNameAr),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColor.hotRed2,
        fontFamily: 'Cairo',
        height: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCategoryName(ItemsModel item) {
    return Text(
      transLateDataBase(item.categoriesNameEn, item.categoriesNameAr),
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
        fontFamily: 'Cairo',
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndActions(ItemsModel item, BuildContext context) {
    final hasDiscount = item.itemsDiscount != null && item.itemsDiscount! > 0;

    return Row(
      children: [
        Text(
          "${item.finalPrice} \$",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.green,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(width: 20),

        if (hasDiscount)
          Text(
            "${item.itemsPrice} \$",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
            ),
          ),

        // زر الإضافة إلى السلة مع تأثيرات
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: () {
        // controller.toggleFavorite(item);
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.favorite, size: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildDiscountBadge(ItemsModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "${item.itemsDiscount}% OFF",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _addToCartAnimation(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2 - 30,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.hotRed,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.hotRed.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 24),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 1500), () {
      overlayEntry.remove();
    });
  }
}
