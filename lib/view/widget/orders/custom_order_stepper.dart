import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
class CustomOrderStepper extends StatelessWidget {
  final String status;

  const CustomOrderStepper({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final List<StepData> steps = [
      StepData('0', Icons.pending_actions),
      StepData('1', Icons.local_shipping),
      StepData('2', Icons.check_circle_outline),
    ];

    final int currentStepIndex = steps.indexWhere(
          (step) => step.name == status,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final bool isCurrent = index == currentStepIndex;
        final bool isCompleted = index < currentStepIndex;
        final bool isCanceled = status == '3';
        final bool isFirstStep = index == 0;
        final bool isLastStep = index == steps.length - 1;

        Color activeColor = isCanceled
            ? Colors.red.shade600
            : AppColor.hotRed;
        Color inactiveColor = Colors.grey.shade400;
        Color stepColor = isCompleted ? activeColor : inactiveColor;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (!isFirstStep)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: (isCompleted || (isLastStep && index == currentStepIndex))
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? activeColor
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: stepColor, width: 2),
                    ),
                    child: Center(
                      child: isCanceled && isCurrent
                          ? const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      )
                          : Icon(
                        isCompleted ? Icons.check : steps[index].icon,
                        color: isCompleted || isCurrent
                            ? Colors.white
                            : inactiveColor,
                        size: 20,
                      ),
                    ),
                  ),
                  if (!isLastStep)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted ? activeColor : inactiveColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
class StepData {
  final String name;
  final IconData icon;

  const StepData(this.name, this.icon);
}

