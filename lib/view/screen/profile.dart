import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/profile/custom_appBar_silver.dart';
import 'package:e_commerce/view/widget/profile/custom_main_menu.dart';
import 'package:e_commerce/view/widget/profile/custom_profile_card.dart';
import 'package:e_commerce/view/widget/profile/custom_quick_actions.dart';
import 'package:e_commerce/view/widget/profile/custom_stats_grid.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomSideMenu(),

      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        slivers: [
          // App Bar
          CustomAppbarSilver(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Premium Membership And Count Point
                  CustomProfileCard(
                    levelType: 'Gold level',
                    numberPoints: "15.5K",
                  ),
                  const SizedBox(height: 24),

                  // Statistics
                  CustomStatsGrid(),
                  const SizedBox(height: 24),

                  // Quick Actions
                  CustomQuickActions(),
                  const SizedBox(height: 24),

                  // Main menu
                  CustomMainMenu(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
