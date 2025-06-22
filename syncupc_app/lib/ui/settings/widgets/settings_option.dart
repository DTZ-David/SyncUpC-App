import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class SettingsOption extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.white,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      AppColors.neutral600,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: AppText.settings(title)),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFFDDDDDD), // gris claro
          height: 0,
          thickness: 1,
        ),
      ],
    );
  }
}
