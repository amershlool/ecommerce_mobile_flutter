import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  final bool isCompleted1;
  final bool isCompleted2;
  final bool isCompleted3;
  final bool isCompleted4;
  final bool isCancelled;

  const CustomTimeLine({
    super.key,
    required this.isCompleted1,
    required this.isCompleted2,
    required this.isCompleted3,
    required this.isCompleted4,
    required this.isCancelled,
  });

  double calculateProgress() {
    int completedSteps = 0;
    if (isCompleted1) completedSteps++;
    if (isCompleted2) completedSteps++;
    if (isCompleted3) completedSteps++;
    if (isCompleted4) completedSteps++;
    if (isCancelled) completedSteps = 0;
    return completedSteps / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.coldOrange2.withAlpha(50),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildTimelineStep(
                    title: 'Requested',
                    isCompleted: isCompleted1,
                    icon: Icons.check_circle,
                  ),
                  BuildTimelineStep(
                    title: 'Processing',
                    isCompleted: isCompleted2,
                    icon: Icons.inventory,
                  ),
                  BuildTimelineStep(
                    title: 'Out For Delivery',
                    isCompleted: isCompleted3,
                    icon: Icons.local_shipping,
                  ),
                  BuildTimelineStep(
                    title: 'Delivered',
                    isCompleted: isCompleted4,
                    icon: Icons.home,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: calculateProgress()),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[300],
                  color: AppColor.hotRed,
                  minHeight: 6,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BuildTimelineStep extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final IconData icon;

  const BuildTimelineStep({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColor.hotRed.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isCompleted ? AppColor.hotRed : Colors.grey[500],
            size: 28,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
            color: AppColor.darkGray,
          ),
        ),
      ],
    );
  }
}
