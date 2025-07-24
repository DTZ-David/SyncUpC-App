import 'dart:ui';

class PopupAction {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool dismissOnPress;

  const PopupAction({
    required this.text,
    this.onPressed,
    this.isPrimary = false,
    this.dismissOnPress = true,
  });
}
