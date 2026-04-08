import 'package:e_commerce/view/widget/profile/custom_background_header.dart';
import 'package:flutter/material.dart';

class CustomAppbarSilver extends StatelessWidget {
  final void Function()? onPressed;

  const CustomAppbarSilver({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      collapsedHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(background: CustomBackgroundHeader()),
    );
  }
}
