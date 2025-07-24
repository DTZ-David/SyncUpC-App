import 'package:flutter/material.dart';
import '../../../../config/exports/design_system_barrel.dart';

enum PopupType {
  success,
  error,
  warning,
  info,
  loading,
}

class PopupIconAtom extends StatelessWidget {
  final PopupType type;
  final double size;

  const PopupIconAtom({
    super.key,
    required this.type,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return _buildIcon();
  }

  Widget _buildIcon() {
    switch (type) {
      case PopupType.success:
        return Icon(
          Icons.check_circle_rounded,
          size: size,
          color: AppColors.success,
        );
      case PopupType.error:
        return Icon(
          Icons.error_rounded,
          size: size,
          color: AppColors.error,
        );
      case PopupType.warning:
        return Icon(
          Icons.warning_rounded,
          size: size,
          color: AppColors.warning,
        );
      case PopupType.info:
        return Icon(
          Icons.info_rounded,
          size: size,
          color: AppColors.primary200,
        );
      case PopupType.loading:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: AppColors.primary200,
            strokeWidth: 4,
          ),
        );
    }
  }
}
