import 'package:flutter/material.dart';
import '../../../../config/exports/design_system_barrel.dart';

class FormLabelAtom extends StatelessWidget {
  final String labelText;
  final bool isRequired;

  const FormLabelAtom({
    super.key,
    required this.labelText,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText.body2(
          labelText,
          color: AppColors.neutral700,
        ),
        if (isRequired)
          AppText.body2(
            ' *',
            color: AppColors.error,
          ),
      ],
    );
  }
}
