import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomBuildCartProduct extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final bool isNew;
  final bool discount;
  final String isDiscount;
  final String reviewCount;
  final double finalPrice;
  final double originalPrice;
  final bool inStock;
  final void Function()? onPressedFav;
  final double initialRating;
  final void Function()? onPressedAddToCart;
  final bool isFavorite ;

  const CustomBuildCartProduct({
    super.key,
    required this.imageUrl,
    required this.isNew,
    required this.discount,
    required this.isDiscount,
    required this.onPressedFav,
    required this.inStock,
    required this.productName,
    required this.brandName,
    required this.initialRating,
    required this.reviewCount,
    required this.finalPrice,
    required this.originalPrice,
    required this.onPressedAddToCart,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: 180,
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              // Badges
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: [
                    if (isNew)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(width: 4),

                    if (discount)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "$isDiscount% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Favorite Button
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(100),
                  radius: 16,
                  child: IconButton(
                    onPressed: onPressedFav,
                    icon: Icon(
                     isFavorite?Icons.favorite:Icons.favorite_border,
                      color: AppColor.hotRed,
                      size: 16,
                    ),
                  ),
                ),
              ),
              // Out of Stock Overlay
              if (!inStock)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "OUT OF STOCK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                Text(
                  brandName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Product Name
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: initialRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      ignoreGestures: true,
                      itemBuilder: (BuildContext context, int index) {
                        return const Icon(Icons.star, color: Colors.amber);
                      },
                      onRatingUpdate: (double value) {},
                    ),
                    const SizedBox(width: 4),
                    Text(
                      reviewCount,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price
                Row(
                  children: [
                    Text(
                      "\$$finalPrice",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.hotRed,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (originalPrice > finalPrice)
                      Text(
                        "\$$originalPrice",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Add to Cart Button
          if (inStock)
            Padding(
              padding: EdgeInsets.all(8.0),
              child:
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.hotRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(9),
                    ),
                    minimumSize: const Size(double.infinity, 36),
                  ),

                  onPressed: onPressedAddToCart,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () =>
                      Get.snackbar(
                        "Notify Me",
                        "We'll notify you when this product is back in stock",
                        snackPosition: SnackPosition.BOTTOM,
                      ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 36),
                  ),
                  child: const Text(
                    "Notify When Available",
                    style: TextStyle(fontSize: 12, color: AppColor.hotRed),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
