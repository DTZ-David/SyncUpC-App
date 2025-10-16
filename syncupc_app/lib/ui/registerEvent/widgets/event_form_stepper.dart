import 'package:flutter/material.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import '../models/event_form_step.dart';

class EventFormStepper extends StatelessWidget {
  final EventFormStep currentStep;

  const EventFormStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: List.generate(
          EventFormStep.totalSteps,
          (index) {
            final step = EventFormStep.values[index];
            final isActive = step.index <= currentStep.index;
            final isCurrent = step == currentStep;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? AppColors.primary500
                                : AppColors.neutral300,
                            border: isCurrent
                                ? Border.all(
                                    color: AppColors.primary700, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${step.stepNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    isCurrent ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          step.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: isActive
                                ? AppColors.neutral900
                                : AppColors.neutral500,
                            fontWeight:
                                isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (index < EventFormStep.totalSteps - 1)
                    Container(
                      width: 24,
                      height: 2,
                      color: isActive && step.index < currentStep.index
                          ? AppColors.primary500
                          : AppColors.neutral300,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
