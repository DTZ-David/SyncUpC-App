import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/atoms/primary_button.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class ConfirmScanDialog extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onCancel;

  const ConfirmScanDialog({
    super.key,
    required this.onContinue,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Container(
            width: 332,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.body1(
                  "Estas a punto de escanear la asistencia a un evento",
                  textAlign: TextAlign.center,
                  color: AppColors.neutral900,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: "Cancelar",
                        variant: ButtonVariant.outlined,
                        onPressed: onCancel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        text: "Continuar",
                        variant: ButtonVariant.filled,
                        onPressed: onContinue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
