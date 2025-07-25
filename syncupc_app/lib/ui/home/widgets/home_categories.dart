import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';

class HomeCategories extends ConsumerWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(eventTagsProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText.feed("Categorías"),
            AppText("Ver más",
                style: TextStyle(
                  color: AppColors.primary200,
                  fontFamily: 'Nunito',
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary200,
                )),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: tags.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategory("Todas"),
                    ...tags.map((tag) => _buildCategory(tag)),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildCategory(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: AppText.caption(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.neutral400, width: 0.5),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
