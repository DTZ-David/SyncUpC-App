import 'package:flutter/material.dart';
import '../../../../config/exports/design_system_barrel.dart';
import '../atoms/popup_icon_atom.dart';
import '../atoms/popup_container_atom.dart';
import '../models/popup_action.dart';

class ConfirmationPopupMolecule extends StatefulWidget {
  final String message;
  final PopupType type;
  final Duration? duration;
  final VoidCallback? onDismiss;
  final String? subtitle;
  final List<PopupAction>? actions;
  final double? width;

  const ConfirmationPopupMolecule({
    super.key,
    required this.message,
    this.type = PopupType.success,
    this.duration,
    this.onDismiss,
    this.subtitle,
    this.actions,
    this.width,
  });

  @override
  State<ConfirmationPopupMolecule> createState() =>
      _ConfirmationPopupMoleculeState();
}

class _ConfirmationPopupMoleculeState extends State<ConfirmationPopupMolecule>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAutoClose();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  void _startAutoClose() {
    if (widget.duration != null && widget.type != PopupType.loading) {
      Future.delayed(widget.duration!, () {
        if (mounted) _dismiss();
      });
    }
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismiss?.call();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupContainerAtom(
      width: widget.width ?? _getDefaultWidth(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: _buildContent(),
            ),
          );
        },
      ),
    );
  }

  double _getDefaultWidth() {
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      return 300;
    }
    return 240;
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icono
        PopupIconAtom(type: widget.type),
        const SizedBox(height: 16),

        // Mensaje principal
        AppText.body1(
          widget.message,
          textAlign: TextAlign.center,
          color: AppColors.neutral900,
        ),

        // Subtitle opcional
        if (widget.subtitle != null) ...[
          const SizedBox(height: 8),
          AppText.caption(
            widget.subtitle!,
            textAlign: TextAlign.center,
            color: AppColors.neutral600,
          ),
        ],

        // Acciones opcionales
        if (widget.actions != null && widget.actions!.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildActions(),
        ],
      ],
    );
  }

  Widget _buildActions() {
    if (widget.actions!.length == 1) {
      return SizedBox(
        width: double.infinity,
        child: _buildActionButton(widget.actions!.first),
      );
    }

    return Row(
      children: widget.actions!.map((action) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.actions!.indexOf(action) > 0 ? 8 : 0,
            ),
            child: _buildActionButton(action),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(PopupAction action) {
    return ElevatedButton(
      onPressed: () {
        action.onPressed?.call();
        if (action.dismissOnPress) {
          _dismiss();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            action.isPrimary ? _getPrimaryColor() : AppColors.neutral100,
        foregroundColor: action.isPrimary ? Colors.white : AppColors.neutral700,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: AppText.body2(
        action.text,
        color: action.isPrimary ? Colors.white : AppColors.neutral700,
      ),
    );
  }

  Color _getPrimaryColor() {
    switch (widget.type) {
      case PopupType.success:
        return AppColors.success;
      case PopupType.error:
        return AppColors.error;
      case PopupType.warning:
        return AppColors.warning;
      case PopupType.info:
      case PopupType.loading:
        return AppColors.primary200;
    }
  }
}
