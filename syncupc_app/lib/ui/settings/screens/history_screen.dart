import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/ui/settings/widgets/certificate_card.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading1("Mi historial y Certificaciones"),
              const SizedBox(height: 16),
              CertificateCard(
                title: "Exposoftware",
                place: "UPC Sabanas",
                date: "11/11/2024",
                onDownload: () {
                  // Acción al presionar el botón
                },
              ),
              const SizedBox(height: 12),
              CertificateCard(
                title: "Concierto de Rock en Bellas Artes",
                place: "UPC Bellas Artes – Salón de Música",
                date: "12/05/2025",
                onDownload: () {
                  // Acción al presionar el botón
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
