import 'package:get/get.dart';

String? validatorInputAddAddress( String val ,int min,int max){
  if (val.isEmpty){
    return "valid1".tr;
  }
  if (val.length < min ){
    return "${"valid2".tr} $min";
  }
  if (val.length > max ){
    return "${"valid3".tr} $max";
  }

  return null;
}
