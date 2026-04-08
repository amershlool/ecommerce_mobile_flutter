import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/checkinternet.dart';
import 'package:http/http.dart' as http;
class Crud {

  Future<Either<StatusRequest, Map>> postData( String linkUrl, Map data) async {
      if (await checkInternet()) {
        print("+++++++++++++++++++++++postData++++++++++++++++++++++++++++++++");

        var response = await http.post(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          print("+++++++++++++++++++++++responseBodyYes++++++++++++++++++++++++++++++++ $responseBody");
          return Right(responseBody);

        } else {
          print("+++++++++++++++++++++++responseBody else ++++++++++++++++++++++++++++++++");
          return const Left(StatusRequest.serverFailure);
        }

      } else {

        return const Left(StatusRequest.offLineFailure);
      }
  }
}
