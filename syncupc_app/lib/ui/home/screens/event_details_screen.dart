import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';
import 'package:syncupc/utils/popup_utils.dart';
import '../../../features/bookmarks/providers/bookmarks_providers.dart';
import '../../../features/home/models/event_model.dart';
import '../widgets/expandable_title.dart';

class EventDetailsScreen extends ConsumerWidget {
  final EventModel event;

  const EventDetailsScreen(this.event, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary200,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AttendanceConfirmationPopup(
              title: "Confirmamos tu asistencia",
            ),
          );
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: (event.imageUrls.isEmpty ||
                        event.imageUrls.first.isEmpty)
                    ? Center(
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.network(
                        event.imageUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
              Column(
                children: [
                  // Contenedor principal del encabezado del evento
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título expandible
                        ExpandableTitle(
                          title: event.eventTitle,
                          maxLines: 2,
                        ),

                        const SizedBox(height: 16),

                        // Información de asistentes y botones en una sola fila
                        Row(
                          children: [
                            // Avatares y contador de asistentes
                            AttendeesAvatars(
                              avatars: event.participantProfilePictures,
                              totalAttendees:
                                  event.participantProfilePictures.length,
                              avatarRadius: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AppText.caption(
                                "${event.participantProfilePictures.length} personas asisten",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Botones de acción
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _circleIconButton(
                                  icon: 'assets/images/share.svg',
                                  onTap: () {},
                                ),
                                const SizedBox(width: 8),
                                _circleIconButton(
                                  icon: 'assets/images/foro.svg',
                                  onTap: () {
                                    context.push('/event/forum', extra: event);
                                  },
                                ),
                                const SizedBox(width: 8),
                                _circleIconButton(
                                  icon: 'assets/images/bookmark_01.svg',
                                  color: event.isSaved
                                      ? AppColors.primary200
                                      : AppColors.neutral400,
                                  onTap: () async {
                                    try {
                                      await ref.read(
                                          addEventFavProvider(event.id).future);
                                      PopupUtils.showSuccess(
                                        context,
                                        message:
                                            '¡Evento guardado exitosamente!',
                                        subtitle:
                                            'Tu evento ha sido actualizado',
                                        duration: const Duration(seconds: 2),
                                      );
                                    } catch (e) {
                                      PopupUtils.showError(
                                        context,
                                        message: e.toString(),
                                        subtitle: 'Por favor intenta de nuevo',
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Separador visual
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),

                  const SizedBox(height: 8),

                  // Resto del contenido (información del evento, etc.)
                  const _SectionTitle("Información del evento"),
                  _EventDetailRow(
                    icon: 'assets/images/calendar.svg',
                    text: capitalizeFirstLetter(
                        DateFormat('EEEE, d \'de\' MMMM', 'es')
                            .format(event.eventStartDate)),
                  ),
                  _EventDetailRow(
                    icon: 'assets/images/clock_settings.svg',
                    text: DateFormat('h:mma', 'es')
                        .format(event.eventStartDate)
                        .toLowerCase(),
                    iconColor: AppColors.primary200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/location.svg',
                          width: 22,
                          height: 22,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary200,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.body3(event.address),
                              AppText.body3(event.eventLocation),
                            ],
                          ),
                        ),
                        AppText.body3(
                          "¿Cómo llegar?",
                          color: AppColors.primary200,
                        ),
                      ],
                    ),
                  ),
                  const _SectionTitle("Detalles del evento"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.body1(
                          event.eventObjective,
                        ),
                        const SizedBox(height: 8),
                        AppText.body2(
                          event.additionalDetails,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _circleIconButton({
  required String icon,
  required VoidCallback onTap,
  Color? color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          fit: BoxFit.scaleDown,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        ),
      ),
    ),
  );
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.topLeft,
        child: AppText.subtitle2(
          text,
          maxLines: 1,
          color: AppColors.neutral900,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _EventDetailRow extends StatelessWidget {
  final String icon;
  final String text;
  final Color? iconColor;

  const _EventDetailRow({
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                : null,
          ),
          const SizedBox(width: 6),
          AppText.body2(text),
        ],
      ),
    );
  }
}
