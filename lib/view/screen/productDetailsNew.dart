import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/product_details_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/productdetails/coustom_description.dart';
import 'package:e_commerce/view/widget/productdetails/custom_details.dart';
import 'package:e_commerce/view/widget/productdetails/custom_features_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class ProductdetailsNew extends GetView<ProductDetailsControllerImp> {
  const ProductdetailsNew({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsControllerImp());

    return Scaffold(
      body: GetBuilder<ProductDetailsControllerImp>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.dataDetails.isNotEmpty
                ? CustomScrollView(
                    slivers: [
                      // AppBar
                      SliverAppBar(
                        expandedHeight: 380,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              // عرض الصور
                              PageView.builder(
                                itemCount:
                                    (controller
                                            .dataDetails
                                            .first
                                            .images
                                            ?.length ??
                                        0) +
                                    1, // +1 للصورة الرئيسية
                                onPageChanged: (currentIndex) {
                                  controller.changeCurrentImage(currentIndex);
                                },
                                controller: controller.pageController,
                                itemBuilder: (context, index) {
                                  // الصورة الأولى هي الصورة الرئيسية للمنتج
                                  if (index == 0) {
                                    final mainImageUrl =
                                        controller
                                            .dataDetails
                                            .first
                                            .itemsImageURl ??
                                        "";
                                    return _buildImage(
                                      "${AppLink.imageItems}/$mainImageUrl",
                                      controller,
                                    );
                                  }

                                  // الصور الفرعية
                                  final imageIndex =
                                      index -
                                      1; // نطرح 1 لأن الصورة الرئيسية في index 0
                                  if (imageIndex <
                                      (controller
                                              .dataDetails
                                              .first
                                              .images
                                              ?.length ??
                                          0)) {
                                    final imageUrl =
                                        controller
                                            .dataDetails
                                            .first
                                            .images?[imageIndex]
                                            .imageUrl ??
                                        "";
                                    return _buildImage(
                                      "${AppLink.imageItems}/$imageUrl",
                                      controller,
                                    );
                                  }

                                  return Container();
                                },
                              ),

                              // نقاط التنقل بين الصور
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    (controller
                                                .dataDetails
                                                .first
                                                .images
                                                ?.length ??
                                            0) +
                                        1, // +1 للصورة الرئيسية
                                    (index) {
                                      return Container(
                                        width: 8,
                                        height: 8,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              controller.currentImageIndex ==
                                                  index
                                              ? AppColor.hotRed
                                              : Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // عرض الدوائر للون والحجم الحاليين
                              Positioned(
                                bottom: 70,
                                left: 16,
                                child: _buildCurrentColorAndSizeIndicator(
                                  controller,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          GetBuilder<FavoriteViewControllerImp>(
                            builder: (controllerF) {
                              return IconButton(
                                icon: Icon(
                                  color:
                                      controllerF.checkIfFavorite(
                                        controller.dataDetails.first.itemsId
                                            .toString(),
                                      )
                                      ? AppColor.hotRed
                                      : AppColor.darkGray,
                                  controllerF.checkIfFavorite(
                                        controller.dataDetails.first.itemsId
                                            .toString(),
                                      )
                                      ? Iconsax.heart5
                                      : Iconsax.heart,
                                ),
                                onPressed: () {
                                  if (!controllerF.checkIfFavorite(
                                    controller.dataDetails.first.itemsId
                                        .toString(),
                                  )) {
                                    controllerF.addFavorite(
                                      controller.dataDetails.first.itemsId
                                          .toString(),
                                    );
                                    controllerF.update();
                                  } else {
                                    controllerF.removeFavorite(
                                      controller.dataDetails.first.itemsId
                                          .toString(),
                                    );
                                    controllerF.onInit();
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),

                      // محتوى المنتج
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // رسالة التوفر
                              if (!controller.isProductAvailable)
                                _buildAvailabilityWarning(controller),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.dataDetails.first.itemBrand ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  _buildStockStatus(controller),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.dataDetails.first.itemsNameEn ?? "",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // عرض اسم الصورة الفرعية إذا كان مختلفاً عن الرئيسي
                              if (controller.currentImageIndex > 0 &&
                                  controller.dataDetails.first.images != null &&
                                  controller.currentImageIndex - 1 <
                                      (controller
                                              .dataDetails
                                              .first
                                              .images
                                              ?.length ??
                                          0) &&
                                  controller.dataDetails.first.itemsNameEn !=
                                      controller
                                          .dataDetails
                                          .first
                                          .images![controller
                                                  .currentImageIndex -
                                              1]
                                          .imageNameEn)
                                Text(
                                  "${controller.dataDetails.first.images![controller.currentImageIndex - 1].imageNameEn}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              const SizedBox(height: 4),

                              // Rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating:
                                            controller
                                                .dataDetails
                                                .first
                                                .ratingAvg ??
                                            0.0,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                        itemCount: 5,
                                        itemSize: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${controller.dataDetails.first.ratingCount ?? 0} Ratings",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),

                                  Row(
                                    children: [
                                      Text(
                                        "${controller.dataDetails.first.itemReviewCount ?? 0}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 20,
                                        color: AppColor.darkGray,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // عرض السعر مع الخصم بشكل احترافي
                              _buildPriceSectionWithDiscount(controller),
                              const SizedBox(height: 16),

                              const SizedBox(height: 24),

                              // Colors Selection
                              _buildColorsSection(controller),

                              const SizedBox(height: 24),

                              // Sizes Selection
                              _buildSizesSection(controller),
                              const SizedBox(height: 24),

                              CustomFeaturesSection(
                                controller: controller,
                                isDarkMode: Theme.of(context).brightness == Brightness.dark,
                              ),


                              const SizedBox(height: 24),

                              // رسالة التوفر مرة أخرى
                              if (!controller.isProductAvailable &&
                                  controller.showRequestButton)
                                _buildRequestButton(controller),

                              const SizedBox(height: 24),

                              // Quantity
                              const Text(
                                "Quantity",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (controller.quantity > 1) {
                                        controller.quantity--;
                                      }
                                      controller.update();
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${controller.quantity}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.quantity++;
                                      controller.update();
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // Add to Cart
                              _buildAddToCartButton(controller),
                              const SizedBox(height: 10),

                              // Buy It Now
                              _buildBuyItNowButton(controller),
                              const SizedBox(height: 32),

                              // Description
                              CustomDescription(
                                description: controller.currentImageIndex == 0
                                    ? "${controller.dataDetails.first.itemsDescriptionEn}"
                                    : (controller.dataDetails.first.images !=
                                              null &&
                                          controller.currentImageIndex - 1 <
                                              controller
                                                  .dataDetails
                                                  .first
                                                  .images!
                                                  .length)
                                    ? controller
                                              .dataDetails
                                              .first
                                              .images![controller
                                                      .currentImageIndex -
                                                  1]
                                              .imageDescriptionEn ??
                                          ''
                                    : '',
                              ),

                              // Product Details
                              CustomProductDetails(
                                details: {
                                  'SKU': controller.currentImageIndex == 0
                                      ? "${controller.dataDetails.first.itemsId}"
                                      : (controller.dataDetails.first.images !=
                                                null &&
                                            controller.currentImageIndex - 1 >=
                                                0 &&
                                            controller.currentImageIndex - 1 <
                                                controller
                                                    .dataDetails
                                                    .first
                                                    .images!
                                                    .length)
                                      ? "${controller.dataDetails.first.images![controller.currentImageIndex - 1].imageId ?? ''}"
                                      : '',
                                  'Category':
                                      "${controller.dataDetails.first.itemsCategories ?? ""}",
                                  'Brand':
                                      controller.dataDetails.first.itemBrand ??
                                      "",
                                  'Main Color':
                                      controller.mainProductColorName ?? "N/A",
                                  'Main Size':
                                      controller.mainProductSizeName ?? "N/A",
                                  'Available Colors':
                                      "${controller.availableColors.length} colors",
                                  'Available Sizes':
                                      "${controller.availableSizes.length} sizes",
                                  'stock': controller.currentImageIndex == 0
                                      ? controller.dataDetails.first.itemsCount
                                                ?.toString() ??
                                            '0'
                                      : (controller.dataDetails.first.images !=
                                                null &&
                                            controller.currentImageIndex - 1 >=
                                                0 &&
                                            controller.currentImageIndex - 1 <
                                                controller
                                                    .dataDetails
                                                    .first
                                                    .images!
                                                    .length)
                                      ? controller
                                                .dataDetails
                                                .first
                                                .images![controller
                                                        .currentImageIndex -
                                                    1]
                                                .imageCount
                                                ?.toString() ??
                                            '0'
                                      : '0',
                                  'discount': controller.hasDiscount()
                                      ? "${controller.dataDetails.first.itemsDiscount}%"
                                      : '0%',
                                  'rating':
                                      controller.dataDetails.first.ratingAvg
                                          ?.toString() ??
                                      '4.5',
                                },
                                title: "Product Details",
                                initiallyExpanded: true,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }

  // ============ Widgets المساعدة ============

  Widget _buildImage(String imageUrl, ProductDetailsControllerImp controller) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.error, color: Colors.red, size: 50),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentColorAndSizeIndicator(
    ProductDetailsControllerImp controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // دائرة اللون الحالي
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.getCurrentColor(),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),

          // نص يوضح اللون
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Text(
          //     controller.availableColors.first,
          //     style: const TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),

          const SizedBox(width: 8),

          // نص الحجم الحالي
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              controller.getCurrentSize(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockStatus(ProductDetailsControllerImp controller) {
    int stockQuantity = 0;

    // الحصول على كمية المخزون للصورة الحالية
    if (controller.currentImageIndex == 0) {
      stockQuantity = controller.dataDetails.first.itemsCount ?? 0;
    } else if (controller.dataDetails.first.images != null &&
        (controller.currentImageIndex - 1) <
            controller.dataDetails.first.images!.length) {
      var currentImage = controller
          .dataDetails
          .first
          .images![controller.currentImageIndex - 1];
      stockQuantity = currentImage.imageCount ?? 0;
    }

    final stockDetails = controller.getStockStatusWithDetails(stockQuantity);
    Color statusColor = stockDetails['color'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(stockDetails['icon'], color: statusColor, size: 16),
          const SizedBox(width: 6),
          Text(
            stockDetails['message'],
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityWarning(ProductDetailsControllerImp controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              controller.availabilityMessage,
              style: const TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSectionWithDiscount(
    ProductDetailsControllerImp controller,
  ) {
    double originalPrice = controller.getOriginalPrice();
    double currentPrice = controller.getCurrentPrice();
    int discountPercent = controller.getCurrentDiscount();
    bool hasDiscount = discountPercent > 0;
    double savedAmount = hasDiscount ? (originalPrice - currentPrice) : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // السعر الحالي (بعد الخصم إذا كان موجوداً)
        Row(
          children: [
            Text(
              "\$${currentPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColor.hotRed,
              ),
            ),
            const SizedBox(width: 12),

            if (hasDiscount)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$discountPercent% OFF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 4),

        // السعر الأصلي مع خط في المنتصف إذا كان هناك خصم
        if (hasDiscount && originalPrice > currentPrice)
          Row(
            children: [
              Text(
                "\$${originalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),

              // كمية التوفير
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  "Save \$${savedAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildColorsSection(ProductDetailsControllerImp controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Color",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (controller.availableColors.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "No colors available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.availableColors.map((colorCode) {
              return GestureDetector(
                onTap: () {
                  controller.selectColor(colorCode);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // استخدم parseColor مباشرة
                    color: controller.parseColor(colorCode),
                    border: controller.selectedColorCode == colorCode
                        ? Border.all(color: AppColor.hotRed, width: 3)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: controller.selectedColorCode == colorCode
                      ? Center(
                    child: Icon(
                      Icons.check,
                      color: _getContrastColor(
                        controller.parseColor(colorCode),
                      ),
                      size: 20,
                    ),
                  )
                      : null,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

// دالة مساعدة للحصول على لون النص المناسب (فاتح/غامق)
  Color _getContrastColor(Color color) {
    double luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
  Widget _buildSizesSection(ProductDetailsControllerImp controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Size",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (controller.availableSizes.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "No sizes available",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.availableSizes.map((sizeName) {
              return GestureDetector(
                onTap: () {
                  controller.selectSize(sizeName);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: controller.selectedSizeName == sizeName
                        ? AppColor.hotRed
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: controller.selectedSizeName == sizeName
                          ? AppColor.hotRed
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    sizeName,
                    style: TextStyle(
                      color: controller.selectedSizeName == sizeName
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildRequestButton(ProductDetailsControllerImp controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          controller.requestProductWithColorAndSize();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 20),
            SizedBox(width: 8),
            Text(
              "Notify Admin About This Combination",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(ProductDetailsControllerImp controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: controller.isProductAvailable
            ? () {
                controller.setCartQuantity(
                  Get.arguments['itemsId'].toString(),
                  controller.quantity.toString(),
                );
                Get.snackbar(
                  "Added to Cart",
                  "${controller.dataDetails.first.itemsNameEn} has been added to your cart",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isProductAvailable
              ? AppColor.hotRed
              : Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Add to Cart",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBuyItNowButton(ProductDetailsControllerImp controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: controller.isProductAvailable
            ? () {
                // تنفيذ عملية الشراء المباشر
                Get.toNamed(
                  '/checkout',
                  arguments: {
                    'itemsId': controller.dataDetails.first.itemsId.toString(),
                    'quantity': controller.quantity,
                    'isBuyNow': true,
                  },
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColor.hotRed,
          side: BorderSide(color: AppColor.hotRed, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Buy it Now",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }




}
