import 'package:flutter/material.dart';
import 'dart:ui';

class PopupContainerAtom extends StatelessWidget {
  final Widget child;
  final double width;
  final Color? backgroundColor;
  final double borderRadius;

  const PopupContainerAtom({
    super.key,
    required this.child,
    this.width = 240,
    this.backgroundColor,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            width: width,
            child: child,
          ),
        ),
      ),
    );
  }
}
