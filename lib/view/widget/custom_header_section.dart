import 'package:animate_do/animate_do.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomHeaderSection extends StatelessWidget {
  final String title ;
  final String body ;
  final int withAlpha ;
  const CustomHeaderSection({super.key, required this.title, required this.body, required this.withAlpha});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.hotRed.withAlpha(withAlpha), Colors.transparent],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xFF4A4A4A),
                    Color(0xFFD32F2F),
                  ],
                ).createShader(bounds);
              },

              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  fontFamily: 'Amiri',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
             body,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
    ;
  }
}
