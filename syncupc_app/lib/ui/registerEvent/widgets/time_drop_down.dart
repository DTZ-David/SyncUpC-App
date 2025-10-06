import 'package:flutter/material.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';

class TimeDropdown extends StatelessWidget {
  final String? value;
  final void Function(String?) onChanged;
  final List<String> items;

  const TimeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        menuMaxHeight: 300,
        onChanged: onChanged,
        items: items.map((time) {
          return DropdownMenuItem(
            value: time,
            child: AppText.body3(time),
          );
        }).toList(),
      ),
    );
  }
}
