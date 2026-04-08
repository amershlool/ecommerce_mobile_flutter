import 'dart:io';

Future<bool> checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("Internet connection is available.===================================");
      return true;
    }
  } on SocketException catch (_) {
    // في حالة عدم وجود اتصال بالإنترنت أو خطأ في المقبس
    return false;
  }
  // أضف هذا السطر لضمان إرجاع قيمة في جميع الحالات
  // إذا لم يتم تلبية شرط الـ if ولم يحدث خطأ SocketException
  return false;
}
