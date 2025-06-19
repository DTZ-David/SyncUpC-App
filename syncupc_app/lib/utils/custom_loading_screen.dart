import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';

// Loading Screen Personalizado (como el de la imagen)
class CustomLoadingScreen extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? indicatorColor;

  const CustomLoadingScreen({
    super.key,
    this.title = "¡Vamos a crear tu cuenta!",
    this.subtitle =
        "Solo unos pasos más para empezar a explorar los mejores eventos cerca de ti.",
    this.backgroundColor,
    this.textColor,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primary50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Título principal
              AppText.heading1(
                title,
                textAlign: TextAlign.center,
                color: textColor ?? Colors.black,
              ),

              const SizedBox(height: 40),

              // Indicador de carga personalizado
              _buildCustomLoadingIndicator(),

              const SizedBox(height: 40),

              // Subtítulo
              AppText.body1(
                subtitle,
                textAlign: TextAlign.center,
                color: textColor ?? Colors.black87,
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomLoadingIndicator() {
    return SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          indicatorColor ?? Colors.black54,
        ),
      ),
    );
  }
}

// Loading Screen Simple (pantalla en blanco)
class SimpleLoadingScreen extends ConsumerWidget {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final bool showIndicator;

  const SimpleLoadingScreen({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.showIndicator = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundAccent,
      body: SafeArea(
        child: Center(
          child: showIndicator
              ? _buildCustomLoadingIndicator()
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildCustomLoadingIndicator() {
    return SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          indicatorColor ?? AppColors.primary500,
        ),
      ),
    );
  }
}

// Enum para tipos de loading
enum LoadingType {
  custom,
  simple,
}

// Widget principal que maneja diferentes tipos de loading
class LoadingScreen extends ConsumerWidget {
  final LoadingType type;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? indicatorColor;
  final String? logoPath;
  final bool showIndicator;

  const LoadingScreen({
    super.key,
    this.type = LoadingType.simple,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.textColor,
    this.indicatorColor,
    this.logoPath,
    this.showIndicator = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (type) {
      case LoadingType.custom:
        return CustomLoadingScreen(
          title: title ?? "¡Vamos a crear tu cuenta!",
          subtitle: subtitle ??
              "Solo unos pasos más para empezar a explorar los mejores eventos cerca de ti.",
          backgroundColor: backgroundColor,
          textColor: textColor,
          indicatorColor: indicatorColor,
        );

      case LoadingType.simple:
      default:
        return SimpleLoadingScreen(
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          showIndicator: showIndicator,
        );
    }
  }
}

// Extension para fácil uso
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
      builder: (context) => LoadingScreen(
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
