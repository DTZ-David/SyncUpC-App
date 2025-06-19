import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class SearchBarDesign extends StatelessWidget {
  final bool filter;
  const SearchBarDesign({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Campo de texto con diseño redondeado y sin borde
      Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), // Más redondeado
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: AppTypography.body1,
            decoration: InputDecoration(
              hintText: "Busca tu evento favorito...",
              hintStyle:
                  AppTypography.body2.copyWith(color: AppColors.neutral400),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: SvgPicture.asset(
                  "assets/images/search.svg",
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 40, minHeight: 40),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 0,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),

      if (filter)
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/images/filter.svg",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        )
      else
        const SizedBox.shrink(),
    ]);
  }
}
