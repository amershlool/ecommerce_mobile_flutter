import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/trending_now_data.dart';
import 'package:e_commerce/data/model/trending_now_model.dart';
import 'package:get/get.dart';

abstract class TrendingNowController extends GetxController {
  getData();
}

class TrendingNowControllerImp extends TrendingNowController {
  List<TrendingNowModels> trendingNowList = [];
  late StatusRequest statusRequest;

  TrendingNowData trendingNowData = TrendingNowData(Get.find());

  @override
  getData() async{
    statusRequest = StatusRequest.loading;
    update();
    trendingNowList.clear();
    var response = await trendingNowData.getData();
    statusRequest = handlingData(response);
    update();
    if(response['status']=='success'){
      List data = response['data'];
      trendingNowList.addAll(data.map((e)=>TrendingNowModels.fromJson(e)));
    }else{
      statusRequest = StatusRequest.failure;
    }
  }
  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
