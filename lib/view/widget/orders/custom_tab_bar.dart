import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final String nameTab1;
  final String nameTab2;
  final String nameTab3;
  final String nameTab4;
  final String nameTab5;

  const CustomTabBar({
    super.key,
    required this.nameTab1,
    required this.nameTab2,
    required this.nameTab3,
    required this.nameTab4,
    required this.nameTab5,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: AppColor.hotRed,
      labelColor: AppColor.hotRed,
      unselectedLabelColor: AppColor.grey,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        fontFamily: 'PlayfairDisplay',
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        fontFamily: 'PlayfairDisplay',
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),

      tabs: [
        Tab(icon: Icon(Icons.list_alt), text: nameTab1),
        Tab(icon: Icon(Icons.access_time), text: nameTab2),
        Tab(icon: Icon(Icons.pending_actions), text: nameTab3),
        Tab(icon: Icon(Icons.local_shipping), text: nameTab4),
        Tab(icon: Icon(Icons.history), text: nameTab5),
      ],
    );
  }
}