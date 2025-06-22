import 'package:flutter/material.dart';
import '../protons/typography.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final IconData? icon;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
    this.icon,
  });

  const AppText.smallStep(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.smallStep;

  const AppText.heading1(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.heading2;

  const AppText.button(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.button;

  const AppText.subtitle2(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.subtitle2;

  const AppText.forgotPassword(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.forgotPassword;

  const AppText.heading3(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.heading3;

  const AppText.time(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.time;

  const AppText.heading2(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.heading2;

  const AppText.body1(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.icon,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.body1;
  const AppText.settings(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.icon,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.settingsStyle;

  const AppText.body2(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.body2;

  const AppText.profilePic(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.profilePic;
  const AppText.caption(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.caption;

  const AppText.body3(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.body3;

  const AppText.feed(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.feed;

  const AppText.semiBold(
    this.text, {
    super.key,
    this.textAlign,
    this.icon,
    this.color,
    this.maxLines,
    this.overflow,
  }) : style = AppTypography.smallSemiBold;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: style?.copyWith(color: color) ?? TextStyle(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    // Si hay ícono, lo dibujamos junto con el texto en un Row
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: style?.fontSize ?? 14, color: color ?? style?.color),
          const SizedBox(width: 4),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
