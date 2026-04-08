import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/featured_products_data.dart';
import 'package:e_commerce/data/model/featured_products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class FeaturedProductsController extends GetxController{
  getData() ;
}
class FeaturedProductsControllerImp extends FeaturedProductsController{
  TextEditingController textEditingController = TextEditingController();
  late StatusRequest statusRequest ;
  FeaturedProductsData featuredProductsData = FeaturedProductsData(Get.find());
  HomeControllerImp homeControllerImp = Get.find();
  String selectedCategory = "All";
  final List<String> sortOptions = [
    "Newest",
    "Popular",
    "Price: Low to High",
    "Price: High to Low",
    "Rating",
  ];
  List<FeaturedProductsModel> data = [];
  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await featuredProductsData.getData();
    print("=== response from API ===");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.clear();
        List responseData = response['data'];
        data.addAll(responseData.map((e) => FeaturedProductsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
        print("++++++++++++++++++++++++++++++");

      }
    }
    update();
  }
  @override
  void onInit() {
    super.onInit();
    getData();
  }

}