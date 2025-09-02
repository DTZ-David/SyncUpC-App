import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/bookmarks/providers/bookmarks_providers.dart';
import 'package:syncupc/features/home/models/event_model.dart';

import '../../../utils/popup_utils.dart';

class BookmarkEvent extends ConsumerWidget {
  final EventModel event;

  const BookmarkEvent({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = event.eventStartDate;
    final day = DateFormat.E('es').format(date); // Ej: lun
    final dayNumber = DateFormat.d().format(date); // Ej: 24
    final month = DateFormat.MMM('es').format(date); // Ej: jul
    final time = DateFormat.Hm().format(date); // Ej: 14:30

    return GestureDetector(
      onTap: () {
        context.push(
          '/event/details',
          extra: event,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📅 Fecha
            SizedBox(
              width: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.body2(
                    day.toUpperCase(),
                  ),
                  AppText.heading3(
                    dayNumber,
                  ),
                  AppText.body1(
                    month.toUpperCase(),
                  ),
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

            // 📋 Info evento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body1(
                    event.eventTitle,
                  ),
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
                        child: AppText.body3(
                          event.campus.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
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
                      AppText.body3(
                        time,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // const SizedBox(width: 8),
            // GestureDetector(
            //   onTap: () async {
            //     try {
            //       await ref.read(removeSavedEventsProvider(event.id).future);
            //       PopupUtils.showSuccess(
            //         context,
            //         message: '¡Evento eliminado exitosamente!',
            //         subtitle: 'Tu evento ha sido actualizado',
            //         duration: const Duration(seconds: 2),
            //       );
            //       ref.invalidate(getSavedEventsProvider);
            //     } catch (e) {
            //       PopupUtils.showError(
            //         context,
            //         message: e.toString(),
            //         subtitle: 'Por favor intenta de nuevo',
            //         duration: const Duration(seconds: 2),
            //       );
            //     }
            //   },
            //   child: const Icon(Icons.favorite, color: Colors.red),
            // ),
          ],
        ),
      ),
    );
  }
}
