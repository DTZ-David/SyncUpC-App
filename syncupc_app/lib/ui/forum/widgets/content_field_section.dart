import 'package:flutter/material.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';

import '../../../design_system/atoms/app_text.dart';

class ContentFieldSection extends StatelessWidget {
  final TextEditingController controller;

  const ContentFieldSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body1("Contenido"),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          maxLines: 8,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor agrega algo de contenido';
            }
            if (value.trim().length < 20) {
              return 'Cuentanos un poco mas...';
            }
            return null;
          },
          hintText: "Comparte tus pensamientos, preguntas o ideas...",
        ),
      ],
    );
  }
}
