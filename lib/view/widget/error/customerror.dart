import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomError extends StatelessWidget {
  final String? numberError;

  final String? error;

  final String animation;

  const CustomError(
      {super.key, this.numberError, this.error, required this.animation});

  @override
  Widget build(BuildContext context) {
    return
      Center(

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset(animation, width: 1000,height: 300)),
          Column(
            children: [
              if (numberError != null)
                Text(
                  numberError!,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooBhaijaan'),
                ),
              if (error != null)
                Text(
                  error!,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooBhaijaan'),
                ),
            ],
          )
        ],
      ),
          );
  }
}
