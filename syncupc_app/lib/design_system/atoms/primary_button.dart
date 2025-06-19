import 'package:flutter/material.dart';

import '../protons/colors.dart';
import '../protons/spacing.dart';
import '../protons/typography.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Size? size;
  final ButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.size,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? double.infinity,
      height: size?.height ?? 56,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: variant == ButtonVariant.filled
              ? AppColors.primary500
              : AppColors.white,
          foregroundColor: variant == ButtonVariant.filled
              ? AppColors.white
              : AppColors.primary500,
          side: variant == ButtonVariant.outlined
              ? BorderSide(color: AppColors.neutral300)
              : BorderSide.none,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPadding,
            vertical: AppSpacing.sm,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(
                    text,
                    style: AppTypography.button.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

enum ButtonVariant { filled, outlined }
