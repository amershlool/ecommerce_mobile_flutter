import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/test_data.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());
  Map data = {};

  late StatusRequest statusRequest;

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;

    Map<String, dynamic> response = await testData.getData()  as Map<String, dynamic>;
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      print(
          "============================================ $response StatusRequest.success");
      if (response["status"] == "success") {
        data.addAll(response);
      } else {
       statusRequest = StatusRequest.failure;
        print("============= Response StatusRequest.failure ===========================");
      }
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
