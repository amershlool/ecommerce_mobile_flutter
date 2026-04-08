import 'package:get/get.dart';

String? validatorInput( String val ,int min,int max,String type){
  if (val.isEmpty){
    return "valid1".tr;
  }
  if (val.length < min ){
    return "${"valid2".tr} $min";
  }
  if (val.length > max ){
    return "${"valid3".tr} $max";
  }


  if ( type == "username"){
    if(!GetUtils.isUsername(val)){
      return "valid4".tr;
    }
  }
  if ( type == "email"){
    if(!GetUtils.isEmail(val)){
      return "valid5".tr;
    }
  }
  if ( type == "phone"){
    if(!GetUtils.isPhoneNumber(val)){
      return "valid6".tr;
    }
  }

  return null;
}
