import 'package:flutter/material.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class AppTypography {
  static const String fontFamily = 'Nunito';

  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight semiBold = FontWeight.w600;

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: extraBold,
    color: AppColors.neutral900,
    height: 1.2,
  );
  static const TextStyle smallSemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: semiBold,
    color: AppColors.neutral900, // o cualquier color que prefieras
    height: 1.2,
  );

  static const TextStyle smallStep = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: regular,
    color: AppColors.neutral900, // o cualquier color que prefieras
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: extraBold,
    color: AppColors.neutral900,
    height: 1.3,
  );

  static const TextStyle time = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: bold,
    color: AppColors.nunitoBoldTime,
    height: 1.3,
  );

  static const TextStyle forgotPassword = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: extraBold,
      color: AppColors.neutral900,
      height: 1.3,
      decoration: TextDecoration.underline);

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: bold,
    color: AppColors.neutral900,
    height: 1.3,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: bold,
    color: AppColors.neutral800,
    height: 1.4,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: extraBold,
    color: AppColors.neutral800,
    height: 1.4,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: regular,
    color: AppColors.neutral700,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: regular,
    color: AppColors.neutral900,
    height: 1.4,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: bold,
    color: AppColors.neutral900,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.neutral500,
    height: 1.3,
  );

  static const TextStyle profilePic = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: medium,
    color: AppColors.neutral500,
    height: 1.3,
  );
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: bold,
    height: 1.2,
  );
  static const TextStyle feed = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.nunitoBoldTime,
  );
}
