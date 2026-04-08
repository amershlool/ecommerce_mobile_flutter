import 'package:e_commerce/view/widget/profile/custom_stat_card.dart';
import 'package:flutter/material.dart';

class CustomStatsGrid extends StatelessWidget {
  const CustomStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        CustomStatCard(
          title: 'المشتريات',
          value: '24',
          icon: Icons.shopping_bag_rounded,
          color: const Color(0xFFCC0000),
        ),
        CustomStatCard(
          title: 'المفضلة',
          value: '12',
          icon: Icons.favorite_rounded,
          color: const Color(0xFFFF6B6B),
        ),
        CustomStatCard(
          title: 'التقييم',
          value: '4.8',
          icon: Icons.star_rounded,
          color: const Color(0xFFFFD166),
        ),
        CustomStatCard(
          title: 'النقاط',
          value: '1.5K',
          icon: Icons.workspace_premium_rounded,
          color: const Color(0xFFFF4444),
        ),
      ],
    );
  }
}
