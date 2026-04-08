import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    return 'Android ${androidDeviceInfo.version.release}-${androidDeviceInfo.manufacturer}${androidDeviceInfo.model}';
  }else if (Platform.isIOS){
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo ;
    return 'IOS ${iosDeviceInfo.systemVersion}-${iosDeviceInfo.name}';
  }else{
    return 'Unknown Platform';
  }
}
