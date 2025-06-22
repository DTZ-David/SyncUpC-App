import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class CertificateCard extends StatelessWidget {
  final String title;
  final String place;
  final String date;
  final VoidCallback onDownload;

  const CertificateCard({
    super.key,
    required this.title,
    required this.place,
    required this.date,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body1(title),
          const SizedBox(height: 4),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/location.svg',
                height: 15,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: AppText.body2(
                  place,
                  color: AppColors.neutral700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Parte izquierda con ícono y fecha
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/calendar.svg',
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  AppText.body2(date),
                ],
              ),

              // Botón a la derecha
              DownloadCertificateButton(
                onPressed: onDownload,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DownloadCertificateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadCertificateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary500,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: AppText.body2(
            "Descargar certificado",
          ),
        ),
      ),
    );
  }
}
