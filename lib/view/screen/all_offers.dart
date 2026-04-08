import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/offers/custom_build_all_offers_grid.dart';
import 'package:e_commerce/view/widget/offers/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOffers extends StatelessWidget {
  const AllOffers({super.key});

  @override
  Widget build(BuildContext context) {
    OffersControllerImp offersControllerImp = Get.find();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppbar(
        isSearch: false,
        titleAppbar: "Offers",
        onPressedIconSearch: () {},
        onPressedIconAction: () {},
        iconAction: Icons.person_outlined,
        onChanged: (val) {},
        textEditingController: TextEditingController(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await offersControllerImp.getDataOffers();
        },
        child: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: HandlingDataView(
                statusRequest: offersControllerImp.statusRequest,
                widget: SingleChildScrollView(
                  child: CustomBuildAllOffersGrid(
                    countGrid: offersControllerImp.dataOffers.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
