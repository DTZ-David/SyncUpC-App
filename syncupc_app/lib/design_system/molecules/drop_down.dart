// molecules/dropdown_molecule.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../config/exports/design_system_barrel.dart';
import '../models/dropdown_item.dart';
import '../atoms/dropdown_header_atom.dart';
import '../atoms/dropdown_item_atom.dart';
import '../atoms/form_label_atom.dart';
import '../atoms/form_error_atom.dart';

class DropdownMolecule<T> extends StatefulWidget {
  final T? selectedValue;
  final List<DropdownItem<T>> items;
  final Function(T?)? onChanged;
  final String hintText;
  final String? labelText;
  final bool isRequired;
  final String? errorText;
  final double maxHeight;
  final bool enabled;

  const DropdownMolecule({
    super.key,
    this.selectedValue,
    required this.items,
    this.onChanged,
    this.hintText = 'Selecciona una opción',
    this.labelText,
    this.isRequired = false,
    this.errorText,
    this.maxHeight = 216.0,
    this.enabled = true,
  });

  @override
  State<DropdownMolecule<T>> createState() => _DropdownMoleculeState<T>();
}

class _DropdownMoleculeState<T> extends State<DropdownMolecule<T>>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  DropdownItem<T>? _selectedItem;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeSelectedItem();
  }

  void _initializeAnimations() {
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
  }

  void _initializeSelectedItem() {
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
    widget.onChanged!(item.value);
  }

  Color get _borderColor {
    if (widget.errorText != null) return AppColors.error;
    if (_isExpanded) return AppColors.neutral300;
    return AppColors.neutral300;
  }

  double get _borderWidth => _isExpanded ? 2 : 1;

  Color get _backgroundColor =>
      widget.enabled ? AppColors.white : AppColors.neutral100;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label usando atom
        if (widget.labelText != null) ...[
          FormLabelAtom(
            labelText: widget.labelText!,
            isRequired: widget.isRequired,
          ),
          const SizedBox(height: 8),
        ],

        // Container principal del dropdown
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _borderColor,
              width: _borderWidth,
            ),
            color: _backgroundColor,
          ),
          child: Column(
            children: [
              // Header usando atom
              DropdownHeaderAtom(
                selectedTitle: _selectedItem?.title,
                selectedSubtitle: _selectedItem?.subtitle,
                hintText: widget.hintText,
                enabled: widget.enabled,
                isExpanded: _isExpanded,
                iconRotation: _iconRotation,
                onTap: _toggleDropdown,
              ),

              // Lista expandible
              _buildExpandableList(),
            ],
          ),
        ),

        // Error usando atom
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          FormErrorAtom(errorText: widget.errorText!),
        ],
      ],
    );
  }

  Widget _buildExpandableList() {
    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: SizedBox(
            height: _expandAnimation.value *
                math.min(widget.items.length * 72.0, widget.maxHeight),
            child: _expandAnimation.value > 0 ? _buildItemsList() : null,
          ),
        );
      },
    );
  }

  Widget _buildItemsList() {
    return Container(
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
          final isSelected = _selectedItem?.value == item.value;

          return DropdownItemAtom<T>(
            item: item,
            isSelected: isSelected,
            onTap: () => _selectItem(item),
          );
        },
      ),
    );
  }
}
