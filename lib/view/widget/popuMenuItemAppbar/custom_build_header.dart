import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:flutter/material.dart';

class CustomBuildHeader extends StatelessWidget {
  final MyServices myServices;

  const CustomBuildHeader({super.key, required this.myServices});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.hotRed.withAlpha(230),

      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 0.0,
        left: 25.0,
        right: 25.0,
      ),
      child: Column(
        children: [
          // pic
          Stack(
            children: [
              Container(
                width: 88.0,
                height: 88.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellowAccent.withAlpha(150),
                      blurRadius: 10.0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/profile/profile3.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      );
                    },
                  ),
                ),
              ),

              //onLine
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.8),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10.0,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          //name
          Text(
            myServices.sharedPref.getString("username")!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8.0),

          // dis
          Text(
            myServices.sharedPref.getString("email")!,
            style: TextStyle(
              color: Colors.white.withAlpha(150),
              fontSize: 14.0,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
