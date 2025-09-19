import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';
import 'package:syncupc/utils/popup_utils.dart';
import '../../../features/attendance/providers/register_event_state.dart';
import '../../../features/bookmarks/providers/bookmarks_state_providers.dart'; // Tu nuevo provider
import '../../../features/home/models/event_model.dart';
import '../../../features/home/providers/event_providers.dart';
import '../widgets/expandable_title.dart';

class EventDetailsScreen extends ConsumerWidget {
  final EventModel event;

  const EventDetailsScreen(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerEventStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (event.isUserRegistered && !registerState.isRegistered) {
        ref
            .read(registerEventStateProvider.notifier)
            .setInitialRegistrationStatus(true);
      }
    });

    // Escuchar cambios para mostrar mensajes
    ref.listen(registerEventStateProvider, (previous, next) {
      if (next.isSuccess && (previous?.isSuccess != true)) {
        if (next.isRegistered) {
          PopupUtils.showSuccess(
            context,
            message: '¡Registraste tu asistencia al evento!',
            duration: const Duration(seconds: 2),
          );
        } else {
          PopupUtils.showSuccess(
            context,
            message: '¡Cancelaste tu registro al evento!',
            duration: const Duration(seconds: 2),
          );
        }
      }

      if (next.error != null && (previous?.error != next.error)) {
        String errorMessage = "Error al procesar registro";

        if (next.error!.contains("401")) {
          errorMessage = "Sesión expirada. Inicia sesión nuevamente";
        } else if (next.error!.contains("403")) {
          errorMessage = "No tienes permisos para esta acción";
        } else if (next.error!.contains("Ya estás registrado")) {
          errorMessage = "Ya estás registrado en este evento";
        }

        PopupUtils.showError(
          context,
          message: errorMessage,
          duration: const Duration(seconds: 3),
        );
      }
    });
    // Inicializar el estado de bookmarks con el evento actual si está guardado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (event.isSaved) {
        ref.read(bookmarksStateProvider.notifier).addBookmark(event.id);
      }
    });
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableTitle(
                          title: event.eventTitle,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
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
                                _buildBookmarkButton(context, ref),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 8),
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
                              AppText.body3(event.space.name),
                              AppText.body3(event.campus.name),
                            ],
                          ),
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
                        AppText.body1(event.eventObjective),
                        const SizedBox(height: 8),
                        AppText.body2(
                          event.additionalDetails,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child:
                        _buildRegistrationButton(context, ref, registerState),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(bookmarksStateProvider).contains(event.id);
    final bookmarkToggleAsync = ref.watch(bookmarkToggleProvider(event.id));

    return GestureDetector(
      onTap: bookmarkToggleAsync.isLoading
          ? null
          : () => _handleBookmarkTap(context, ref),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: bookmarkToggleAsync.isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isBookmarked
                          ? AppColors.primary200
                          : AppColors.neutral400,
                    ),
                  ),
                )
              : SvgPicture.asset(
                  'assets/images/bookmark_01.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    isBookmarked ? AppColors.primary200 : AppColors.neutral400,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      ),
    );
  }

  void _handleRegister(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(registerEventStateProvider.notifier)
          .registerToEvent(event.id);
    } catch (e) {
      // El error ya se maneja en el ref.listen
    }
  }

  void _handleUnregister(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(registerEventStateProvider.notifier)
          .unregisterFromEvent(event.id);
      ref.invalidate(getAllEventsForUProvider);
      ref.invalidate(getAllEventsProvider);
    } catch (e) {
      // El error ya se maneja en el ref.listen
    }
  }

  Widget _buildRegistrationButton(
    BuildContext context,
    WidgetRef ref,
    RegisterEventStateData registerState,
  ) {
    // Si el evento NO requiere registro, no mostrar botón
    if (!event.requiresRegistration) {
      return const SizedBox.shrink();
    }

    // Si está registrado, mostrar botón para cancelar
    if (registerState.isRegistered || event.isUserRegistered) {
      return PrimaryButton(
        text: "Cancelar registro",
        variant: ButtonVariant.outlined,
        isLoading: registerState.isLoading,
        isDisabled: registerState.isLoading,
        onPressed: () => _handleUnregister(context, ref),
      );
    }
    // Si NO está registrado, mostrar botón para registrarse
    else {
      return PrimaryButton(
        text: "Registrate",
        variant: ButtonVariant.filled,
        isLoading: registerState.isLoading,
        isDisabled: registerState.isLoading,
        onPressed: () => _handleRegister(context, ref),
      );
    }
  }

  void _handleBookmarkTap(BuildContext context, WidgetRef ref) async {
    final bookmarkToggle = ref.read(bookmarkToggleProvider(event.id).notifier);
    final isCurrentlyBookmarked =
        ref.read(bookmarksStateProvider).contains(event.id);

    try {
      await bookmarkToggle.toggle();

      if (context.mounted) {
        if (!isCurrentlyBookmarked) {
          PopupUtils.showSuccess(
            context,
            message: '¡Evento guardado exitosamente!',
            subtitle: 'Tu evento ha sido agregado a favoritos',
            duration: const Duration(seconds: 2),
          );
        } else {
          PopupUtils.showSuccess(
            context,
            message: '¡Evento removido de favoritos!',
            subtitle: 'El evento ya no está en tus favoritos',
            duration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        PopupUtils.showError(
          context,
          message: 'Error al actualizar favoritos',
          subtitle: 'Por favor intenta de nuevo',
          duration: const Duration(seconds: 2),
        );
      }
    }
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
