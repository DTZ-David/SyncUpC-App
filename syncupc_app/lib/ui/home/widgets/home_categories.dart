import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategory("Todas"),
              _buildCategory("Cultura"),
              _buildCategory("Sociales"),
              _buildCategory("Deportes"),
              _buildCategory("Conciertos"),
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
