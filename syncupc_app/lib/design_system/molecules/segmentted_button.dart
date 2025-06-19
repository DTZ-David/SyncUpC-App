import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps + 1, (index) {
        // Último es la bandera
        if (index == totalSteps) {
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.flag_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
          );
        }

        final isActive = index == currentStep;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              Container(
                width: isActive ? 24 : 16,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary500 // Verde activo
                      : AppColors.neutral300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 4),
              AppText.smallStep(
                'Paso ${index + 1}',
              ),
            ],
          ),
        );
      }),
    );
  }
}
