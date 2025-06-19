import 'package:flutter/material.dart';

extension WidgetListUtils on List<Widget> {
  void addIf(bool condition, Widget Function() builder) {
    if (condition) add(builder());
  }
}
