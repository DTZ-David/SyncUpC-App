import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class BookmarkEvent extends StatelessWidget {
  final String day;
  final String date;
  final String month;
  final String title;
  final String location;
  final String time;
  final bool isFavorite;

  const BookmarkEvent({
    super.key,
    required this.day,
    required this.date,
    required this.month,
    required this.title,
    required this.location,
    required this.time,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📅 Fecha con ancho fijo
            SizedBox(
              width: 64, // Ajusta según lo que necesites
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(day,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(date,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  Text(month,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Línea divisoria
            Container(
              width: 1.5,
              height: 70,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 📋 Información del evento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/location.svg',
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          AppColors.neutral400,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(location,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.neutral400),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/clock.svg',
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          AppColors.neutral800,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(time,
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.neutral400)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.grey.shade300,
            )
          ],
        ));
  }
}
