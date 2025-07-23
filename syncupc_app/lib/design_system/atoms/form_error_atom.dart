import 'package:flutter/material.dart';
import '../../../../config/exports/design_system_barrel.dart';

class FormErrorAtom extends StatelessWidget {
  final String errorText;

  const FormErrorAtom({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppText.caption(
      errorText,
      color: AppColors.error,
    );
  }
}
