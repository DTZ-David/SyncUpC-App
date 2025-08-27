import 'package:flutter/material.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class ExpandableTitle extends StatefulWidget {
  final String title;
  final int maxLines;

  const ExpandableTitle({
    super.key,
    required this.title,
    this.maxLines = 2,
  });

  @override
  State<ExpandableTitle> createState() => _ExpandableTitleState();
}

class _ExpandableTitleState extends State<ExpandableTitle> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Detectamos si el texto es "largo" de forma simple
    final isLongText =
        widget.title.length > 80; // Ajusta este número según necesites

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.heading3(
          widget.title,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (isLongText) // Solo muestra el botón si el texto es largo
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primary200,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
