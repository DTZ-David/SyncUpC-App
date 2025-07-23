// ============================================================================
// CHIP PARA CARRERA SELECCIONADA
// ============================================================================

import 'package:flutter/material.dart';

import '../../../design_system/protons/colors.dart';

class SelectedCareerChip extends StatelessWidget {
  final dynamic career; // Reemplaza con tu tipo de Career
  final VoidCallback onRemove;

  const SelectedCareerChip({
    super.key,
    required this.career,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary200.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary200.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school,
              size: 16,
              color: AppColors.primary200,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                career.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary200,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.red.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
