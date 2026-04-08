import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // ✅ أضفنا المكتبة

class CustomBuildPersonalizedOffers extends StatelessWidget {
  CustomBuildPersonalizedOffers({super.key});

  OffersControllerImp offersControllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    if (offersControllerImp.dataOffers.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 4, // عدد العناصر الوهمية
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: offersControllerImp.dataOffers.length,
      itemBuilder: (context, index, realIndex) {
        final offer = offersControllerImp.dataOffers[index];
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "${AppLink.imageItems}/${offer.itemsImageURl}",
              ),
              fit: BoxFit.fitHeight,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              // Gradient Overlay
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(150),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // Discount Badge
              Positioned(
                top: 8,
                right: -25,
                child: Transform.rotate(
                  angle: 0.8,
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
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
                        "-${offer.itemsDiscount}%",
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

              // Item Name
              Positioned(
                bottom: 16,
                left: 12,
                right: 12,
                child: Text(
                  offer.itemsNameEn ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.55,
        reverse: true,
      ),
    );
  }
}
