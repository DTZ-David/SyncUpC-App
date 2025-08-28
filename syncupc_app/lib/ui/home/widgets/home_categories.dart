import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';

import '../../../features/home/providers/category_providers.dart';

class HomeCategories extends ConsumerWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(getAllCategoriesProvider);
    final selectedTag = ref.watch(selectedTagProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText.feed("Categorías"),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: categories.when(
            data: (list) => ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategory("Todas", selectedTag == null, ref),
                ...list.map(
                  (category) => _buildCategory(
                    category.name,
                    selectedTag == category.name,
                    ref,
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        )
      ],
    );
  }

  Widget _buildCategory(String label, bool isSelected, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          // Cambiar la categoría seleccionada
          if (label == "Todas") {
            ref.read(selectedTagProvider.notifier).state = null;
          } else {
            // Si ya está seleccionado, deseleccionar (opcional)
            if (isSelected) {
              ref.read(selectedTagProvider.notifier).state = null;
            } else {
              ref.read(selectedTagProvider.notifier).state = label;
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.caption(
                  label,
                  color: isSelected ? Colors.white : AppColors.neutral700,
                ),
                const SizedBox(width: 4),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isSelected ? AppColors.primary500 : AppColors.neutral400,
                width: isSelected ? 1.5 : 0.5,
              ),
            ),
            backgroundColor: isSelected ? AppColors.neutral500 : Colors.white,
            elevation: isSelected ? 2 : 0,
          ),
        ),
      ),
    );
  }
}
