import 'package:flutter/material.dart';
class CustomTextAndTitle extends StatelessWidget {
  final String text ;
  final String title ;
  const CustomTextAndTitle({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
         Text(
          title,
          style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
