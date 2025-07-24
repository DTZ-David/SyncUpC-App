import 'package:flutter/material.dart';
import '../../../../config/exports/design_system_barrel.dart';
import '../models/dropdown_item.dart';

class DropdownItemAtom<T> extends StatelessWidget {
  final DropdownItem<T> item;
  final bool isSelected;
  final VoidCallback onTap;

  const DropdownItemAtom({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary100 : Colors.transparent,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body1(
                      item.title,
                      color: isSelected
                          ? AppColors.primary700
                          : AppColors.neutral900,
                    ),
                    if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      AppText.caption(
                        item.subtitle!,
                        color: isSelected
                            ? AppColors.primary600
                            : AppColors.neutral600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
  }
}
