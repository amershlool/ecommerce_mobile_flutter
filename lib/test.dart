import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/lottie.dart';
import 'package:e_commerce/view/widget/error/customerror.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: const CustomError( animation: AppLottieAsset.lottie_loading));
  }
}
