import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/address/address_add.dart';
import 'package:e_commerce/data/datasource/remote/address/address_delete.dart';
import 'package:e_commerce/data/datasource/remote/address/address_edit.dart';
import 'package:e_commerce/data/datasource/remote/address/address_view.dart';
import 'package:e_commerce/data/model/address_model.dart';
import 'package:e_commerce/view/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

abstract class AddressController extends GetxController {
  addAddress();

  viewAddress();

  deleteAdderss(String addressId);

  goToPageAddressEdit(AddressModel addressModel);

  goToPageAddressAdd();

  editeAddress(
    String idAddress,
    String oldName,
    String oldDesc,
    String oldCity,
    String oldStreet,
    String oldPhone,
  );

  toggleGps(bool val);

  getCurrentLocation();

  updateLocation(double newLat, double newLong);
}

class AddressControllerImp extends AddressController {
  bool useGps = false;
  double lat = 0.0;
  double long = 0.0;
  String? cityG;
  String? streetG;
  late TextEditingController city;
  late TextEditingController street;
  late TextEditingController phone;
  late TextEditingController nameAddress;
  late TextEditingController description;
  List<AddressModel> data = [];
  AddressAddData addressAddData = AddressAddData(Get.find());
  AddressView addressView = AddressView(Get.find());
  AddressDelete addressDelete = AddressDelete(Get.find());
  AddressEdit addressEdit = AddressEdit(Get.find());
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  @override
  toggleGps(val) {
    useGps = val;
    if (useGps) {
      getCurrentLocation();
    } else {
      long = 0.0;
      lat = 0.0;
    }
    update();
  }

  @override
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    lat = position.latitude;
    long = position.longitude;
    update();
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark placemark = placemarks[0];
    cityG = placemark.locality;
    streetG = placemark.street;
  }

  @override
  updateLocation(double newLat, double newLong) async {
    lat = newLat;
    long = newLong;
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
      Placemark placemark = placeMarks[0];
      cityG = placemark.locality;
      streetG = placemark.street;
    } catch (e) {
      cityG = "unknown";
      streetG = "unknown";
    }
    update();
  }

  @override
  addAddress() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await addressAddData.setDataAddAddress(
        myServices.sharedPref.getString('userid')!,
        nameAddress.text,
        useGps ? cityG! : city.text,
        useGps ? streetG! : street.text,
        description.text,
        phone.text,
        lat.toString(),
        long.toString(),
      );
      statusRequest = handlingData(response);
      update();
      if (response['status'] == "success") {
        nameAddress.clear();
        city.clear();
        street.clear();
        description.clear();
        phone.clear();
        lat = 0.0;
        long = 0.0;
        viewAddress();
        Get.back();
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  @override
  viewAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    data.clear();
    var response = await addressView.getData(
      myServices.sharedPref.getString("userid")!,
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.clear();
        List responseData = response['data'];
        data.addAll(responseData.map((e) => AddressModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  @override
  deleteAdderss(addressId) async {
    var response = await addressDelete.deleteData(addressId);
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.removeWhere((e) => e.addressId.toString() == addressId);
        customShowTopSnackBar(
          " تمت العملية بنجاح",
          "تم ازالة الموقع من ضمن قائمة المواقع",
          "",
          Icons.delete_outline,
          () {},
        );
      } else {}
    } else {}
  }

  @override
  editeAddress(
    idAddress,
    oldName,
    oldDesc,
    oldCity,
    oldStreet,
    oldPhone,
  ) async {
    String newName = nameAddress.text.trim();
    String newDesc = description.text.trim();
    String newCity = city.text.trim();
    String newStreet = street.text.trim();
    String newPhone = phone.text.trim();
    if (newName == oldName &&
        newDesc == oldDesc &&
        newCity == oldCity &&
        newStreet == oldStreet &&
        newPhone == oldPhone) {
      customShowTopSnackBar(
        "لم يتم التعديل",
        "لم تقم بإجراء أي تغييرات على العنوان.",
        "حنسا",
        Icons.error_outline,
        () {
          Get.back();
        },
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressEdit.editData(
      idAddress,
      newName,
      newStreet,
      newCity,
      newDesc,
      newPhone,
    );
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back();
        viewAddress();
      }
    } else {}
  }

  @override
  goToPageAddressEdit(AddressModel addressModel) {
    nameAddress.text = addressModel.addressName!;
    description.text = addressModel.addressDescription!;
    city.text = addressModel.addressCity!;
    street.text = addressModel.addressStreet!;
    phone.text = addressModel.addressPhone!.toString();
    Get.toNamed(
      AppRoutes.addressEdit,
      arguments: {"addressId": addressModel.addressId},
    );
  }

  @override
  goToPageAddressAdd() {
    nameAddress.clear();
    city.clear();
    street.clear();
    description.clear();
    phone.clear();
    lat = 0.0;
    long = 0.0;
    cityG = null;
    streetG = null;
    Get.toNamed(AppRoutes.addressAdd);
  }

  @override
  void onInit() {
    super.onInit();
    nameAddress = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();
    description = TextEditingController();
    phone = TextEditingController();
    useGps = false;
    viewAddress();
  }

  @override
  void dispose() {
    super.dispose();
    nameAddress.dispose();
    city.dispose();
    street.dispose();
    description.dispose();
    phone.dispose();
  }
}
