import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/print_all_shared_pref_values.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/token_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

abstract class LogoutController extends GetxController {
  logout();
}

class LogoutControllerImp extends LogoutController {
  MyServices myServices = Get.find();
  TokenData tokenData = TokenData(Get.find());
  String? get usersId => myServices.sharedPref.getString('userid');

  @override
  logout() {
    print(
      "-------------------------------------------------------------",
    );

    printAllSharedPrefValues();
    myServices.sharedPref.remove("phone");
    myServices.sharedPref.remove("userid");
    myServices.sharedPref.remove("username");
    myServices.sharedPref.remove("email");
    // myServices.sharedPref.remove("step");
   myServices.sharedPref.setString("step", '1');
    print(
      "-------------------------------------------------------------",
    );

    printAllSharedPrefValues();
    FirebaseMessaging.instance.unsubscribeFromTopic('users');
    Get.offAllNamed(AppRoutes.logIn);
  }
}
