// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../config/exports/design_system_barrel.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? selectedValue;
  final List<DropdownItem<T>> items;
  final Function(T?) onChanged;
  final String hintText;
  final String? labelText;
  final bool isRequired;
  final String? errorText;
  final double maxHeight;
  final bool enabled;

  const CustomDropdown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText = 'Selecciona una opción',
    this.labelText,
    this.isRequired = false,
    this.errorText,
    this.maxHeight = 216.0,
    this.enabled = true,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  DropdownItem<T>? _selectedItem;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _iconRotation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.selectedValue != null) {
      _selectedItem = widget.items.firstWhere(
        (item) => item.value == widget.selectedValue,
        orElse: () => widget.items.first,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _selectItem(DropdownItem<T> item) {
    setState(() {
      _selectedItem = item;
      _isExpanded = false;
    });
    _animationController.reverse();
    widget.onChanged(item.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Row(
            children: [
              AppText.body2(
                widget.labelText!,
                color: AppColors.neutral700,
              ),
              if (widget.isRequired)
                AppText.body2(
                  ' *',
                  color: AppColors.error,
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.error
                  : _isExpanded
                      ? AppColors.neutral300
                      : AppColors.neutral300,
              width: _isExpanded ? 2 : 1,
            ),
            color: widget.enabled ? AppColors.white : AppColors.neutral100,
          ),
          child: Column(
            children: [
              // Header del dropdown
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _toggleDropdown,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _selectedItem != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.body1(
                                      _selectedItem!.title,
                                      color: widget.enabled
                                          ? AppColors.neutral900
                                          : AppColors.neutral500,
                                    ),
                                    if (_selectedItem!.subtitle != null &&
                                        _selectedItem!
                                            .subtitle!.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      AppText.caption(
                                        _selectedItem!.subtitle!,
                                        color: widget.enabled
                                            ? AppColors.neutral600
                                            : AppColors.neutral400,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                )
                              : AppText.body1(
                                  widget.hintText,
                                  color: widget.enabled
                                      ? AppColors.neutral500
                                      : AppColors.neutral400,
                                ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedBuilder(
                          animation: _iconRotation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _iconRotation.value * math.pi,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: widget.enabled
                                    ? (_isExpanded
                                        ? AppColors.neutral500
                                        : AppColors.neutral500)
                                    : AppColors.neutral400,
                                size: 24,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Lista desplegable animada
              AnimatedBuilder(
                animation: _expandAnimation,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: _expandAnimation.value *
                          math.min(
                              widget.items.length * 72.0, widget.maxHeight),
                      child: _expandAnimation.value > 0
                          ? Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColors.neutral200,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: widget.items.length,
                                itemBuilder: (context, index) {
                                  final item = widget.items[index];
                                  final isSelected =
                                      _selectedItem?.value == item.value;

                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => _selectItem(item),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primary100
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText.body1(
                                                    item.title,
                                                    color: isSelected
                                                        ? AppColors.primary700
                                                        : AppColors.neutral900,
                                                  ),
                                                  if (item.subtitle != null &&
                                                      item.subtitle!
                                                          .isNotEmpty) ...[
                                                    const SizedBox(height: 2),
                                                    AppText.caption(
                                                      item.subtitle!,
                                                      color: isSelected
                                                          ? AppColors.primary600
                                                          : AppColors
                                                              .neutral600,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                            if (isSelected) ...[
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.check_circle,
                                                color: AppColors.primary600,
                                                size: 20,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          AppText.caption(
            widget.errorText!,
            color: AppColors.error,
          ),
        ],
      ],
    );
  }
}

// Modelo genérico para items del dropdown
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
