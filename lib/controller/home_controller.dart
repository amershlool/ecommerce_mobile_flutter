import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/data/model/count_items_in_categories_model.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/home_data.dart';

abstract class HomeController extends GetxController {
  initialData();

  getData();

  goToItems(List categories, int selectedCat, String categoriesId);

  checkSearch(val);

  onSearch();

  getCountItems();

  getDataSearch();

  goToPageProductDetails(itemsModel);

  getDirectAdvertising();
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  String? userName;
  List<CountItemsInCategoriesModel> countItems = [];
  String? titleDirectAdvertising;
  String? bodyDirectAdvertising;
  String? userId;
  String? userEmail;

  //search
  List<ItemsModel> listDataSearch = [];
  TextEditingController? search;
  bool isSearch = false;

  //
  StatusRequest statusRequest = StatusRequest.loading;
  String? lang;
  HomeData homeData = HomeData(Get.find());
  List categories = [];
  List items = [];

  @override
  initialData() {
    lang = myServices.sharedPref.getString("lang");
    userName = myServices.sharedPref.getString("username");
    userId = myServices.sharedPref.getString("userid");
    userEmail = myServices.sharedPref.getString("email");
    search = TextEditingController();
  }

  @override
  void onInit() {
    getData();
    getCountItems();
    getDirectAdvertising();
    initialData();
    super.onInit();
  }

  @override
  getData() async {
    items.clear();
    categories.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response =
        await homeData.getData() as Map<String, dynamic>;
    statusRequest = handlingData(response);
    update();

    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        categories.addAll(response['categories']);
        items.addAll(response['items']);
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    }
    update();
  }

  @override
  getCountItems() async {
    countItems.clear();
    var response = await homeData.getCountItems();
    List listResponse = response['data'];
    countItems.addAll(
      listResponse.map((e) => CountItemsInCategoriesModel.fromJson(e)),
    );
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
  goToItems(categories, selectedCat, categoriesId) {
    Get.toNamed(
      AppRoutes.items,
      arguments: {
        "categories": categories,
        "selectedCat": selectedCat,
        "categoriesId": categoriesId,
      },
    );
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
  goToPageProductDetails(itemsModel) {
    Get.toNamed("productDetails", arguments: {"itemsModel": itemsModel});
  }

  @override
  getDirectAdvertising() async {
    var response = await homeData.directAdvertising();
    if (response['status'] == 'success') {
      titleDirectAdvertising = response['title'];
      bodyDirectAdvertising = response['body'];
    } else {
      titleDirectAdvertising = "A Summer Surprise";
      bodyDirectAdvertising = "CashBack 20%";
    }
  }
}
