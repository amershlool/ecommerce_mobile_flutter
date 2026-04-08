import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/home_data.dart';
import 'package:e_commerce/data/datasource/remote/items_data.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ItemsController extends GetxController {
  initialData();

  changeCat(int value, String catCategories);

  getItems(String categoryId);

  goToPageProductDetails(ItemsModel itemsModel);

  checkSearch(val);

  onSearch();

  getDataSearch();
}

class ItemsControllerImp extends ItemsController {
  CartControllerImp cartControllerImp = Get.put(CartControllerImp());
  MyServices myServices = Get.find();
  List listItemsData = [];
  late StatusRequest statusRequest;

  List categories = [];
  ItemsData itemsData = ItemsData(Get.find());
  int? selectedCat;
  String? catId;

  //Search
  bool isSearch = false;
  List<ItemsModel> listDataSearch = [];
  TextEditingController? search;

  HomeData homeData = HomeData(Get.find());

  //
  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  @override
  initialData() {
    categories = Get.arguments['categories'];
    selectedCat = Get.arguments['selectedCat'];
    catId = Get.arguments['categoriesId'];
    getItems(catId!);
    search = TextEditingController();

  }

  @override
  changeCat(value, catCategories) {
    selectedCat = value;
    catId = catCategories;
    getItems(catId!);

    update();
  }

  @override
  Future<void> getItems(categoryId) async {
    listItemsData.clear();
    statusRequest = StatusRequest.loading;

    Map<String, dynamic> response =
    await itemsData.getData(
      categoryId,
    )
    as Map<String, dynamic>;
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        listItemsData.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


  @override
  checkSearch(val) {
    if (val.isEmpty) {
      isSearch = false;
      listDataSearch.clear();
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  onSearch() {
    if (search != null && search!.text.isNotEmpty) {
      isSearch = true;
      getDataSearch();
    } else {
      isSearch = false;
      listDataSearch.clear();
      statusRequest = StatusRequest.success;
    }
    update();
  }

  @override
  getDataSearch() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.searchItems(search!.text);
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listDataSearch.clear();
        List responseData = response['data'];
        listDataSearch.addAll(responseData.map((e) => ItemsModel.fromJson(e)));
        update();
      } else {
        statusRequest = StatusRequest.failure;
        listDataSearch.clear();
        update();
      }
    }
    update();
  }

  @override
  goToPageProductDetails(itemsModel) {
    Get.toNamed("productDetails", arguments: {"itemsModel": itemsModel});
  }

}