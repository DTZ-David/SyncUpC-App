import 'package:flutter/material.dart';

import '../design_system/atoms/popup_icon_atom.dart';
import '../design_system/models/popup_action.dart';
import '../design_system/molecules/confirmation_popup_molecule.dart';

class PopupUtils {
  static Future<void> showSuccess(
    BuildContext context, {
    required String message,
    String? subtitle,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.success,
        duration: duration ?? const Duration(seconds: 2),
        onDismiss: onDismiss,
      ),
    );
  }

  static Future<void> showError(
    BuildContext context, {
    required String message,
    String? subtitle,
    Duration? duration,
    VoidCallback? onDismiss,
    List<PopupAction>? actions,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.error,
        duration: duration ?? const Duration(seconds: 3),
        onDismiss: onDismiss,
        actions: actions,
      ),
    );
  }

  static Future<void> showWarning(
    BuildContext context, {
    required String message,
    String? subtitle,
    Duration? duration,
    VoidCallback? onDismiss,
    List<PopupAction>? actions,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.warning,
        duration: duration ?? const Duration(seconds: 3),
        onDismiss: onDismiss,
        actions: actions,
      ),
    );
  }

  static Future<void> showInfo(
    BuildContext context, {
    required String message,
    String? subtitle,
    Duration? duration,
    VoidCallback? onDismiss,
    List<PopupAction>? actions,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.info,
        duration: duration ?? const Duration(seconds: 2),
        onDismiss: onDismiss,
        actions: actions,
      ),
    );
  }

  static Future<void> showLoading(
    BuildContext context, {
    required String message,
    String? subtitle,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.loading,
        // Sin duración para loading
      ),
    );
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String message,
    String? subtitle,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationPopupMolecule(
        message: message,
        subtitle: subtitle,
        type: PopupType.warning,
        actions: [
          PopupAction(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          PopupAction(
            text: confirmText,
            isPrimary: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
