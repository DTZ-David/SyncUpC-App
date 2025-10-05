// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';

class AttendanceConfirmationPopup extends StatefulWidget {
  final String title;

  const AttendanceConfirmationPopup({super.key, required this.title});

  @override
  State<AttendanceConfirmationPopup> createState() =>
      _AttendanceConfirmationPopupState();
}

class _AttendanceConfirmationPopupState
    extends State<AttendanceConfirmationPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();

    // Auto cerrar después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 240,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded,
                      size: 56, color: AppColors.primary200),
                  const SizedBox(height: 16),
                  AppText.body1(
                    widget.title,
                    textAlign: TextAlign.center,
                    color: AppColors.neutral900,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
