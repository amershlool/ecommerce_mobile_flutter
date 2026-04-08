import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/advertisements_data.dart';
import 'package:e_commerce/data/datasource/remote/offers_data.dart';
import 'package:e_commerce/data/model/advertisements_models.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:e_commerce/view/screen/productDetailsNew.dart';
import 'package:get/get.dart';

abstract class OffersController extends GetxController {
  getDataOffers();

  getDataAdvertisements();

  goToProductsDetails(int itemId);
}

class OffersControllerImp extends OffersController {
  OffersData offersData = OffersData(Get.find());
  AdvertisementsData advertisementsData = AdvertisementsData(Get.find());
  List<ItemsModel> dataOffers = [];
  List<AdvertisementsModels> dataAdvertisements = [];
  late StatusRequest statusRequest;
  CartControllerImp cartControllerImp = Get.find();
  MyServices myServices = Get.find();

  @override
  getDataOffers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await offersData.getData();
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        dataOffers.clear();
        List responseData = response['data'];
        dataOffers.addAll(responseData.map((e) => ItemsModel.fromJson(e)));
        dataOffers.sort((a, b) => b.itemsDiscount!.compareTo(a.itemsDiscount!));
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  @override
  getDataAdvertisements() async {
    statusRequest = StatusRequest.loading;
    var response = await advertisementsData.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        dataAdvertisements.clear();
        List responseData = response['data'];
        dataAdvertisements.addAll(
          responseData.map((e) => AdvertisementsModels.fromJson(e)),
        );
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    print("--------------------------------------------------------");
    print(dataAdvertisements);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getDataAdvertisements();
    getDataOffers();
  }

  @override
  goToProductsDetails(itemId) {
    Get.to(
          () => ProductdetailsNew(),
      arguments: {
        "itemsId": itemId,
      },
    );
  }
}
