import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/offers/custom_build_advertisements.dart';
import 'package:e_commerce/view/widget/offers/custom_build_all_offers_grid.dart';
import 'package:e_commerce/view/widget/offers/custom_build_personalized_offers.dart';
import 'package:e_commerce/view/widget/offers/custom_build_title.dart';
import 'package:e_commerce/view/widget/offers/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    OffersControllerImp offersControllerImp = Get.put(OffersControllerImp());
    offersControllerImp.getDataOffers();

    return Scaffold(
      drawer: CustomSideMenu(),
      appBar: CustomAppbar(
        isSearch: false,
        titleAppbar: "Offers",
        onPressedIconSearch: () {},
        onPressedIconAction: () {},
        iconAction: Icons.shopping_cart_outlined,
        onChanged: (val) {},
        textEditingController: TextEditingController(),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OffersControllerImp>(
          init: OffersControllerImp(),
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(),
                  CustomBuildAdvertisements(),
                  CustomBuildTitle(title: 'Just for You', underlineLength: 130),
                  CustomBuildPersonalizedOffers(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBuildTitle(
                        title: 'All Offers',
                        underlineLength: 100,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.allOffers);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              color: Colors.orangeAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomBuildAllOffersGrid(countGrid: 9),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
