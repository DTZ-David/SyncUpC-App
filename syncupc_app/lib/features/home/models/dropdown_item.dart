// Modelo genérico para items del dropdown
import 'package:flutter/material.dart';

class DropdownItem<T> {
  final T value;
  final String title;
  final String? subtitle;
  final IconData? icon;

  const DropdownItem({
    required this.value,
    required this.title,
    this.subtitle,
    this.icon,
  });
}
