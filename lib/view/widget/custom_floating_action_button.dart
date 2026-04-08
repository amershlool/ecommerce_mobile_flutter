import 'package:e_commerce/core/constant/color.dart';

import 'package:flutter/material.dart';



class CustomFloatingActionButton extends StatelessWidget {

  const CustomFloatingActionButton({super.key});



  @override

  Widget build(BuildContext context) {

    return FloatingActionButton(

      backgroundColor: AppColor.coldOrange,

      shape: CircleBorder(),

      onPressed: () {},

      child: Icon(Icons.shopping_bag_outlined,color: Colors.black54,),

    );

  }

}