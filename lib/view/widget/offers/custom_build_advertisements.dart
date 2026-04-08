import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomBuildAdvertisements extends StatelessWidget {
  const CustomBuildAdvertisements({super.key});

  @override
  Widget build(BuildContext context) {
    OffersControllerImp offersControllerImp = Get.find();

    if (offersControllerImp.dataAdvertisements.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: offersControllerImp.dataAdvertisements.length,
      itemBuilder: (context, index, realIndex) {
        final offer = offersControllerImp.dataAdvertisements[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.coldOrange2, width: 2),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                  "${AppLink.imageMarketing}/${offer.advertisementsImage}"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // 🔹 طبقة شفافة أعلى الصورة
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // 🔹 النصوص
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.advertisementsTitleEn ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      offer.advertisementsSubtitleEn ?? '',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
    );
  }
}
