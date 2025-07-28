import 'package:flutter/material.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';

class TitleFieldSection extends StatelessWidget {
  final TextEditingController controller;

  const TitleFieldSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body1("Titulo"),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor ingresa un titulo';
            }
            if (value.trim().length < 5) {
              return 'El titulo debe ser mas largo';
            }
            return null;
          },
          hintText: "¿Que te gustaria dicutir?",
        ),
      ],
    );
  }
}
