import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomExitDialog extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onPressedCon;

  const CustomExitDialog({super.key, required this.onPressed,required this.onPressedCon});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      curve: Curves.easeInOut,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetAnimationDuration: Duration(microseconds: 400),
        insetAnimationCurve: Curves.elasticOut,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColor.hotRed, Colors.blueGrey],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(200),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  // Animated Icon
                  AnimatedContainer(
                    duration: Duration(microseconds: 500),
                    curve: Curves.elasticOut,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withAlpha(30),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.white,
                      size: 45,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  // Title with gradient text
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Colors.indigoAccent, Colors.amber.shade100],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Exit Application',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Description
                  Text(
                    'You\'re about to close the application. Are you sure you want to exit?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 30),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(15),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withAlpha(40),
                              width: 1.5,
                            ),
                          ),
                          child: TextButton(
                            onPressed: onPressed,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'STAY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.hotRed,
                                Color(0xFFee5a52),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: onPressedCon,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'EXIT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
