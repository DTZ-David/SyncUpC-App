import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../config/exports/design_system_barrel.dart';

class DropdownHeaderAtom extends StatelessWidget {
  final String? selectedTitle;
  final String? selectedSubtitle;
  final String hintText;
  final bool enabled;
  final bool isExpanded;
  final Animation<double> iconRotation;
  final VoidCallback onTap;

  const DropdownHeaderAtom({
    super.key,
    this.selectedTitle,
    this.selectedSubtitle,
    required this.hintText,
    required this.enabled,
    required this.isExpanded,
    required this.iconRotation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Expanded(
                child: selectedTitle != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.body1(
                            selectedTitle!,
                            color: enabled
                                ? AppColors.neutral900
                                : AppColors.neutral500,
                          ),
                          if (selectedSubtitle != null &&
                              selectedSubtitle!.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            AppText.caption(
                              selectedSubtitle!,
                              color: enabled
                                  ? AppColors.neutral600
                                  : AppColors.neutral400,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      )
                    : AppText.body1(
                        hintText,
                        color: enabled
                            ? AppColors.neutral500
                            : AppColors.neutral400,
                      ),
              ),
              const SizedBox(width: 12),
              AnimatedBuilder(
                animation: iconRotation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: iconRotation.value * math.pi,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color:
                          enabled ? AppColors.neutral500 : AppColors.neutral400,
                      size: 24,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
