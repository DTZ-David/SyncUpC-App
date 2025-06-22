import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';

class EventDetailsScreen extends ConsumerWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendeeAvatars = [
      "https://randomuser.me/api/portraits/women/12.jpg",
      "https://randomuser.me/api/portraits/men/78.jpg",
      "https://randomuser.me/api/portraits/women/33.jpg",
      "https://randomuser.me/api/portraits/men/55.jpg",
      "https://randomuser.me/api/portraits/women/19.jpg",
    ];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Image.asset(
                "assets/images/banner.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText.heading3(
                      "Congreso de Innovación Estudiantil 2023",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 20),
                  child: Row(
                    children: [
                      _circleIcon('assets/images/share.svg'),
                      const SizedBox(width: 8),
                      _circleIcon('assets/images/foro.svg'),
                      const SizedBox(width: 8),
                      _circleIcon('assets/images/bookmark_01.svg'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.caption(
                      "172 personas asisten",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AttendeesAvatars(
                    avatars: attendeeAvatars,
                    totalAttendees: 173,
                    avatarRadius: 18,
                  )
                ],
              ),
            ),
            const _SectionTitle("Información del evento"),
            const _EventDetailRow(
              icon: 'assets/images/calendar.svg',
              text: "Lunes, 5 de mayo",
            ),
            const _EventDetailRow(
              icon: 'assets/images/clock_settings.svg',
              text: "6:00 PM",
              iconColor: AppColors.primary200,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
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
                          child: AppText.body3(
                            "Comedor Universitario, UPC Sabanas",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: AppText.body2(
                """🎓 Summer Camp 2025 — International Discovery Week\nHosted by Global Minds Academy & Oxford Heritage School\n\n🌍 TWO COUNTRIES, ONE UNFORGETTABLE EXPERIENCE!\nEste exclusivo campamento de verano ofrecerá a los estudiantes la oportunidad de explorar tanto la cultura inglesa como la japonesa en un solo programa.\n\n🎤 Ponente principal:\nProf. Amanda Kensington, directora académica con más de 20 años de experiencia internacional, compartirá su visión sobre el diseño del campamento y responderá preguntas de los padres.\n📚 Lo que aprenderás:\nCómo se integran las clases de robótica con excursiones culturales.\nDetalles sobre la experiencia inmersiva en Kioto y Cambridge.\nProceso de inscripción, becas y requisitos de idioma.\n💬 Traducción simultánea disponible en inglés, español y mandarín.\n🎁 ¡Los primeros 20 inscritos al seminario recibirán un kit exclusivo del campamento!""",
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _circleIcon(String icon) {
  return Container(
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
      ),
    ),
  );
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
