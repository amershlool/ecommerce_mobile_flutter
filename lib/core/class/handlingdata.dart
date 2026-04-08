import 'package:flutter/material.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/lottie.dart';
import 'package:e_commerce/view/widget/error/customerror.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ?const CustomError( animation: AppLottieAsset.lottie_loading)
        : statusRequest == StatusRequest.offLineFailure
            ?const  CustomError( animation: AppLottieAsset.no_internet,)
            : statusRequest == StatusRequest.serverFailure
                ? const CustomError( animation: AppLottieAsset.connection_error,)
                : statusRequest == StatusRequest.failure
                    ? const CustomError( animation: AppLottieAsset.notFoundData,)
                    : widget;
  }
}
class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ?const CustomError( animation: AppLottieAsset.lottie_loading)
        : statusRequest == StatusRequest.offLineFailure
            ?const  CustomError( animation: AppLottieAsset.no_internet,)
            : statusRequest == StatusRequest.serverFailure
                ? const CustomError( animation: AppLottieAsset.connection_error,)
        : widget;
  }
}
