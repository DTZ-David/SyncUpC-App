// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'loading_screen_widget.dart';
import 'loading_types.dart';

extension LoadingScreenExtension on BuildContext {
  void showLoadingDialog({
    LoadingType type = LoadingType.simple,
    String? title,
    String? subtitle,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => LoadingScreen(
        type: type,
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }
}

Future<void> showAutoLoadingDialog(
  BuildContext context, {
  LoadingType type = LoadingType.success,
  String? title,
  String? subtitle,
  Duration duration = const Duration(seconds: 2),
  VoidCallback? onComplete,
}) async {
  context.showLoadingDialog(type: type, title: title, subtitle: subtitle);
  await Future.delayed(duration);
  Navigator.of(context, rootNavigator: true).pop();
  await Future.delayed(const Duration(milliseconds: 50));
  onComplete?.call();
}
