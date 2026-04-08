import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/favorite_view_data.dart';
import 'package:e_commerce/data/model/favorite_model.dart';
import 'package:e_commerce/view/screen/productDetailsNew.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class FavoriteViewController extends GetxController {
  getData();

  addFavorite(String favoriteItemsId);

  removeFavorite(String favoriteItemsId);

  getDataSearch();

  onSearch();

  checkSearch(val);

  checkIfFavorite(String itemId);

  goToProductDetails(int itemId);
}

class FavoriteViewControllerImp extends FavoriteViewController {
  late StatusRequest statusRequest;
  List<FavoriteModel> data = [];
  FavoriteData favoriteData = FavoriteData(Get.find());
  MyServices myServices = Get.find();
  Map<String, int> isFavorite = {};
  bool isSearch = false;
  List<FavoriteModel> dataSearch = [];
  TextEditingController? search;

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.getData(
      myServices.sharedPref.getString("userid")!,
    );
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        data.clear();
        isFavorite.clear();
        List listResponse = response['data'];
        data.addAll(listResponse.map((e) => FavoriteModel.fromJson(e)));
        for (var item in data) {
          isFavorite[item.favoriteItemsid.toString()] = 1;
        }
        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();

    }
  }

  @override
  getDataSearch() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await favoriteData.getDataSearch(
      search!.text,
      myServices.sharedPref.getString("userid")!,
    );
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        dataSearch.clear();
        List responseData = response['data'];
        dataSearch.addAll(responseData.map((e) => FavoriteModel.fromJson(e)));
        update();
      } else {
        statusRequest = StatusRequest.failure;
        dataSearch.clear();
        update();
      }
    }
    update();
  }

  @override
  onSearch() {
    if (search != null && search!.text.isNotEmpty) {
      isSearch = true;
      getDataSearch();
    } else {
      isSearch = false;
      dataSearch.clear();
      statusRequest = StatusRequest.success;
    }
    update();
  }

  @override
  checkSearch(val) {
    if (val.isEmpty) {
      isSearch = false;
      dataSearch.clear();
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  checkIfFavorite(itemId) {
    return isFavorite[itemId] == 1;
  }

  @override
  addFavorite(favoriteItemsId) async {
    var response = await favoriteData.addFavorite(
      myServices.sharedPref.getString("userid")!,
      favoriteItemsId,
    );
    if (response['status'] == 'success') {
      isFavorite[favoriteItemsId] = 1;
      getData();
      update();
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  @override
  removeFavorite(String favoriteItemsId) async {
    var response = await favoriteData.removeFavorite(
      myServices.sharedPref.getString("userid")!,
      favoriteItemsId,
    );
    if (response['status'] == 'success') {
      isFavorite.remove(favoriteItemsId);
      getData();

      update();
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isFavorite.clear();
    getData();
    search = TextEditingController();
  }

  @override
  goToProductDetails(int itemId) {
    Get.to(ProductdetailsNew(), arguments: {"itemsId": itemId});
  }
}
