import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/utils/loading_screens/loading_screen.dart';

class LoadingScreen extends ConsumerWidget {
  final LoadingType type;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? indicatorColor;
  final bool showIndicator;

  const LoadingScreen({
    super.key,
    this.type = LoadingType.simple,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.textColor,
    this.indicatorColor,
    this.showIndicator = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (type) {
      case LoadingType.custom:
        return CustomLoadingScreen(
          title: title!,
          subtitle: subtitle!,
          backgroundColor: backgroundColor,
          textColor: textColor,
          indicatorColor: indicatorColor,
        );
      case LoadingType.success:
        return SuccessLoadingScreen(
          backgroundColor: backgroundColor,
          textColor: textColor,
          indicatorColor: indicatorColor,
        );
      case LoadingType.simple:
        return SimpleLoadingScreen(
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          showIndicator: showIndicator,
        );
    }
  }
}
